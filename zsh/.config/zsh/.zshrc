
# ~/.config/zsh/.zshrc
# macOS — AI-first GitOps workstation

[[ -o interactive ]] || return

# --------------------------------------------------
# History
# --------------------------------------------------

[[ -d $XDG_STATE_HOME/zsh && -d $XDG_CACHE_HOME/zsh ]] ||
  mkdir -p "$XDG_STATE_HOME/zsh" "$XDG_CACHE_HOME/zsh"

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=20000
SAVEHIST=20000

setopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt HIST_NO_STORE

# --------------------------------------------------
# Completion
# --------------------------------------------------

autoload -Uz compinit
# Full check at most once a day, or when brew adds completions; otherwise trust the cached dump
() {
  setopt local_options extended_glob
  local dump="$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
  local site="${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh/site-functions"
  if [[ ! -s $dump || -n $dump(#qN.mh+24) || ( -d $site && $site -nt $dump ) ]]; then
    compinit -d "$dump"
  else
    compinit -C -d "$dump"
  fi
}

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
# Cached tool init
# --------------------------------------------------

# Source "<cmd> init" output from a cache, regenerated when the binary changes
_cache_init() {  # usage: _cache_init <name> <cmd...>
  local f="$XDG_CACHE_HOME/zsh/init-$1.zsh" bin=${commands[$2]}
  [[ -n $bin ]] || return
  [[ -s $f && $f -nt ${bin:A} ]] || "${@:2}" >| "$f"
  source "$f"
}

# --------------------------------------------------
# fzf
# --------------------------------------------------
[[ -f "$ZDOTDIR/fzf.zsh" ]] && source "$ZDOTDIR/fzf.zsh"

_cache_init fzf fzf --zsh

# --------------------------------------------------
# zoxide
# --------------------------------------------------

_cache_init zoxide zoxide init --cmd cd zsh

# --------------------------------------------------
# Autosuggestions
# --------------------------------------------------

for _f in "${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" \
          /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
          /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh; do
  if [[ -f $_f ]]; then
    source "$_f"
    break
  fi
done
unset _f

# --------------------------------------------------
# Starship
# --------------------------------------------------

_cache_init starship starship init zsh --print-full-init

# --------------------------------------------------
# Atuin
# --------------------------------------------------

_cache_init atuin atuin init zsh

unfunction _cache_init

# --------------------------------------------------
# Fastfetch — terminal welcome screen (top-level terminals only)
# --------------------------------------------------

if (( $+commands[fastfetch] )) &&
   [[ -t 1 && -z $TMUX && -z $NVIM && $SHLVL -eq 1 && $TERM_PROGRAM != vscode ]]; then
  fastfetch
fi
