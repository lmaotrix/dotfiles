# Set Oh My Zsh directory
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export LC_ALL=en_US.UTF-8

# 🎨 Theme (Oh My Zsh)
ZSH_THEME="robbyrussell"

# 🧩 Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-completions
  zsh-syntax-highlighting  # ← Always last
)

# 📦 Source Oh My Zsh (plugins and theme)
source "$ZSH/oh-my-zsh.sh"

# 🧭 Zoxide
eval "$(zoxide init zsh)"


# ⚙️ Shell options
setopt COMPLETE_ALIASES
setopt HIST_FIND_NO_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE INC_APPEND_HISTORY SHARE_HISTORY APPEND_HISTORY
setopt AUTOCd EXTENDEDGLOB NOMATCH NOTIFY
unsetopt BEEP

# 🎹 Key bindings
bindkey -e

# 🧠 Completions
autoload -Uz compinit promptinit bashcompinit
compinit -u
promptinit
bashcompinit

# 🚀 Starship
eval "$(starship init zsh)"

# Start SSH agent automatically
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/id_ed25519 > /dev/null 2>&1
fi

# 🌈 Aliases
alias ls='eza --no-user --no-time --no-permissions --icons=always'
alias ll='eza -la --no-user --no-time --no-permissions --icons=always'
alias lt='eza -T --icons=always'
alias nv="nvim"
alias tree='ls --tree'
alias rm='rm -i'
alias mirrorUpdate='reflector --country us --latest 15 --protocol https --sort rate --save /etc/pacman.d/mirrorlist --verbose'

cd ~
