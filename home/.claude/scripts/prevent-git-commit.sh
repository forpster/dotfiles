#!/bin/bash
COMMAND=$(jq -r '.tool_input.command' < /dev/stdin)
if echo "$COMMAND" | grep -q 'git commit'; then
  echo 'BLOCKED: git commit is not allowed. Use git add to stage changes, then ask the user to review and commit manually.' >&2
  exit 2
fi
