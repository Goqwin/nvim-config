# Tmux Commands

## Session Management
- **Start a new tmux session**: `tmux`
- **Start a new named session**: `tmux new -s session_name`
- **List all sessions**: `tmux ls`
- **Attach to a specific session**: `tmux attach -t session_name`
- **Detach from a session**: `tmux detach`
- **Kill a session**: `tmux kill-session -t session_name`

## Window Management
- **Create a new window**: `tmux new-window`
- **Rename a window**: `tmux rename-window new_name`
- **Switch between windows**: `tmux select-window -t window_number`
- **Kill a window**: `tmux kill-window -t window_number`

## Pane Management
- **Split a window horizontally**: `tmux split-window`
- **Split a window vertically**: `tmux split-window -h`
- **Switch between panes**: `tmux select-pane -t pane_number`
- **Resize a pane**:
  - `tmux resize-pane -L` (Resize left)
  - `tmux resize-pane -R` (Resize right)
  - `tmux resize-pane -U` (Resize up)
  - `tmux resize-pane -D` (Resize down)
- **Kill a pane**: `tmux kill-pane -t pane_number`

## History and Configuration
- **Scroll through history**: `tmux copy-mode`
- **Save configuration changes**: `tmux source-file ~/.tmux.conf`
