#!/bin/bash
createDesktopIcons() {
	#We create new icons
	rm -rf "$HOME/Desktop/EmuDeckUninstall.desktop 2>/dev/null"
	echo '#!/usr/bin/env xdg-open
	[Desktop Entry]
	Name=Uninstall EmuDeck
	Exec=curl https://raw.githubusercontent.com/dragoonDorise/EmuDeck/main/uninstall.sh | bash -s -- SD
	Icon=delete
	Terminal=true
	Type=Application
	StartupNotify=false' >"$HOME/Desktop/EmuDeckUninstall.desktop"
	chmod +x "$HOME/Desktop/EmuDeckUninstall.desktop"

	rm -rf "$HOME/Desktop/EmuDeck.desktop 2>/dev/null"
	rm -rf "$HOME/Desktop/EmuDeckSD.desktop 2>/dev/null"
	echo "#!/usr/bin/env xdg-open
	[Desktop Entry]
	Name=Update EmuDeck (${version})
	Exec=curl https://raw.githubusercontent.com/dragoonDorise/EmuDeck/main/install.sh | bash -s -- SD
	Icon=steamdeck-gaming-return
	Terminal=true
	Type=Application
	StartupNotify=false" >"$HOME/Desktop/EmuDeck.desktop"
	chmod +x "$HOME/Desktop/EmuDeck.desktop"
}
