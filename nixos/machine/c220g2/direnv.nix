# Direnv

{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.direnv ];

  environment.interactiveShellInit = ''
    run_direnv_hook() {
      if [ -n "$BASH_VERSION" ]; then
        eval "$(direnv hook bash)"
      elif [ -n "$ZSH_VERSION" ]; then
        eval "$(direnv hook zsh)"
      fi
    }

    case "$-" in *i*) run_direnv_hook ;; esac
  '';
}
