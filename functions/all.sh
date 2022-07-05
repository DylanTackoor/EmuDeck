#!/bin/bash

source "$EMUDECKGIT"/functions/checkPSBIOS.sh
source "$EMUDECKGIT"/functions/configEmuAI.sh
source "$EMUDECKGIT"/functions/configEmuFP.sh
source "$EMUDECKGIT"/functions/configESDE.sh
source "$EMUDECKGIT"/functions/configSRM.sh
source "$EMUDECKGIT"/functions/createDesktopIcons.sh
#source "$EMUDECKGIT"/functions/createSaveFolders.sh integrated into update / init methods
source "$EMUDECKGIT"/functions/installCHD.sh
source "$EMUDECKGIT"/functions/installEmuFP.sh
source "$EMUDECKGIT"/functions/installESDE.sh
source "$EMUDECKGIT"/functions/installPowerTools.sh
source "$EMUDECKGIT"/functions/installSRM.sh
source "$EMUDECKGIT"/functions/RAAchievment.sh
source "$EMUDECKGIT"/functions/RAautoSave.sh
source "$EMUDECKGIT"/functions/RABezels.sh
#source "$EMUDECKGIT"/functions/RACores.sh
source "$EMUDECKGIT"/functions/RASNES.sh
source "$EMUDECKGIT"/functions/setESDEEmus.sh
source "$EMUDECKGIT"/functions/setMSG.sh
source "$EMUDECKGIT"/functions/setUpHolo.sh
source "$EMUDECKGIT"/functions/setWide.sh
source "$EMUDECKGIT"/functions/testLocationValid.sh
source "$EMUDECKGIT"/functions/setSetting.sh
source "$EMUDECKGIT"/functions/linkToSaveFolder.sh
source "$EMUDECKGIT"/functions/installEmuAI.sh
source "$EMUDECKGIT"/functions/getLatestReleaseURLGH.sh
source "$EMUDECKGIT"/functions/migrateAndLinkConfig.sh
#source "$EMUDECKGIT"/functions/doMigrations.sh integrated into emuDeckEmuScripts
source "$EMUDECKGIT"/functions/installBinUp.sh

#emuscripts
source "$EMUDECKGIT"/EmuScripts/emuDeckYuzu.sh
source "$EMUDECKGIT"/EmuScripts/emuDeckCemu.sh
source "$EMUDECKGIT"/EmuScripts/emuDeckPCSX2.sh
source "$EMUDECKGIT"/EmuScripts/emuDeckRPCS3.sh
source "$EMUDECKGIT"/EmuScripts/emuDeckCitra.sh
source "$EMUDECKGIT"/EmuScripts/emuDeckDolphin.sh
source "$EMUDECKGIT"/EmuScripts/emuDeckPrimehack.sh
source "$EMUDECKGIT"/EmuScripts/emuDeckRetroArch.sh
source "$EMUDECKGIT"/EmuScripts/emuDeckPPSSPP.sh
source "$EMUDECKGIT"/EmuScripts/emuDeckDuckStation.sh
source "$EMUDECKGIT"/EmuScripts/emuDeckXemu.sh

#Soon
#source "$EMUDECKGIT"/EmuScripts/emuDeckXenia.sh
#source "$EMUDECKGIT"/EmuScripts/emuDeckMelonDS.sh
#source "$EMUDECKGIT"/EmuScripts/emuDeckMgba.sh
#source "$EMUDECKGIT"/EmuScripts/emuDeckRedream.sh
#source "$EMUDECKGIT"/EmuScripts/emuDeckMAMEProton.sh
