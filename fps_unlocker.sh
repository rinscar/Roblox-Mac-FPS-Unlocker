#!/bin/bash

# Roblox FPS Unlocker - Smooth Version

ROBLOX_DIR="$HOME/Library/Roblox"
CLIENT_SETTINGS="$ROBLOX_DIR/ClientSettings"
IXP_FILE="$CLIENT_SETTINGS/IxpSettings.json"
XML_FILE="$ROBLOX_DIR/GlobalBasicSettings_13.xml"

# Create directories if missing
mkdir -p "$ROBLOX_DIR"

if [ ! -d "$CLIENT_SETTINGS" ]; then
    mkdir "$CLIENT_SETTINGS"
fi

# Remove file protection if exists
if [ -f "$IXP_FILE" ]; then
    chflags nouchg "$IXP_FILE"
fi

# Write JSON settings with smooth FPS and VSync disabled
cat > "$IXP_FILE" <<EOL
{
    "DFIntTaskSchedulerTargetFps": "240",    # Change to 300 if desired
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

# Lock the file
chflags uchg "$IXP_FILE"

# Patch XML fallback if it exists
if [ -f "$XML_FILE" ]; then
    sed -i '' 's/(<int name="FramerateCap" value=")[^"]*"/\1-1"/' "$XML_FILE"
fi

echo "Roblox FPS unlocked and smoothed to 240 FPS! | If you have any issues DM @omaw on Discord"
