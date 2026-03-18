#!/bin/bash
COMMAND=$(jq -r '.tool_input.command' < /dev/stdin)
if echo "$COMMAND" | grep -q 'git commit'; then
  jq -n '{decision: "block", reason: "git commit is not allowed. Use git add to stage changes, then ask the user to review and commit manually."}'
  exit 0
fi
