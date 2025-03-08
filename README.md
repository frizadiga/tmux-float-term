# tmux-float-term
> Creates a simple floating terminal window in tmux.

![screenshot](./.assets/0.png)

## Features
- Floating terminal overlay on top of your tmux session
- Customizable size, position, and appearance
- Toggle with a single keystroke
- Works seamlessly with existing tmux workflows

## Installation
Requires tmux version 3.3 or later.

### Using [TPM](https://github.com/tmux-plugins/tpm) (recommended)
Add this line to your `~/.tmux.conf`:

```bash
set -g @plugin 'frizadiga/tmux-float-term'
```

Then press `prefix` + <kbd>I</kbd> to install.

## Configuration

Set these options in your `~/.tmux.conf` file:

```bash
# Default values shown
set -g @tmux-float-term-bind 'a'           # Key binding to toggle floating terminal
set -g @tmux-float-term-width '60'         # Width of floating terminal (columns)
set -g @tmux-float-term-height '24'        # Height of floating terminal (rows)
set -g @tmux-float-term-text-color 'colour250'     # Text color
set -g @tmux-float-term-border-color 'colour238'   # Border color
```

## Usage
1. Press your tmux prefix (default: <kbd>ctrl</kbd>+<kbd>b</kbd>)
2. Press the configured toggle key (default: <kbd>a</kbd>)

The floating terminal will appear. Press the same key combination to dismiss it.

## Troubleshooting
- If the floating window doesn't appear, ensure your tmux version is 3.3+
- For issues with appearance, try adjusting the width and height values
