{ config, pkgs, ... }:
{
  services = {
    xserver.videoDrivers = [ "nvidia" ];
    # lact.enable = true;
  };
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;
  };

  systemd.services.nvidia-clock-lock = {
    description = "Lock NVIDIA min clocks";
    wantedBy = [ "multi-user.target" ];
    after = [ "nvidia-persistenced.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "nvidia-clock-lock" ''
        ${config.boot.kernelPackages.nvidiaPackages.latest.bin}/bin/nvidia-smi -pm 1
        ${config.boot.kernelPackages.nvidiaPackages.latest.bin}/bin/nvidia-smi -lgc 405,1920
        ${config.boot.kernelPackages.nvidiaPackages.latest.bin}/bin/nvidia-smi -lmc 5001,9501
      '';
    };
  };
}
