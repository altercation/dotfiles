# ~/.config/shell/init.sh: shared startup for zsh, bash and sh.
# Sourced by ~/.config/zsh/.zshenv, ~/.profile, ~/.bashrc, and by sh via $ENV.
# POSIX sh only (bash 3.2 in sh mode reads this): no [[ ]], arrays, `local`,
# `source`, or other shell-specific syntax. Never print anything: it runs in
# scripts and tools whose output must stay clean.
if [ -r "$HOME/.config/shell/env.private" ]; then
  . "$HOME/.config/shell/env.private"
fi
