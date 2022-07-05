#!/bin/bash

#variables
emuName="yuzu"
emuType="AppImage"
emuPath="$HOME/Applications/yuzu.AppImage"

#cleanupOlderThings
cleanupYuzu() {
    "Begin Yuzu Cleanup"
    #Fixes repeated Symlink for older installations
    cd "$HOME/.var/app/org.yuzu_emu.yuzu/data/yuzu/keys/"
    unlink keys
    cd "$HOME/.var/app/org.yuzu_emu.yuzu/data/yuzu/nand/system/Contents/registered/"
    unlink registered
}

#Install
installYuzu() {
    echo "Begin Yuzu Install"
    installEmuAI "yuzu" $(getLatestReleaseURLGH "yuzu-emu/yuzu-mainline" "AppImage") #needs to be lowercase yuzu for EsDE to find it.
    flatpak override org.yuzu_emu.yuzu --filesystem=host --user                      # still doing this, as we do link the appimage / flatpak config
}

#ApplyInitialSettings
initYuzu() {
    echo "Begin Yuzu Init"
    migrateYuzu
    configEmuAI "yuzu" "config" "$HOME/.config/yuzu" "$HOME/dragoonDoriseTools/EmuDeck/configs/org.yuzu_emu.yuzu/config/yuzu" "true"
    configEmuAI "yuzu" "data" "$HOME/.local/share/yuzu" "$HOME/dragoonDoriseTools/EmuDeck/configs/org.yuzu_emu.yuzu/data/yuzu" "true"

    setEmulationFolderYuzu

    #Setup Bios symlinks
    unlink ${biosPath}yuzu/keys
    unlink ${biosPath}yuzu/firmware
    mkdir -p "$HOME/.local/share/yuzu/keys/"
    mkdir -p ${storagePath}yuzu/nand/system/Contents/registered/
    ln -sn "$HOME/.local/share/yuzu/keys/" ${biosPath}yuzu/keys
    ln -sn ${storagePath}yuzu/nand/system/Contents/registered/ ${biosPath}yuzu/firmware

    touch ${storagePath}yuzu/nand/system/Contents/registered/putfirmwarehere.txt

}

#update
updateYuzu() {
    echo "Begin Yuzu update"
    migrateYuzu
    configEmuAI "yuzu" "config" "$HOME/.config/yuzu" "$HOME/dragoonDoriseTools/EmuDeck/configs/org.yuzu_emu.yuzu/config/yuzu"
    configEmuAI "yuzu" "data" "$HOME/.local/share/yuzu" "$HOME/dragoonDoriseTools/EmuDeck/configs/org.yuzu_emu.yuzu/data/yuzu"

    setEmulationFolderYuzu

    #Setup Bios symlinks
    unlink ${biosPath}yuzu/keys
    unlink ${biosPath}yuzu/firmware
    mkdir -p "$HOME/.local/share/yuzu/keys/"
    mkdir -p ${storagePath}yuzu/nand/system/Contents/registered/
    ln -sn "$HOME/.local/share/yuzu/keys/" ${biosPath}yuzu/keys
    ln -sn ${storagePath}yuzu/nand/system/Contents/registered/ ${biosPath}yuzu/firmware

    touch ${storagePath}yuzu/nand/system/Contents/registered/putfirmwarehere.txt

}

#ConfigurePaths
setEmulationFolderYuzu() {
    echo "Begin Yuzu Path Config"
    configFile="$HOME/.config/yuzu/qt-config.ini"
    screenshotDirOpt='Screenshots\screenshot_path='
    gameDirOpt='Paths\gamedirs\4\path='
    dumpDirOpt='dump_directory='
    loadDir='load_directory='
    nandDirOpt='nand_directory='
    sdmcDirOpt='sdmc_directory='
    tasDirOpt='tas_directory='
    newScreenshotDirOpt='Screenshots\screenshot_path='"${storagePath}yuzu/screenshots"
    newGameDirOpt='Paths\gamedirs\4\path='"${romsPath}switch"
    newDumpDirOpt='dump_directory='"${storagePath}yuzu/dump"
    newLoadDir='load_directory='"${storagePath}yuzu/load"
    newNandDirOpt='nand_directory='"${storagePath}yuzu/nand"
    newSdmcDirOpt='sdmc_directory='"${storagePath}yuzu/sdmc"
    newTasDirOpt='tas_directory='"${storagePath}yuzu/tas"

    sed -i "/${screenshotDirOpt}/c\\${newScreenshotDirOpt}" $configFile
    sed -i "/${gameDirOpt}/c\\${newGameDirOpt}" $configFile
    sed -i "/${dumpDirOpt}/c\\${newDumpDirOpt}" $configFile
    sed -i "/${loadDir}/c\\${newLoadDir}" $configFile
    sed -i "/${nandDirOpt}/c\\${newNandDirOpt}" $configFile
    sed -i "/${sdmcDirOpt}/c\\${newSdmcDirOpt}" $configFile
    sed -i "/${tasDirOpt}/c\\${newTasDirOpt}" $configFile

    setupStorageYuzu
}

#SetupSaves
setupSavesYuzu() {
    echo "Begin Yuzu save link"
    unlink "${savesPath}yuzu/saves" # Fix for previous bad symlink
    linkToSaveFolder yuzu saves "${storagePath}yuzu/nand/user/save/"
}

#SetupStorage
setupStorageYuzu() {
    echo "Begin Yuzu storage config"
    mkdir -p ${storagePath}yuzu/dump
    mkdir -p ${storagePath}yuzu/load
    mkdir -p ${storagePath}yuzu/sdmc
    mkdir -p ${storagePath}yuzu/nand
    mkdir -p ${storagePath}yuzu/screenshots
    mkdir -p ${storagePath}yuzu/tas
}

#WipeSettings
wipeYuzu() {
    echo "Begin Yuzu delete config directories"
    rm -rf "$HOME/.config/yuzu"
    rm -rf "$HOME/.local/share/yuzu"
}

#Uninstall
uninstallYuzu() {
    echo "Begin Yuzu uninstall"
    rm -rf $emuPath
}

#Migrate
migrateYuzu() {
    echo "Begin Yuzu Migration"
    emu="Yuzu"
    migrationFlag="$HOME/emudeck/.${emu}MigrationCompleted"
    #check if we have a nomigrateflag for $emu
    if [ ! -f "$migrationFlag" ]; then
        #yuzu flatpak to appimage
        #From -- > to
        migrationTable=()
        migrationTable+=("$HOME/.var/app/org.yuzu_emu.yuzu/data/yuzu" "$HOME/.local/share/yuzu")
        migrationTable+=("$HOME/.var/app/org.yuzu_emu.yuzu/config/yuzu" "$HOME/.config/yuzu")

        migrateAndLinkConfig $emu $migrationTable
    fi

    #move data from hidden folders out to these folders in case the user already put stuff here.
    origPath="$HOME/.local/share/"

    setupStorageYuzu

    rsync -av ${origPath}yuzu/dump ${storagePath}yuzu/ && rm -rf ${origPath}yuzu/dump
    rsync -av ${origPath}yuzu/load ${storagePath}yuzu/ && rm -rf ${origPath}yuzu/load
    rsync -av ${origPath}yuzu/sdmc ${storagePath}yuzu/ && rm -rf ${origPath}yuzu/sdmc
    rsync -av ${origPath}yuzu/nand ${storagePath}yuzu/ && rm -rf ${origPath}yuzu/nand
    rsync -av ${origPath}yuzu/screenshots ${storagePath}yuzu/ && rm -rf ${origPath}yuzu/screenshots
    rsync -av ${origPath}yuzu/tas ${storagePath}yuzu/ && rm -rf ${origPath}yuzu/tas
}

#setABXYstyle
setABXYstyleYuzu() {

}

#WideScreenOn
wideScreenOnYuzu() {
    #na
}

#WideScreenOff
wideScreenOffYuzu() {
    #na
}

#BezelOn
bezelOnYuzu() {
    #na
}

#BezelOff
bezelOffYuzu() {
    #na
}

#finalExec - Extra stuff
finalizeYuzu() {
    echo "Begin Yuzu finalize"
    cleanupYuzu
}
