#!/usr/bin/env bash --login

export base_dir="${HOME}/Downloads/Google Voice-OSX-Universal"

pushd "${base_dir}"

echo "Cleaning up any previous builds"
[[ -d "${base_dir}/Google Voice-darwin-universal" ]] && rm -fr "${base_dir}/Google Voice-darwin-universal" 
[[ -d "${base_dir}/installer/" ]] && rm -fr "${base_dir}/installer/"

echo "Unmounting any previous Google Voice installer-images"
[ "mount |grep -F -q '/Volumes/Google Voice'" ] && umount '/Volumes/Google Voice' 

echo "If Node-JS is not installed, it will be installed. It is required to run the nativefier and appdmg"
brew list node 1>/dev/null 2>/dev/null || brew install node 

echo "If draw.io is not installed, it will be installed. It is required to build the background image for the installer"
brew list drawio 1>/dev/null 2>/dev/null || brew install drawio

echo "Installing required Node-JS packages (nativefier and appdmg)"
npm install nativefier@latest -g
npm install appdmg@latest -g 

echo "Wrapping the '"'Google Voice'"' web-application as a native-application, using Electron and the '"'nativefier'"' utility"
nativefier \
    --name "Google Voice" \
    "https://voice.google.com/u/0/" \
    "${base_dir}" \
    --tray \
    --counter \
    --portable \
    --bounce \
    --arch "universal" \
    --platform osx ;


mkdir "${base_dir}/installer"
cp -RpP  "${base_dir}/Google Voice-darwin-universal/Google Voice.app" "${base_dir}/installer/Google Voice.app"

echo "Building an installer background to help the customer install"
/Applications/draw.io.app/Contents/MacOS/draw.io -x -o "${base_dir}/installer/My_Background.png" -f "png" ./GVoice_appdmg_backgrouns.drawio

echo "Configuring '"'appdmg'"' to package the Electron application in an app-installer"
echo '{
  "title": "Google Voice",
  "icon": "GVoice_Icon.icns",
  "background": "installer/My_Background.png",
  "contents": [
    { "x": 576, "y": 275, "type": "link", "path": "/Applications" },
    { "x": 192, "y": 275, "type": "file", "path": "installer/Google Voice.app" },
    { "x": 868, "y": 636, "type": "position", "path": ".VolumeIcon.icns"},
    { "x": 868, "y": 636, "type": "position", "path": ".background" }
  ],
  "icon-size": 128,
  "window": {"size": {"width": 768, "height": 536}},
  "format": "UDZO"

}
' > "${base_dir}/GVoice_appdmg.json"

echo "Cleaning up any previous builds"
[[ -a "${base_dir}/installer/Google Voice.dmg" ]] && rm -fr "${base_dir}/installer/Google Voice.dmg" 
echo "Packaging the '"'Google Voice'"' Electron app as a '"'dmg'"' app-installer"
appdmg "${base_dir}/GVoice_appdmg.json" "${base_dir}/installer/Google Voice.dmg" 

popd
