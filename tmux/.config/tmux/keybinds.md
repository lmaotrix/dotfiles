# tmux Keybindings

This document lists the custom keybindings defined in the tmux configuration (`~/.config/tmux/tmux.conf`) for use with Alacritty on Arch Linux in WSL on Windows 11. The prefix key is `Ctrl-s`, and copy mode uses vi keybindings. Plugins include `tmux-plugins/tpm` and `christoomey/vim-tmux-navigator`.

## Prefix Keybindings
These are activated by pressing `Ctrl-s` followed by the specified key.

| Keybinding | Command | Description |
|------------|---------|-------------|
| `Ctrl-s r` | `source-file ~/.config/tmux/tmux.conf \; display-message "== TMUX Config File Sourced!!! == "` | Reloads the tmux configuration file and displays a confirmation message. |
| `Ctrl-s c` | `new-window -c "#{pane_current_path}"` | Creates a new window, inheriting the current pane’s working directory. |
| `Ctrl-s "` | `split-window -c "#{pane_current_path}"` | Splits the current pane vertically (new pane below), inheriting the current directory. |
| `Ctrl-s %` | `split-window -h -c "#{pane_current_path}"` | Splits the current pane horizontally (new pane to the right), inheriting the current directory. |
| `Ctrl-s i` | `split-window -h` | Splits the current pane horizontally (new pane to the right). Note: Redundant with `Ctrl-s %` but does not inherit the current directory. |
| `Ctrl-s h` | `select-pane -L` | Selects the pane to the left of the current pane. |
| `Ctrl-s j` | `select-pane -D` | Selects the pane below the current pane. |
| `Ctrl-s k` | `select-pane -U` | Selects the pane above the current pane. |
| `Ctrl-s l` | `select-pane -R` | Selects the pane to the right of the current pane. |
| `Ctrl-s C-_` | `display-popup -d "#{pane_current_path}" -w 80% -h 80%` | Opens a popup window (80% width and height) in the current pane’s directory. |
| `Ctrl-s I` | TPM plugin installation | Installs plugins listed in `tmux.conf` (e.g., `vim-tmux-navigator`). |

## Copy Mode Keybindings (vi Mode)
Enter copy mode with `Ctrl-s [`. These bindings use vi-style navigation, as `mode-keys` is set to `vi`. Selections are copied to the Windows clipboard via `clip.exe` for WSL compatibility.

| Keybinding | Command | Description |
|------------|---------|-------------|
| `v` | `send-keys -X begin-selection` | Starts text selection in copy mode (like visual mode in Vim). |
| `y` | `send-keys -X copy-pipe-and-cancel "/mnt/c/Windows/System32/clip.exe"` | Copies selected text to the Windows clipboard and exits copy mode. |
| `Enter` | `send-keys -X copy-pipe-and-cancel "/mnt/c/Windows/System32/clip.exe"` | Copies selected text to the Windows clipboard and exits copy mode. |
| `MouseDragEnd1Pane` | `send-keys -X copy-pipe-and-cancel "/mnt/c/Windows/System32/clip.exe"` | Copies mouse-selected text to the Windows clipboard and exits copy mode. Requires `set-option -g mouse on`. |

### Copy Mode Usage
- Enter copy mode: `Ctrl-s [`.
- Navigate with vi keys (`h/j/k/l` for left/down/up/right).
- Select text with `v`, move, then copy with `y` or `Enter`.
- For mouse: Drag to select, release to copy.
- Paste in Windows apps with `Ctrl+V`.

## Pane Navigation Keybindings (`vim-tmux-navigator`)
These keybindings, provided by the `vim-tmux-navigator` plugin, allow seamless navigation between tmux panes and Neovim splits/windows using the same keys. They work without the prefix in tmux and in Neovim’s normal mode (if configured).

| Keybinding | Command | Description |
|------------|---------|-------------|
| `Ctrl-h` | `:TmuxNavigateLeft` (Neovim) / `select-pane -L` (tmux) | Moves focus to the pane or Neovim split/window to the left. |
| `Ctrl-j` | `:TmuxNavigateDown` / `select-pane -D` | Moves focus to the pane or split/window below. |
| `Ctrl-k` | `:TmuxNavigateUp` / `select-pane -U` | Moves focus to the pane or split/window above. |
| `Ctrl-l` | `:TmuxNavigateRight` / `select-pane -R` | Moves focus to the pane or split/window to the right. |

### Neovim Configuration
For `vim-tmux-navigator` to work in Neovim, ensure the following Lua config is in `~/.config/nvim/init.lua` or a plugin file:
```lua
vim.g.tmux_navigator_no_mappings = 1
vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<CR>', { silent = true })
vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<CR>', { silent = true })
vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<CR>', { silent = true })
vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<CR>', { silent = true })
```

## Notes
- **Prefix**: All prefix keybindings start with `Ctrl-s`. If `Ctrl-s` is intercepted (e.g., by Alacritty or shell for flow control), add `stty -ixon` to `~/.bashrc` or `~/.zshrc` to disable flow control.
- **Mouse Support**: Enabled with `set-option -g mouse on`. Click to select panes, drag to resize, or drag to select text in copy mode.
- **Clipboard in WSL**: Copied text goes to the Windows clipboard (`clip.exe`). Paste into tmux with `Ctrl+V` or right-click in Alacritty/Windows Terminal.
- **Alacritty**: Ensure `TERM: alacritty` in Alacritty’s config (`alacritty.yml` or `alacritty.toml`). If terminfo is missing, install it or use `TERM: xterm-256color`.
- **Conflicts**: If `Ctrl-h/j/k/l` don’t work, check for conflicts in Neovim (`:map <C-h>`), shell (e.g., `Ctrl-l` for clear screen), or Alacritty. Unbind shell conflicts with `bind -r '\C-l'` in `~/.bashrc` or `~/.zshrc`.

## Saving This File
Save this Markdown file as `tmux_keybindings.md` in a convenient location, e.g., `~/.config/tmux/` or `~/Documents/`. To view in a formatted way, open it in a Markdown viewer or editor like Neovim, VS Code, or a browser with a Markdown plugin.
