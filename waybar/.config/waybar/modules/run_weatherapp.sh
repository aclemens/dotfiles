#!/bin/bash

APP_FOLDER="$HOME/.config/waybar/modules/WeatherApp/WeatherApp"
PUBLISH_FOLDER="$APP_FOLDER/bin/Release/net10.0/linux-x64/publish"

# check if app folder exists, if not, compile the code
if [ ! -d "$PUBLISH_FOLDER" ]; then
  echo "Application not found. Compiling the WeatherApp..."
  cd "$APP_FOLDER" || exit 1
  dotnet publish -c Release --self-contained
fi

cd "$PUBLISH_FOLDER" || exit 1
./WeatherApp
