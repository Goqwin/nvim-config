# TMUX COMMANDS

### **Session Management**
tmux - Start a new tmux session.
tmux new -s <session_name> - Create a new session with a specific name.
tmux attach - Reattach to the most recently used session.
tmux attach -t <session_name> - Attach to a specific session.
tmux detach - Detach from the current session.
tmux list-sessions or tmux ls - List all active sessions.
tmux kill-session -t <session_name> - Kill a specific session.
tmux kill-server - Kill all tmux sessions.

### **Window Management**
Ctrl-b c - Create a new window.
Ctrl-b n - Switch to the next window.
Ctrl-b p - Switch to the previous window.
Ctrl-b w - List all windows.
Ctrl-b , - Rename the current window.
Ctrl-b & - Close the current window.

### **Pane Management**
Ctrl-b % - Split the current pane horizontally.
Ctrl-b " - Split the current pane vertically.
Ctrl-b o - Switch to the next pane.
Ctrl-b q - Display pane numbers for quick selection.
Ctrl-b x - Close the current pane.
Ctrl-b z - Toggle zoom for the current pane.
Ctrl-b { or Ctrl-b } - Swap panes.

### **Resizing Panes**
Ctrl-b <arrow keys> - Resize panes in the direction of the arrow key.
Ctrl-b Ctrl-<arrow keys> - Resize panes more precisely.

### **Copy Mode**
Ctrl-b [ - Enter copy mode to scroll through the buffer.
Ctrl-b ] - Paste the copied text.
Ctrl-b Space - Start text selection in copy mode.
Enter - Copy the selected text.

### **Customization and Configuration**
tmux source-file ~/.tmux.conf - Reload the tmux configuration file.
tmux list-keys - List all key bindings.
tmux list-commands - List all available tmux commands.

### **Miscellaneous**
Ctrl-b d - Detach from the current session.
Ctrl-b t - Show the current time.
Ctrl-b ? - Display a list of all key bindings.

