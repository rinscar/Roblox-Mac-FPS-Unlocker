#!/bin/bash

ROBLOX_DIR="$HOME/Library/Roblox"
CLIENT_SETTINGS="$ROBLOX_DIR/ClientSettings"
IXP_FILE="$CLIENT_SETTINGS/IxpSettings.json"
XML_FILE="$ROBLOX_DIR/GlobalBasicSettings_13.xml"

mkdir -p "$ROBLOX_DIR"

if [ ! -d "$CLIENT_SETTINGS" ]; then
    mkdir "$CLIENT_SETTINGS"
fi

if [ -f "$IXP_FILE" ]; then
    chflags nouchg "$IXP_FILE"
fi

cat > "$IXP_FILE" <<EOL
{
    "DFIntTaskSchedulerTargetFps": 120,
    "FFlagTaskSchedulerLimitTargetFpsTo2402": true,
    "FFlagDebugGraphicsPreferMetal": true,
    "FFlagDebugGraphicsPreferOpenGL": false,
    "FFlagDebugGraphicsPreferVulkan": false,
    "DFIntMaxFrameBufferSize": 2,
    "FIntRenderShadowIntensity": 0,
    "FIntRenderGrassHeightScaler": 0,
    "FFlagDisablePostFx": true,
    "FFlagDebugSkyGray": false,
    "FFlagDebugDisplayFPS": true
}
EOL

chflags uchg "$IXP_FILE"

if [ -f "$XML_FILE" ]; then
    sed -i '' 's/(<int name="FramerateCap" value=")[^"]*"/\1-1"/' "$XML_FILE"
fi

echo "Roblox FPS Unlocked! | If you have any issues DM @omaw on Discord"
