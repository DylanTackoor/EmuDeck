#!/bin/bash

#variables
Primehack_emuName="Primehack"
Primehack_emuType="FlatPak"
Primehack_emuPath="io.github.shiiion.primehack"
releaseURL=""

#cleanupOlderThings
Primehack_cleanup(){
 echo "NYI"
}

#Install
Primehack_install() {
	installEmuFP "${Primehack_emuName}" "${Primehack_emuPath}"
	flatpak override "${Primehack_emuPath}" --filesystem=host --user
}

#ApplyInitialSettings
Primehack_init() {
	configEmuFP "${Primehack_emuName}" "${Primehack_emuPath}" "true"
	Primehack_setupStorage
	Primehack_setEmulationFolder
	Primehack_setupSaves
}

#update
Primehack_update() {
	configEmuFP "${Primehack_emuName}" "${Primehack_emuPath}"
	Primehack_setupStorage
	Primehack_setEmulationFolder
	Primehack_setupSaves
}

#ConfigurePaths
Primehack_setEmulationFolder() {
	configFile="$HOME/.var/app/${Primehack_emuPath}/config/dolphin-emu/Dolphin.ini"
	gameDirOpt='ISOPath0 = '
	newGameDirOpt='ISOPath0 = '"${romsPath}/primehacks"
	sed -i "/${gameDirOpt}/c\\${newGameDirOpt}" "$configFile"
}

#SetupSaves
Primehack_setupSaves(){
	linkToSaveFolder primehack GC "$HOME/.var/app/io.github.shiiion.primehack/data/dolphin-emu/GC"
	linkToSaveFolder primehack Wii "$HOME/.var/app/io.github.shiiion.primehack/data/dolphin-emu/Wii"
	linkToSaveFolder primehack states "$HOME/.var/app/io.github.shiiion.primehack/data/dolphin-emu/states"
}


#SetupStorage
Primehack_setupStorage(){
    echo "Begin Primehack storage config"
    setDolphinStorageIni "primehack" "io.github.shiiion.primehack"
}


#WipeSettings
Primehack_wipe() {
	rm -rf "$HOME/.var/app/${Primehack_emuPath}"
}


#Uninstall
Primehack_uninstall() {
	flatpak uninstall "${Primehack_emuPath}" -y
}

#setABXYstyle
Primehack_setABXYstyle(){
    	echo "NYI"
}

#Migrate
Primehack_migrate(){
    	echo "NYI"
}

#WideScreenOn
Primehack_wideScreenOn(){
	echo "NYI"
}

#WideScreenOff
Primehack_wideScreenOff(){
	echo "NYI"
}

#BezelOn
Primehack_bezelOn(){
echo "NYI"
}

#BezelOff
Primehack_BezelOff(){
echo "NYI"
}

#finalExec - Extra stuff
Primehack_finalize(){
	echo "NYI"
}

