#!/bin/bash
clear
echo Welcome to the...
echo
printf "   ÛÛÛÛÛÛÛÛÛ                                  ÛÛÛÛÛ                ÛÛÛÛÛÛ   ÛÛÛÛÛÛ                      ÛÛÛ   ÛÛÛÛÛ                     \n"
printf "  ÛÛÛ°°°°°ÛÛÛ                                °°ÛÛÛ                °°ÛÛÛÛÛÛ ÛÛÛÛÛÛ                      °°°   °°ÛÛÛ                       \n"
printf " ÛÛÛ     °°°  ÛÛÛÛÛÛÛÛ  ÛÛÛÛÛ ÛÛÛÛ ÛÛÛÛÛÛÛÛ  ÛÛÛÛÛÛÛ    ÛÛÛÛÛÛ     °ÛÛÛ°ÛÛÛÛÛ°ÛÛÛ   ÛÛÛÛÛÛ  ÛÛÛÛÛÛÛÛ   ÛÛÛÛ  ÛÛÛÛÛÛÛ    ÛÛÛÛÛÛ  ÛÛÛÛÛÛÛÛ \n"
printf "°ÛÛÛ         °°ÛÛÛ°°ÛÛÛ°°ÛÛÛ °ÛÛÛ °°ÛÛÛ°°ÛÛÛ°°°ÛÛÛ°    ÛÛÛ°°ÛÛÛ    °ÛÛÛ°°ÛÛÛ °ÛÛÛ  ÛÛÛ°°ÛÛÛ°°ÛÛÛ°°ÛÛÛ °°ÛÛÛ °°°ÛÛÛ°    ÛÛÛ°°ÛÛÛ°°ÛÛÛ°°ÛÛÛ\n"
printf "°ÛÛÛ          °ÛÛÛ °°°  °ÛÛÛ °ÛÛÛ  °ÛÛÛ °ÛÛÛ  °ÛÛÛ    °ÛÛÛ °ÛÛÛ    °ÛÛÛ °°°  °ÛÛÛ °ÛÛÛ °ÛÛÛ °ÛÛÛ °ÛÛÛ  °ÛÛÛ   °ÛÛÛ    °ÛÛÛ °ÛÛÛ °ÛÛÛ °°° \n"
printf "°°ÛÛÛ     ÛÛÛ °ÛÛÛ      °ÛÛÛ °ÛÛÛ  °ÛÛÛ °ÛÛÛ  °ÛÛÛ ÛÛÛ°ÛÛÛ °ÛÛÛ    °ÛÛÛ      °ÛÛÛ °ÛÛÛ °ÛÛÛ °ÛÛÛ °ÛÛÛ  °ÛÛÛ   °ÛÛÛ ÛÛÛ°ÛÛÛ °ÛÛÛ °ÛÛÛ     \n"
printf " °°ÛÛÛÛÛÛÛÛÛ  ÛÛÛÛÛ     °°ÛÛÛÛÛÛÛ  °ÛÛÛÛÛÛÛ   °°ÛÛÛÛÛ °°ÛÛÛÛÛÛ     ÛÛÛÛÛ     ÛÛÛÛÛ°°ÛÛÛÛÛÛ  ÛÛÛÛ ÛÛÛÛÛ ÛÛÛÛÛ  °°ÛÛÛÛÛ °°ÛÛÛÛÛÛ  ÛÛÛÛÛ    \n"
printf "  °°°°°°°°°  °°°°°       °°°°°ÛÛÛ  °ÛÛÛ°°°     °°°°°   °°°°°°     °°°°°     °°°°°  °°°°°°  °°°° °°°°° °°°°°    °°°°°   °°°°°°  °°°°°     \n"
printf "                         ÛÛÛ °ÛÛÛ  °ÛÛÛ                                                                                                  \n"
printf "                        °°ÛÛÛÛÛÛ   ÛÛÛÛÛ                                                                                                 \n"
printf "                         °°°°°°   °°°°°                                                                                                  \n"
echo 

MENUITEMS="CryptoTracker FileAnalyzer CryptoTrader"

echo Please input digit of desired program.
echo -------------------------------------
select menuitem in $MENUITEMS
do 
	case $menuitem in
		CryptoTracker)
			clear
			echo Running Crypto Tracker
			./cryptoproject.sh
			;;
		FileAnalyzer)
			clear
			echo Running File Analyzer
			./filereader.sh
			;;
		CryptoTrader)
			clear
			echo Running Crypto Trader
			./CryptoTrader.sh
			;;
	esac
done
