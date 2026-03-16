# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Personal dotfiles repo for a macOS workstation. All config files live under version control here and get symlinked into `$HOME` by `setup.sh`.

## Setup

Run `./setup.sh` to symlink everything into place. The script is idempotent — it skips files that already exist or are already linked. It:
- Links shell configs (`home/` -> `~/`), work-specific configs (`work/` -> `~/`), and bin scripts (`bin/` -> `~/bin/`)
- Handles platform differences (macOS vs Linux) for SSH config and tmux agent forwarding
- Clones `forpster/kickstart.nvim` for neovim config
- Copies (not links) Windsurf global rules since symlinks don't work there
- Links Claude Code settings and Ghostty terminal config

## Repository Layout

- `home/` — dotfiles symlinked directly into `$HOME` (zshrc, vimrc, tmux, p10k, emacs, ssh, ghostty, asdf, claude settings)
- `work/` — work-specific configs (gitconfig, bash_upwind, bash_aws, Windsurf global_rules)
- `bin/` — utility scripts symlinked into `~/bin`
- `claude/` — Claude Code statusline script (Catppuccin Macchiato themed)
- `iterm2/` — iTerm2 profile
- `postman/` — Postman collections

## Shell Stack

Zsh with antigen plugin manager (sourced from `~/src/antigen/antigen.zsh`), Powerlevel10k theme, and Oh-My-Zsh framework. Key plugins: fzf, zoxide, bat, jq-zsh-plugin, zsh-autosuggestions, zsh-syntax-highlighting. ASDF manages language runtimes (Java via `set-java-home.zsh`). fzf-git.sh provides git-aware fzf keybindings (CTRL-G*).

## Key Conventions

- Tmux prefix is `C-a` (not default `C-b`). TPM manages tmux plugins.
- Git is configured with delta as pager (side-by-side diffs), pull rebase, SSH URLs for GitHub (`git@github.com:` instead of `https://`), and tags sorted by `-v:refname`.
- Work-specific env files (`.bash_upwind`, `.bash_aws`) are conditionally sourced if they exist.
- Secrets (API keys, tokens) are read from `~/Documents/*.txt` files at shell startup — these are never committed.
