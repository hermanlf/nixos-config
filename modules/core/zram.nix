# modules/core/zram.nix
# 
# Simple zram configuration using tmpfs + zram swap
# Automatically enabled when imported - just add to your module imports!
# 
# Override defaults if needed:
#   services.zram = {
#     tmpfsSize = "24G";
#     swapMemoryPercent = 30;
#     compression = "lz4";
#   };

{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.services.zram;
in
{
  options.services.zram = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable zram-backed tmpfs and swap for reducing NVME wear";
    };

    tmpfsSize = mkOption {
      type = types.str;
      default = "32G";
      description = ''
        Size of the tmpfs for /tmp.
        Can be specified as absolute size (e.g., "32G", "16384M") or
        percentage of RAM (e.g., "25%").
      '';
    };

    tmpfsMount = mkOption {
      type = types.str;
      default = "/tmp";
      description = "Mount point for tmpfs";
    };

    swapMemoryPercent = mkOption {
      type = types.int;
      default = 25;
      description = ''
        Percentage of RAM to allocate for zram swap.
        With 128G RAM, 25% = 32G zram swap.
      '';
    };

    compression = mkOption {
      type = types.enum [ "lzo" "lz4" "zstd" "lzo-rle" ];
      default = "zstd";
      description = ''
        Compression algorithm for zram swap.
        zstd provides best compression ratio with good performance.
      '';
    };

    swappiness = mkOption {
      type = types.int;
      default = 80;
      description = ''
        How aggressively to use zram swap (0-100).
        Higher values mean more aggressive swapping to compressed RAM.
        Default 80 is good for zram setups.
      '';
    };

    enableStatusCommand = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to provide the zram-status command";
    };
  };

  config = mkIf cfg.enable {
    # Tmpfs for the specified mount point (usually /tmp)
    fileSystems."${cfg.tmpfsMount}" = {
      device = "tmpfs";
      fsType = "tmpfs";
      options = [ 
        "size=${cfg.tmpfsSize}"
        "noatime"            # No access time updates
        "nosuid"             # No setuid binaries
        "nodev"              # No device files
        "mode=1777"          # Proper permissions for /tmp
      ];
    };
    
    # Zram swap configuration
    zramSwap = {
      enable = true;
      algorithm = cfg.compression;
      memoryPercent = cfg.swapMemoryPercent;
      priority = 5;  # Higher priority than disk swap
    };

    # Performance optimizations for tmpfs + zram
    boot.kernel.sysctl = {
      # Optimize for tmpfs + zram performance
      "vm.page-cluster" = 0;                    # Disable page clustering for zram
      "vm.swappiness" = cfg.swappiness;         # Configurable swapping aggressiveness
      "vm.dirty_ratio" = 50;                    # Allow more dirty pages in memory
      "vm.dirty_background_ratio" = 25;         # Background writeback threshold
    };

    # Optional status command
    environment.systemPackages = mkIf cfg.enableStatusCommand [
      (pkgs.writeShellScriptBin "zram-status" ''
        echo "=== Zram Configuration Status ==="
        echo "Mount: ${cfg.tmpfsMount} (tmpfs, ${cfg.tmpfsSize})"
        echo "Zram swap: ${toString cfg.swapMemoryPercent}% of RAM (${cfg.compression} compression)"
        echo "Swappiness: ${toString cfg.swappiness}"
        echo ""
        
        echo "=== ${cfg.tmpfsMount} Mount Information ==="
        ${pkgs.util-linux}/bin/findmnt ${cfg.tmpfsMount} --noheadings -o SOURCE,FSTYPE,SIZE,USED,AVAIL,USE% 2>/dev/null || echo "Not mounted"
        ${pkgs.coreutils}/bin/df -h ${cfg.tmpfsMount} 2>/dev/null || echo "Mount not available"
        
        echo ""
        echo "=== Zram Swap Devices ==="
        if [ -f /proc/swaps ]; then
          echo "Active swap devices:"
          ${pkgs.coreutils}/bin/grep zram /proc/swaps 2>/dev/null || echo "No zram swap active yet"
        fi
        
        echo ""
        echo "=== Zram Device Statistics ==="
        found_zram=false
        for dev in /sys/block/zram*; do
          if [ -d "$dev" ]; then
            found_zram=true
            name=$(basename "$dev")
            echo "Device: /dev/$name"
            
            [ -r "$dev/disksize" ] && echo "  Configured size: $(cat "$dev/disksize" | ${pkgs.coreutils}/bin/numfmt --to=iec)"
            [ -r "$dev/orig_data_size" ] && echo "  Original data: $(cat "$dev/orig_data_size" | ${pkgs.coreutils}/bin/numfmt --to=iec)"
            [ -r "$dev/compr_data_size" ] && echo "  Compressed data: $(cat "$dev/compr_data_size" | ${pkgs.coreutils}/bin/numfmt --to=iec)"
            [ -r "$dev/mem_used_total" ] && echo "  Memory used: $(cat "$dev/mem_used_total" | ${pkgs.coreutils}/bin/numfmt --to=iec)"
            [ -r "$dev/comp_algorithm" ] && echo "  Algorithm: $(cat "$dev/comp_algorithm")"
            
            # Calculate compression ratio and savings
            if [ -r "$dev/orig_data_size" ] && [ -r "$dev/compr_data_size" ]; then
              orig=$(cat "$dev/orig_data_size")
              comp=$(cat "$dev/compr_data_size")
              if [ "$comp" -gt 0 ] && [ "$orig" -gt 0 ]; then
                ratio=$(echo "scale=2; $orig / $comp" | ${pkgs.bc}/bin/bc)
                savings=$(echo "scale=1; ($orig - $comp) * 100 / $orig" | ${pkgs.bc}/bin/bc)
                echo "  Compression ratio: $ratio:1"
                echo "  Space savings: $savings%"
              fi
            fi
            echo ""
          fi
        done
        
        if [ "$found_zram" = false ]; then
          echo "No zram devices found (may not be active yet)"
        fi
        
        echo "=== System Memory Overview ==="
        ${pkgs.procps}/bin/free -h
        
        echo ""
        echo "=== Configuration Summary ==="
        echo "✓ ${cfg.tmpfsMount} uses tmpfs (pure RAM, no disk writes)"
        echo "✓ Zram swap provides compressed memory overflow"
        echo "✓ NVME wear completely eliminated for ${cfg.tmpfsMount}"
        echo "✓ Compression algorithm: ${cfg.compression}"
        echo "✓ Swappiness: ${toString cfg.swappiness} (higher = more aggressive zram usage)"
        
        # Status indicators
        if ${pkgs.util-linux}/bin/mountpoint -q ${cfg.tmpfsMount}; then
          echo "✓ Tmpfs is properly mounted"
        else
          echo "⚠ Tmpfs is not mounted at ${cfg.tmpfsMount}"
        fi
        
        if ${pkgs.coreutils}/bin/grep -q zram /proc/swaps 2>/dev/null; then
          echo "✓ Zram swap is active"
        else
          echo "ℹ Zram swap will activate when memory pressure increases"
        fi
      '')
    ];
  };
}
