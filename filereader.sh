#!/bin/bash
echo Welcome to the file analyzer!
echo
echo These are the files available to read:
echo
ls /home/leo/CryptoRecordings
echo
echo Please input the name and extension of the file you would like to analyze:
read filen
#Calculating High, Low, and Average price of each coin
        echo BTC High: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$2}' | sort -n | tail -1)
	echo BTC Low: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$2}' | sort -n | head -1)
	echo BTC Average: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$2}' | awk -F"," '{ BTCsum += $1 } END { print BTCsum / NR }')
	echo
	echo ETH High: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$3}' | sort -n | tail -1)
	echo ETH Low: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$3}' | sort -n | head -1)
	echo ETH Average: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$3}' | awk -F"," '{ ETHsum += $1 } END { print ETHsum / NR }')
	echo
	echo LTC High: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$4}' | sort -n | tail -1)
	echo LTC Low: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$4}' | sort -n | head -1)
	echo LTC Average: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$4}' | awk -F"," '{ LTCsum += $1 } END { print LTCsum / NR }')
	echo
	echo BCH High: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$5}' | sort -n | tail -1)
	echo BCH Low: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$5}' | sort -n | head -1)
	echo BCH Average: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$5}' | awk -F"," '{ BCHsum += $1 } END { print BCHsum / NR }')
	echo
																        echo DSH High: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$6}' | sort -n | tail -1)
																	        echo DSH Low: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$6}' | sort -n | head -1)
																		        echo DSH Average: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$6}' | awk -F"," '{ DSHsum += $1 } END { print DSHsum / NR }')              
																			        echo

        echo XRP High: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$7}' | sort -n | tail -1)
	echo XRP Low: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$7}' | sort -n | head -1)
	echo XRP Average: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$7}' | awk -F"," '{ XRPsum += $1 } END { print XRPsum / NR }')              
	echo
	echo DGB High: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$8}' | sort -n | tail -1)
	echo DGB Low: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$8}' | sort -n | head -1)
	echo DGB Average: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$8}' | awk -F"," '{ DGBsum += $1 } END { print DGBsum / NR }')              
	echo
	echo XLM High: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$9}' | sort -n | tail -1)
	echo XLM Low: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$9}' | sort -n | head -1)
	echo XLM Average: $(cat /home/leo/CryptoRecordings/$filen | awk -F"," '{if (NR > 1) print$9}' | awk -F"," '{ DGBsum += $1 } END { print DGBsum / NR }')               
	echo
echo
echo
#File analysis over. Menu to return to menu or analyze new file
echo Would you like to analyze another file or return to the menu?
echo Please input the integer of your desired outcome
ANALYZERITEMS="Restart Menu"
select analyzeritem in $ANALYZERITEMS
do
	case $analyzeritem in 
		Restart)
			clear
			echo Running File Analyzer Again...
			./filereader.sh
			;;
		Menu)
			clear
			echo Returning to Menu...
			./cryptomenu.sh
			;;
	esac
done
