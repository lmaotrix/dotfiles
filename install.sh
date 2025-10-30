# define dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# install dependencies
echo "Installing dependencies..."
sudo pacman -S --needed zsh neovim starship tmux stow fzf

# use stow to symlink dotfiles
cd "$DOTFILES_DIR" || exit
stow bash zsh nvim tmux starship

echo "Dotfiles installed! source your shell config to apply changes."
