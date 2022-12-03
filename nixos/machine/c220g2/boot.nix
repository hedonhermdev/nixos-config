# Boot

{
  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
  ];

  boot.loader.grub = {
    enable = true;
    version = 2;

    extraEntries = ''
      menuentry "Custom kernel in /kernel.mb2" {
        set root=(hd0,msdos1)
        set kernel='/kernel.mb2'
        echo "Loading ''${kernel}..."
        multiboot2 ''${kernel}
        module2 ''${kernel} redleaf_kernel
        boot
      }
    '';
  };
}
