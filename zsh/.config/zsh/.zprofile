# ~/.config/zsh/.zprofile

# Homebrew — Apple silicon, Intel, Linuxbrew
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [[ -x $_brew ]]; then
    eval "$($_brew shellenv)"
    break
  fi
done
unset _brew

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Homebrew
export HOMEBREW_NO_ENV_HINTS=1

# Atuin 
export ATUIN_CONFIG_DIR="$XDG_CONFIG_HOME/atuin"

# User executables
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)
