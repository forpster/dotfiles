#!/bin/bash

# Catppuccin Macchiato colors (24-bit RGB)
BLUE='\033[38;2;138;173;244m'
MAUVE='\033[38;2;198;160;246m'
YELLOW='\033[38;2;238;212;159m'
RED='\033[38;2;237;135;150m'
TEAL='\033[38;2;139;213;202m'
PEACH='\033[38;2;245;169;127m'
SUBTEXT='\033[38;2;165;173;203m'
RESET='\033[0m'

# Read all fields from JSON input in one jq call
IFS=$'\t' read -r CURRENT_DIR MODEL USED_PCT CTX_SIZE < <(
  jq -r '[
    .workspace.current_dir,
    (.model.display_name // ""),
    (.context_window.used_percentage // ""),
    (.context_window.context_window_size // "")
  ] | @tsv' < /dev/stdin
)
CURRENT_DIR="${CURRENT_DIR/#$HOME/~}"

# Git branch
GIT_BRANCH=$(git branch --show-current 2>/dev/null)

# Helper: format token counts (200000 → 200k)
fmt_k() {
  local n="$1"
  if [ -z "$n" ]; then echo "?"; return; fi
  if [ "$n" -ge 1000 ] 2>/dev/null; then
    echo "$((n / 1000))k"
  else
    echo "$n"
  fi
}

# ---- Build output ----

# Left: directory + git branch
left="${BLUE}${CURRENT_DIR}${RESET}"
if [ -n "$GIT_BRANCH" ]; then
  left="${left} ${MAUVE}⌥(${GIT_BRANCH})${RESET}"
fi

# Right: model + context bar + tokens
parts=()

if [ -n "$MODEL" ]; then
  parts+=("${PEACH}[${MODEL}]${RESET}")
fi

if [ -n "$USED_PCT" ]; then
  int_pct=${USED_PCT%.*}

  # Color-code by usage (pure bash integer comparison)
  if (( int_pct < 30 )); then
    ctx_color="$TEAL"
  elif (( int_pct < 60 )); then
    ctx_color="$YELLOW"
  elif (( int_pct < 80 )); then
    ctx_color="$PEACH"
  else
    ctx_color="$RED"
  fi

  # Visual bar (10 chars wide, string slicing)
  filled=$((int_pct / 10))
  full="██████████" empty="░░░░░░░░░░"
  bar="${full:0:filled}${empty:0:10-filled}"

  used_fmt=$(printf "%.1f" "$USED_PCT")
  parts+=("${ctx_color}${bar} ${used_fmt}% used${RESET}")

  # Token count derived from percentage
  if [ -n "$CTX_SIZE" ]; then
    USED_TOKENS=$(echo "scale=0; $USED_PCT * $CTX_SIZE / 100" | bc)
    parts+=("${ctx_color}$(fmt_k "$USED_TOKENS")/$(fmt_k "$CTX_SIZE") tokens${RESET}")
  fi
fi

# Join right parts with │, combine with left via ·
sep="${SUBTEXT} │ ${RESET}"
right=""
for part in "${parts[@]}"; do
  if [ -z "$right" ]; then right="$part"; else right="${right}${sep}${part}"; fi
done

printf "%b" "${left}${SUBTEXT} · ${RESET}${right}"
