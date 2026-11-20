# ~/.config/zsh/fzf.zsh

# Default file discovery
if (( $+commands[fd] )); then
  export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type=d --hidden --strip-cwd-prefix --exclude .git'

  _fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
  }

  _fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
  }
fi

# Previews
if (( $+commands[bat] )); then
  export FZF_CTRL_T_OPTS="--preview '[[ -d {} ]] && eza --tree --color=always {} | head -200 || bat -n --color=always --line-range :500 {}'"
fi

if (( $+commands[eza] )); then
  export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
fi

# Catppuccin Macchiato
export FZF_DEFAULT_OPTS="
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796
"

