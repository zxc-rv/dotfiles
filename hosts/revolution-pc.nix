{ ... }:

{
  imports = [
    ../nvidia.nix
  ];

  networking.hostName = "revolution-pc";

  fileSystems."/mnt/vault" = {
    device = "/dev/disk/by-uuid/F09803759803399C";
    fsType = "ntfs3";
    options = [
      "uid=1000"
      "gid=100"
      "umask=022"
      "x-gvfs-show"
    ];
  };
}
