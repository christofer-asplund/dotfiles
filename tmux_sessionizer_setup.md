# tmux-sessionizer Setup Guide

This guide documents how to set up a fuzzy project switcher using `tmux`, `fzf`, and a custom script (`tmux-sessionizer`).

---

## 1. Script Creation

Create the script at:

```
~/.local/bin/tmux-sessionizer
```

Make sure it is executable:

```bash
chmod +x ~/.local/bin/tmux-sessionizer
```

### Script Content:

```bash
#!/bin/bash

PROJECT_DIRS=(/home/christofer-asplund/srcrepo/priv/* /home/christofer-asplund/srcrepo/work/*)

selected=$(printf "%s\n" "${PROJECT_DIRS[@]}" | fzf)

[ -z "$selected" ] && exit

session=$(basename "$selected" | tr . _ | tr -cd '[:alnum:]_-')

if ! tmux has-session -t="$session" 2>/dev/null; then
    tmux new-session -ds "$session" -c "$selected"
fi

tmux switch-client -t "$session"
```

---

## 2. Update `.tmux.conf`

Add the following line to your `~/.tmux.conf` file:

```tmux
# Fuzzy sessionizer keybind (Ctrl + b, then f)
bind f new-window -n "Sessionizer" "~/.local/bin/tmux-sessionizer"
```

Reload tmux config with:

```bash
tmux source-file ~/.tmux.conf
```

---

## 3. Update `.zshrc`

Ensure the script location is in your PATH. Add to `~/.zshrc`:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Apply changes:

```bash
source ~/.zshrc
```

---

## 4. Usage

- Launch tmux.
- Press `Ctrl + b`, then `f` to launch the sessionizer.
- Use arrow keys (or type) to find a project folder.
- Press `Enter` to attach or create a new tmux session in the selected folder.

---

## Notes

- `fzf` is used for fuzzy finding. You can install it with:
  ```bash
  sudo apt install fzf
  ```

- Tmux must be running to use the keybind.

- `Ctrl + j/k` for navigation is not enabled by default in `fzf`.

