{ pkgs, username, ... }:
{
    imports = [
        ./steam
        ./wine
    ];

    hardware.graphics = {
        enable = true;
    };

    services.xserver.videoDrivers = ["amdgpu"];

    # home.packages = with pkgs; [
    # ];
    environment.systemPackages = with pkgs; [
        heroic
        bottles
        vulkan-tools
    ];
}