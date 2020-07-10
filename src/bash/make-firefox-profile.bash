profile_prefix="$(ruby -rsecurerandom -e 'puts SecureRandom.hex(5)')"
name="$1"
label="$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]')"

profile_directory=~/.mozilla/firefox/"${profile_prefix}.${label}"
ff_name="$name Firefox"
icon=/home/luke/.local/share/applications/icons/"$label.png"

cat << EOF > ~/.local/share/applications/"$name.desktop"
[Desktop Entry]
Encoding=UTF-8
Name=$ff_name
Exec=/usr/bin/firefox --no-remote --profile $profile_directory
Icon=$icon
Type=Application
Categories=Internet;
EOF

mkdir -p ~/.local/share/applications/icons/
echo 'Need to configure ~/.local/share/applications/icons/strivr.png'

mkdir -p $profile_directory

# Find a way to make these automatic
# browser.ctrlTab.recentlyUsedOrder = False
