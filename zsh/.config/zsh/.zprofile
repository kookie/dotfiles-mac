# ~/.config/zsh/.zprofile

# Homebrew — Apple silicon
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Homebrew
export HOMEBREW_NO_ENV_HINTS=1

# BAT THEME 
export BAT_THEME="Catppuccin Macchiato"

# Atuin 
export ATUIN_CONFIG_DIR="$HOME/.config/atuin"

# Avoid duplicate PATH entries
typeset -U path PATH

# User executables
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)

