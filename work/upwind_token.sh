#!/bin/bash

unset UPWIND_CLIENT_ID UPWIND_CLIENT_SECRET

# ORG org_8xFvjw2CxGPfGjwr / Upwind Labs
# Config ID ucsc-878a5cc51edff3df
if [ "$UPWIND_DEV_ORG_ID" = "org_8xFvjw2CxGPfGjwr" ]; then 
    export UPWIND_CLIENT_ID=
    export UPWIND_CLIENT_SECRET=
fi

# AZURE
# ORG org_5hKwy6yAIadtmryf / Customer-asset-collector name in Console
# Config ID ucsc-8f8445ef3b35de2d
if [ "$UPWIND_DEV_ORG_ID" = "org_5hKwy6yAIadtmryf" ]; then 
    export UPWIND_CLIENT_ID=
    export UPWIND_CLIENT_SECRET=
fi

# org_2rNHQxTwevbcc7a2 / Upwind Cloudscanner Dev
# Config ID - usually using one of the existing ones
if [ "$UPWIND_DEV_ORG_ID" = "org_2rNHQxTwevbcc7a2" ]; then 
    export UPWIND_CLIENT_ID=
    export UPWIND_CLIENT_SECRET=
fi
