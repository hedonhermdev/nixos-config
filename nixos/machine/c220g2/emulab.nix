# Emulab-specific stuff
{
  hardware.emulab = {
    enable = true;

    # Clean up the filesystem when disk imaging is initiated
    enableLustrate = true;
    allowedImpurities = [
      # Impure paths that will go into the disk image
    ];
  };

  services.miniond.configuration = {
    tmcc.report-shutdown = false;
  };
}
