#!/bin/bash

SRC_FOLDER="$HOME/.config/waybar/modules/WeatherApp/WeatherApp"
PUBLISH_FOLDER="$HOME/.config/waybar/modules/weather"

# check if app folder exists, if not, compile the code
if [ ! -d "$PUBLISH_FOLDER" ]; then
  echo "Application not found. Compiling the WeatherApp..."
  cd "$SRC_FOLDER" || exit 1
  dotnet publish -o "$PUBLISH_FOLDER"
fi

cd "$PUBLISH_FOLDER" || exit 1
./WeatherApp
