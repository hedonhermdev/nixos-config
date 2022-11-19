# Pre-built binary compatibility
#
# For VSCode Server, etc.

{ pkgs, lib, inputs, ... }:
let
  impureLibraryPath = with pkgs; lib.makeLibraryPath [
    stdenv.cc.cc
  ];
in {
  imports = [
    inputs.nix-ld.nixosModules.nix-ld
  ];

  environment.sessionVariables = {
    NIX_LD = lib.mkIf (pkgs.system == "x86_64-linux") "${pkgs.glibc}/lib64/ld-linux-x86-64.so.2";
    NIX_LD_LIBRARY_PATH = impureLibraryPath;
  };

  # HACK for VSCode
  #
  # LD_LIBRARY_PATH injected by nix-ld is propagated to child processes,
  # including interactive shells in VSCode. This silently pollutes nix-shell
  # environments :(
  environment.interactiveShellInit = ''
    if [ -n "$VSCODE_IPC_HOOK_CLI" -a x"$LD_LIBRARY_PATH" = x"${impureLibraryPath}" ]; then
        unset LD_LIBRARY_PATH
    fi
  '';
}
