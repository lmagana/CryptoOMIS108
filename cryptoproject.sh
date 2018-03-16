#!/bin/bash

echo You have entered the...
echo
printf "   ÛÛÛÛÛÛÛÛÛ                                  ÛÛÛÛÛ                ÛÛÛÛÛÛÛÛÛÛÛ                              ÛÛÛÛÛ                        \n"
printf "  ÛÛÛ°°°°°ÛÛÛ                                °°ÛÛÛ                °Û°°°ÛÛÛ°°°Û                             °°ÛÛÛ                         \n"
printf " ÛÛÛ     °°°  ÛÛÛÛÛÛÛÛ  ÛÛÛÛÛ ÛÛÛÛ ÛÛÛÛÛÛÛÛ  ÛÛÛÛÛÛÛ    ÛÛÛÛÛÛ    °   °ÛÛÛ  °  ÛÛÛÛÛÛÛÛ   ÛÛÛÛÛÛ    ÛÛÛÛÛÛ  °ÛÛÛ ÛÛÛÛÛ  ÛÛÛÛÛÛ  ÛÛÛÛÛÛÛÛ \n"
printf "°ÛÛÛ         °°ÛÛÛ°°ÛÛÛ°°ÛÛÛ °ÛÛÛ °°ÛÛÛ°°ÛÛÛ°°°ÛÛÛ°    ÛÛÛ°°ÛÛÛ       °ÛÛÛ    °°ÛÛÛ°°ÛÛÛ °°°°°ÛÛÛ  ÛÛÛ°°ÛÛÛ °ÛÛÛ°°ÛÛÛ  ÛÛÛ°°ÛÛÛ°°ÛÛÛ°°ÛÛÛ\n"
printf "°ÛÛÛ          °ÛÛÛ °°°  °ÛÛÛ °ÛÛÛ  °ÛÛÛ °ÛÛÛ  °ÛÛÛ    °ÛÛÛ °ÛÛÛ       °ÛÛÛ     °ÛÛÛ °°°   ÛÛÛÛÛÛÛ °ÛÛÛ °°°  °ÛÛÛÛÛÛ°  °ÛÛÛÛÛÛÛ  °ÛÛÛ °°° \n"
printf "°°ÛÛÛ     ÛÛÛ °ÛÛÛ      °ÛÛÛ °ÛÛÛ  °ÛÛÛ °ÛÛÛ  °ÛÛÛ ÛÛÛ°ÛÛÛ °ÛÛÛ       °ÛÛÛ     °ÛÛÛ      ÛÛÛ°°ÛÛÛ °ÛÛÛ  ÛÛÛ °ÛÛÛ°°ÛÛÛ °ÛÛÛ°°°   °ÛÛÛ     \n"
printf " °°ÛÛÛÛÛÛÛÛÛ  ÛÛÛÛÛ     °°ÛÛÛÛÛÛÛ  °ÛÛÛÛÛÛÛ   °°ÛÛÛÛÛ °°ÛÛÛÛÛÛ        ÛÛÛÛÛ    ÛÛÛÛÛ    °°ÛÛÛÛÛÛÛÛ°°ÛÛÛÛÛÛ  ÛÛÛÛ ÛÛÛÛÛ°°ÛÛÛÛÛÛ  ÛÛÛÛÛ    \n"
printf "  °°°°°°°°°  °°°°°       °°°°°ÛÛÛ  °ÛÛÛ°°°     °°°°°   °°°°°°        °°°°°    °°°°°      °°°°°°°°  °°°°°°  °°°° °°°°°  °°°°°°  °°°°°     \n"
printf "                         ÛÛÛ °ÛÛÛ  °ÛÛÛ                                                                                                  \n"
printf "                        °°ÛÛÛÛÛÛ   ÛÛÛÛÛ                                                                                                 \n"
printf "                         °°°°°°   °°°°°                                                                                                  \n"
echo

#Requesting user inputs
echo Please input the name of your new file.
read filename

echo How many times would you like to track the price?
read count

echo Interval of seconds between each price recording?
read seconds

#Calculate and present duration of price tracking
countdown=$((count*seconds+(count*5)))

echo Your file will be ready on this date and time: $(date -d "+$countdown sec")

#Creating header of excel file
echo Date/Time, BTC, ETH, LTC, BCH, DSH, XRP, DGB, XLM > /home/leo/CryptoRecordings/$filename.xls

#Declare variable for line count of tracking system file
linecount=$(cat /home/leo/CryptoRecordings/$filename.xls| wc -l)

while [ $linecount -le $count ]
do
	realdate=$(date)
	cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed "s/\x0f//g" > /home/leo/pricerecord.xls
	#Declaring variables for prices of each coin
		BTCUSD=$(cat pricerecord.xls| awk '{if (NR==4) print$5}')
		ETHUSD=$(cat pricerecord.xls| awk '{if (NR==5) print$5}')
		LTCUSD=$(cat pricerecord.xls| awk '{if (NR==6) print$5}')
		BCHUSD=$(cat pricerecord.xls| awk '{if (NR==7) print$6}')
		DSHUSD=$(cat pricerecord.xls| awk '{if (NR==8) print$5}')
		XRPUSD=$(cat pricerecord.xls| awk '{if (NR==9) print$5}')
		DGBUSD=$(cat pricerecord.xls| awk '{if (NR==10) print$5}')
		XLMUSD=$(cat pricerecord.xls| awk '{if (NR==11) print$5}')
	
		#Outlining the output below
 		echo $realdate, $BTCUSD, $ETHUSD, $LTCUSD, $BCHUSD, $DSHUSD, $XRPUSD, $DGBUSD, $XLMUSD >> /home/leo/CryptoRecordings/$filename.xls

		#Count lines of file 
		linecount=$(cat /home/leo/CryptoRecordings/$filename.xls| wc -l)
	sleep $seconds
done

echo Your file is ready.
echo -------------------
echo Would you like to analyze the file? yes or no?
read analyzeanswer
if [ $analyzeanswer = yes ]
then 
	echo Presenting Measurements...
	#Calculating High, Low, and Average price of each coin
	echo BTC High: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$2}' | sort -n | tail -1)
	echo BTC Low: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$2}' | sort -n | head -1)
	echo BTC Average: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$2}' | awk -F"," '{ BTCsum += $1 } END { print BTCsum / NR }')
	echo
   	echo ETH High: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$3}' | sort -n | tail -1)
	echo ETH Low: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$3}' | sort -n | head -1)
	echo ETH Average: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$3}' | awk -F"," '{ ETHsum += $1 } END { print ETHsum / NR }')
	echo
	echo LTC High: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$4}' | sort -n | tail -1)
	echo LTC Low: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$4}' | sort -n | head -1)
	echo LTC Average: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$4}' | awk -F"," '{ LTCsum += $1 } END { print LTCsum / NR }')
	echo
        echo BCH High: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$5}' | sort -n | tail -1)
	echo BCH Low: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$5}' | sort -n | head -1)
	echo BCH Average: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$5}' | awk -F"," '{ BCHsum += $1 } END { print BCHsum / NR }')
       	echo
        echo DSH High: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$6}' | sort -n | tail -1)
	echo DSH Low: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$6}' | sort -n | head -1)
	echo DSH Average: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$6}' | awk -F"," '{ DSHsum += $1 } END { print DSHsum / NR }')		    
    	echo
        echo XRP High: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$7}' | sort -n | tail -1)
	echo XRP Low: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$7}' | sort -n | head -1)
	echo XRP Average: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$7}' | awk -F"," '{ XRPsum += $1 } END { print XRPsum / NR }')              
	echo
        echo DGB High: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$8}' | sort -n | tail -1)
	echo DGB Low: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$8}' | sort -n | head -1)
	echo DGB Average: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$8}' | awk -F"," '{ DGBsum += $1 } END { print DGBsum / NR }')              
        echo
        echo XLM High: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$9}' | sort -n | tail -1)
	echo XLM Low: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$9}' | sort -n | head -1)
	echo XLM Average: $(cat /home/leo/CryptoRecordings/$filename.xls | awk -F"," '{if (NR > 1) print$9}' | awk -F"," '{ DGBsum += $1 } END { print DGBsum / NR }')               
	echo
else
	echo Would you like to track a new file or return to the menu?
	echo Please input the integer of your desired outcome. 
	TRACKERITEMS="Restart Menu"
	select traderitem in $TRACKERITEMS
	do
		case $traderitem in
			Restart)
				clear
				echo Running Crypto Tracker Again...
				./cryptoproject.sh
				;;
			Menu)
				clear
				echo Returning to Menu...
				./cryptomenu.sh
				;;
		esac
	done
fi
