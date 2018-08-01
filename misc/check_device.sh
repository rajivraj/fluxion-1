#!/usr/bin/env bash

fluxion_check_ap() {
  readonly SUPPORT_AP=$(sed -n -e "$(echo $(($1+4)))p" devices.xml | cut -d ">" -f2 | cut -d "<" -f1)
  if [ "$SUPPORT_AP" == "n" ];then
    echo "Driver doesn't support AP mode"	  
    echo "false"
    return
  fi
  echo "Driver support AP mode"	  
  echo true
}

fluxion_check_mo() {
  readonly SUPPORT_MO=$(sed -n -e "$(echo $(($1+6)))p" devices.xml | cut -d ">" -f2 | cut -d "<" -f1)
  if [ "$SUPPORT_MO" == "n" ];then
    echo "Driver doesn't support monitor mode"	  
    echo "false"
    return
  fi
  echo "Driver support monitor mode"	  
  echo true
}

fluxion_check_chipset() {
  declare -r LINE=$(grep "$1" devices.xml -n | head -n 1 | cut -d ":" -f1)

  echo $LINE
  if [ "$LINE" == "" ];then
	  echo "Chipset is unknown"
  fi  


	fluxion_check_ap $LINE
  #if [ "$(fluxion_check_ap "$LINE")" == "true" ] || [ "$(fluxion_check_mo "$LINE")" == "true" ];then
   # echo "true"; else echo "false"
  #fi
}

fluxion_check_chipset "$1"
