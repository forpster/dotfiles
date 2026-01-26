#!/bin/bash
# Debugging script for MCP server
LOG_FILE="/Users/rkirk/upwind/mcp_aurora_debug.log"
exec &> "$LOG_FILE"

set -x

echo "--- Starting MCP Server Script ---"
date

echo "--- Environment ---"
echo "PATH: $PATH"
echo "AWS_PROFILE: $AWS_PROFILE"
echo "which aws: $(which aws)"
echo "which npx: $(which npx)"

echo "--- Generating AWS Token ---"
#HOSTNAME="development-aurora01.cluster-ro-cy4rwtnlicbj.us-east-1.rds.amazonaws.com"
HOSTNAME="aurora01-development-ro.dev.internal"

TOKEN=$(aws rds generate-db-auth-token \
  --hostname "$HOSTNAME" \
  --port 3306 \
  --username upwind_read_only \
  --region us-east-1 \
  --profile=dev-read-only)

if [ $? -ne 0 ]; then
    echo "!!! AWS token generation failed !!!"
    exit 1
fi

echo "--- Starting MCP Server ---"
export MYSQL_HOST="$HOSTNAME"
export MYSQL_PORT="3306"
export MYSQL_USER="upwind_read_only"
export MYSQL_PASS="$TOKEN"
#export MYSQL_SSL="true"
export ALLOW_INSERT_OPERATION="false"
export ALLOW_UPDATE_OPERATION="false"
export ALLOW_DELETE_OPERATION="false"
export MYSQL_ENABLE_LOGGING="true"

npx @benborla29/mcp-server-mysql
