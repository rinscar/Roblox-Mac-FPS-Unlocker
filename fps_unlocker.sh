#!/bin/bash

ROBLOX_DIR="$HOME/Library/Roblox"
CLIENT_SETTINGS="$ROBLOX_DIR/ClientSettings"
IXP_FILE="$CLIENT_SETTINGS/IxpSettings.json"
XML_FILE="$ROBLOX_DIR/GlobalBasicSettings_13.xml"

# Create directories if they don't exist
mkdir -p "$CLIENT_SETTINGS"

# Remove immutability flag if the file exists
if [ -f "$IXP_FILE" ]; then
    chflags nouchg "$IXP_FILE"
fi

# Write optimized FastFlags for macOS
cat > "$IXP_FILE" <<EOL
{
    // === FPS & Scheduler Tweaks ===
    "DFIntTaskSchedulerTargetFps": "9999",
    "FFlagRenderVsyncEnabled": "False",
    "FFlagRenderDisableVsync": "True",

    // === Graphics Performance Tweaks ===
    "FFlagDisablePostFx": "True",
    "FFlagDebugDisplayFPS": "True",
    "FIntRenderShadowIntensity": "0",
    "FIntRenderGrassHeightScaler": "0",

    // === Optional visual simplifications ===
    "FFlagDebugSkyGray": "True",
    "FFlagRenderForceTechnology": "True",
    "FStringRenderingMode": "Metal" // Forces Metal on macOS
}
EOL

# Lock the file to prevent Roblox from overwriting it
chflags uchg "$IXP_FILE"

# Modify XML FPS cap if it exists
if [ -f "$XML_FILE" ]; then
    sed -i '' 's/\(<int name="FramerateCap" value="\)[^"]*"/\1-1"/' "$XML_FILE"
fi

echo "✅ Roblox FPS Unlocker for macOS applied!"
echo "If FPS stays capped at 120, it's a Roblox-side or display refresh limitation."
