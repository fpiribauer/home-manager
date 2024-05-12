
{pkgs, ...}: {
  services.mako = {
    enable = true;
    anchor = "top-center";
    defaultTimeout = 5000;
  };
}
