#!/bin/bash
set -e

echo "Starting DeviceLab Appium Test Node..."
echo "DeviceLab URL: $DEVICELAB_URL"
echo "APK Path: /root/Downloads/app-release.apk"
echo "Test Node Port: $TEST_NODE_PORT"

# Check if APK exists
if [ ! -f "/root/Downloads/app-release.apk" ]; then
    echo "Error: APK file not found at /root/Downloads/app-release.apk"
    exit 1
fi

# Display APK info
apk_size=$(stat -c%s "/root/Downloads/app-release.apk")
echo "APK Size: $(numfmt --to=iec $apk_size)"

# Download and execute DeviceLab script
echo "Downloading and executing DeviceLab script..."
exec curl -fsSL "$DEVICELAB_URL" | sh -s /root/Downloads/app-release.apk