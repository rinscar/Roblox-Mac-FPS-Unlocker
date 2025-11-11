#!/bin/bash

ROBLOX_DIR="$HOME/Library/Roblox"
CLIENT_SETTINGS="$ROBLOX_DIR/ClientSettings"
IXP_FILE="$CLIENT_SETTINGS/IxpSettings.json"
XML_FILE="$ROBLOX_DIR/GlobalBasicSettings_13.xml"

mkdir -p "$CLIENT_SETTINGS"

[ -f "$IXP_FILE" ] && chflags nouchg "$IXP_FILE"

cat > "$IXP_FILE" <<EOL
{
    "DFIntTaskSchedulerTargetFps": "240",
    "FFlagTaskSchedulerLimitTargetFpsTo2402": "False",
    "FFlagDebugGraphicsPreferOpenGL": "True",
    "FFlagDebugGraphicsPreferVulkan": "True",
    "FFlagDebugGraphicsPreferD3D11": "True",
    "DFIntMaxFrameBufferSize": "3",
    "FIntRenderShadowIntensity": "0",
    "FIntRenderGrassHeightScaler": "0",
    "FFlagDisablePostFx": "True",
    "FFlagDebugSkyGray": "True",
    "FFlagDebugDisplayFPS": "True",
    "EnableVSync": false
}
EOL

chflags uchg "$IXP_FILE"

if [ -f "$XML_FILE" ]; then
    sed -i '' '/FramerateCap/c\<int name="FramerateCap" value="240"/>' "$XML_FILE"
fi

echo "Roblox FPS unlocked and smoothed to 240 FPS!"
