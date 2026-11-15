
# ~/.config/zsh/.zshrc
# macOS — AI-first GitOps workstation

[[ -o interactive ]] || return

# --------------------------------------------------
# History
# --------------------------------------------------

HISTFILE="$ZDOTDIR/.zhistory"
HISTSIZE=20000
SAVEHIST=20000

setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# --------------------------------------------------
# Completion
# --------------------------------------------------

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# --------------------------------------------------
# Keybindings
# --------------------------------------------------

bindkey -e

# CTRL + Arrow
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# ALT + Arrow
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

# --------------------------------------------------
# Aliases
# --------------------------------------------------

[[ -f "$ZDOTDIR/aliases.zsh" ]] &&
  source "$ZDOTDIR/aliases.zsh"

# --------------------------------------------------
# fzf
# --------------------------------------------------
[[ -f "$ZDOTDIR/fzf.zsh" ]] && source "$ZDOTDIR/fzf.zsh"

if (( $+commands[fzf] )); then
  eval "$(fzf --zsh)"
fi

# --------------------------------------------------
# zoxide
# --------------------------------------------------

if (( $+commands[zoxide] )); then
  eval "$(zoxide init --cmd cd zsh)"
fi

# --------------------------------------------------
# Autosuggestions
# --------------------------------------------------

if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# --------------------------------------------------
# Starship
# --------------------------------------------------

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

# --------------------------------------------------
# Atuin
# --------------------------------------------------

if (( $+commands[atuin] )); then
  eval "$(atuin init zsh)"
fi

# --------------------------------------------------
# Fastfetch — terminal welcome screen
# --------------------------------------------------

if [[ -o interactive ]] && (( $+commands[fastfetch] )); then
  fastfetch
fi
