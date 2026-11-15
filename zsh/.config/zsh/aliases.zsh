
# ~/.config/zsh/aliases.zsh

# --------------------------------------------------
# Editor
# --------------------------------------------------

alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias svim='sudoedit'

# --------------------------------------------------
# Files
# --------------------------------------------------

if (( $+commands[eza] )); then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -lah --icons --group-directories-first'
  alias la='eza -la --icons --group-directories-first'
else
  alias ll='ls -lah'
  alias la='ls -la'
fi

# --------------------------------------------------
# Git
# --------------------------------------------------

alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gpt='git push --tags'
alias gb='git branch'
alias grb='git branch -r'
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout'
alias gl='git log --oneline'
alias glol='git log --graph --oneline --decorate'
alias gr='git remote'
alias grs='git remote show'
alias gplo='git pull origin'
alias gpraise='git blame'

# Git TUI
alias lg='lazygit'

# --------------------------------------------------
# Kubernetes
# --------------------------------------------------

alias k='kubectl'
alias kd='kubectl describe'
alias kgp='kubectl get pods'
alias kgpa='kubectl get pods -A'
alias kgn='kubectl get nodes -o wide'

# Kubernetes TUI
alias k9='k9s'

# Flux TUI 
alias f9='flux9s'

# --------------------------------------------------
# Networking
# --------------------------------------------------

alias xip='curl -fsS https://api.ipify.org'

