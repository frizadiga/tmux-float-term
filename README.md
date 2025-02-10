# tmux-float-term
floating terminal plugin for tmux

<!--screenshot image-->
![screenshot](./.assets/0.png)

## Installation
need tmux version 3.3 or later

```bash
set -g @plugin 'frizadiga/tmux-float-term'
```

## Options
```bash
set -g @tmux-float-term-bind 'a' # key binding to toggle floating terminal
set -g @tmux-float-term-width '60' # floating terminal width
set -g @tmux-float-term-height '24' # floating terminal height
set -g @tmux-float-term-text-color 'colour250' # foreground text color eg: red, green, colour0 to colour255
set -g @tmux-float-term-border-color 'colour238' # floating terminal border color eg: red, green, colour0 to colour255
```

