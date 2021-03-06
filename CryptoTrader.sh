#!/bin/bash

clear
echo Welcome to the...
echo
printf "   ÛÛÛÛÛÛÛÛÛ                                  ÛÛÛÛÛ                ÛÛÛÛÛÛÛÛÛÛÛ                         ÛÛÛÛÛ                   \n"
printf "  ÛÛÛ°°°°°ÛÛÛ                                °°ÛÛÛ                °Û°°°ÛÛÛ°°°Û                        °°ÛÛÛ                    \n"
printf " ÛÛÛ     °°°  ÛÛÛÛÛÛÛÛ  ÛÛÛÛÛ ÛÛÛÛ ÛÛÛÛÛÛÛÛ  ÛÛÛÛÛÛÛ    ÛÛÛÛÛÛ    °   °ÛÛÛ  °  ÛÛÛÛÛÛÛÛ   ÛÛÛÛÛÛ    ÛÛÛÛÛÛÛ   ÛÛÛÛÛÛ  ÛÛÛÛÛÛÛÛ \n"
printf "°ÛÛÛ         °°ÛÛÛ°°ÛÛÛ°°ÛÛÛ °ÛÛÛ °°ÛÛÛ°°ÛÛÛ°°°ÛÛÛ°    ÛÛÛ°°ÛÛÛ       °ÛÛÛ    °°ÛÛÛ°°ÛÛÛ °°°°°ÛÛÛ  ÛÛÛ°°ÛÛÛ  ÛÛÛ°°ÛÛÛ°°ÛÛÛ°°ÛÛÛ\n"
printf "°ÛÛÛ          °ÛÛÛ °°°  °ÛÛÛ °ÛÛÛ  °ÛÛÛ °ÛÛÛ  °ÛÛÛ    °ÛÛÛ °ÛÛÛ       °ÛÛÛ     °ÛÛÛ °°°   ÛÛÛÛÛÛÛ °ÛÛÛ °ÛÛÛ °ÛÛÛÛÛÛÛ  °ÛÛÛ °°° \n"
printf "°°ÛÛÛ     ÛÛÛ °ÛÛÛ      °ÛÛÛ °ÛÛÛ  °ÛÛÛ °ÛÛÛ  °ÛÛÛ ÛÛÛ°ÛÛÛ °ÛÛÛ       °ÛÛÛ     °ÛÛÛ      ÛÛÛ°°ÛÛÛ °ÛÛÛ °ÛÛÛ °ÛÛÛ°°°   °ÛÛÛ     \n"
printf " °°ÛÛÛÛÛÛÛÛÛ  ÛÛÛÛÛ     °°ÛÛÛÛÛÛÛ  °ÛÛÛÛÛÛÛ   °°ÛÛÛÛÛ °°ÛÛÛÛÛÛ        ÛÛÛÛÛ    ÛÛÛÛÛ    °°ÛÛÛÛÛÛÛÛ°°ÛÛÛÛÛÛÛÛ°°ÛÛÛÛÛÛ  ÛÛÛÛÛ    \n"
printf "  °°°°°°°°°  °°°°°       °°°°°ÛÛÛ  °ÛÛÛ°°°     °°°°°   °°°°°°        °°°°°    °°°°°      °°°°°°°°  °°°°°°°°  °°°°°°  °°°°°     \n"
printf "                         ÛÛÛ °ÛÛÛ  °ÛÛÛ                                                                                        \n"
printf "                        °°ÛÛÛÛÛÛ   ÛÛÛÛÛ                                                                                       \n"
printf "                         °°°°°°   °°°°°                                                                                        \n"
echo
echo What type of trading stratgey do you want to use?
echo 1\) Buy when price increases x% in the next y minutes and sell after z minutes.
echo 2\) Buy now and sell if price increases above x%. Check every y minutes.

read strat

clear

echo Getting prices...
cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" > prices.txt
btcprice=$(cat prices.txt | awk '{if ($2 ~ /Bitcoin/ && $3 !~ /Cash/) print $5}')
ethprice=$(cat prices.txt | awk '{if ($2 ~ /Ethereum/) print $5}')
liteprice=$(cat prices.txt | awk '{if ($2 ~ /Litecoin/) print $5}')
bchprice=$(cat prices.txt | awk '{if ($2 ~ /Bitcoin/ && $3 ~ /Cash/) print $6}')
dashprice=$(cat prices.txt | awk '{if ($2 ~ /Dash/) print $5}')
rippleprice=$(cat prices.txt | awk '{if ($2 ~ /Ripple/) print $5}')
digiprice=$(cat prices.txt | awk '{if ($2 ~ /Digibyte/) print $5}')
stellarprice=$(cat prices.txt | awk '{if ($2 ~ /Stellar/) print $5}')

clear

echo Select which coin to trade.
echo 1\) Bitcoin \| Current Price: \$$btcprice
echo 2\) Ethereum \| Current Price: \$$ethprice
echo 3\) Litecoin \| Current Price: \$$liteprice
echo 4\) Bitcoin Cash \| Current Price: \$$bchprice 
echo 5\) Dash \| Current Price: \$$dashprice
echo 6\) Ripple \| Current Price: \$$rippleprice
echo 7\) Digibyte \| Current Price: \$$digiprice
echo 8\) Stellar \| Current Price: \$$stellarprice
echo 9\) Quit Program

read x
clear

if [ $x -eq 9 ]
	then
		exit 0
elif [ $x -ne 1 -a $x -ne 2 -a $x -ne 3 -a $x -ne 4 -a $x -ne 5 -a $x -ne 6 -a $x -ne 7 -a $x -ne 8 -a $x -ne 9 ]
	then
		echo Not a valid option. Please restart program.
		sleep 7s
		exit 0
fi

if [ $strat -eq 2 ]
then
	echo How often do you want to check the price of the coin \(in minutes\)?
	read interval
	clear

	echo At what percent increase from the buying price do you want to sell the coin at?
	read percent
	clear

	echo For how long do you want to be automatically checking prices \(in minutes\)?
	read maxtime
	end=$(echo "scale=2;$maxtime*60" | bc)
	clear

elif [ $strat -eq 1 ]
then
	echo In how many minutes do you want to check the price?
	read checktime
	checkseconds=$(echo "scale=2;$checktime*60" | bc)
	clear
	
	echo How much do you want the price to increase \(in a percentage\)?
	read priceincrease
	clear

	echo How many coins do you want to buy?
	read coinstobuy
	clear

	echo How long after you purchase the coin do you want to hold on to it until you sell it \(in minutes\)?
	read afterbuy
	aftersecs=$(echo "scale=2;$afterbuy*60" | bc)
	clear

	echo How long do you want to be checking prices for \(in minutes\)?
	read finishtime
	endtime=$(echo "scale=2;$finishtime*60" | bc)
else
	echo That is not a valid program. Please restart program.
	sleep 7s
	exit 0
fi



if [ $strat -eq 1 -o $strat -eq 2 ]
	then
		if [ $x -eq 1 ]
			then
				if [ $strat -eq 2 ]
					then
						echo How many Bitcoins do you want to purchase?
						read coinbuy
						worth=$(echo "scale=2;$btcprice * $coinbuy" | bc )
						newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 4) print $5}')
						percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $btcprice" | bc) / $btcprice" | bc ) * 100" | bc)
						while [ $SECONDS -lt $end ]
						do
							echo Checking prices now...
							newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 4) print $5}')
							percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $btcprice" | bc) / $btcprice" | bc )*100" | bc)
							
							if [ $(bc <<< "percentincrease" ) > "percent" ]
							then
								sellrevenue=$(echo "scale=2;$newprice * $coinbuy" | bc)
								profit=$(echo "scale=2;$sellrevenue - $worth" | bc)
								echo You have sold your $coinbuy Bitcoins at $(date)
								echo Your profit from this is \$$profit!
								break
							else	
								echo Price has only changed by $percentincrease% so far.
							fi
							sleep $(echo "scale=2;$interval * 60" | bc)
							echo
						done				
				elif [ $strat -eq 1 ]
					then
						while [ $SECONDS -lt $endtime ]
							do
							echo Going to check prices in $checktime minutes.
							sleep $checkseconds
							echo Checking price now...
							
							newprice=$(echo $(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 4) print $5}'))
							priceincreaseper=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $btcprice" | bc) / $btcprice" | bc ) * 100" | bc)
							clear
							if (($(echo "$percentincrease $priceincrease" | awk '{print($1 > $2)}')))
								then
								echo Price is now \$$newprice for one Bitcoin. There has only been a price change of $priceincreaseper%.
							elif (($(echo "$percentincrease >= $priceincrease" | bc -l)))
								then
								value=$(echo "scale=2;$coinstobuy*$newprice" | bc)
								echo You just bought \$$value worth of Bitcoin. Now holding for $afterbuy minutes.
								sleep $aftersecs
								clear
								newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"|sed -r "s/\x0f//g"|awk '{if(NR==4)print$5}')
								sold=$(echo "scale=2;$newprice*$coinstobuy" | bc)
								profit=$(echo "scale=2;$sold - $value" | bc)
								echo After $afterbuy minutes, you have sold your Bitcoins for a total of \$$sold. A profit of \$$profit!

									
						
							fi
							done
				fi
		elif [ $x -eq 2 ]
			then
				if [ $strat -eq 2 ]
					then
						echo How many Ethereum coins do you want to purchase?
						read coinbuy
						worth=$(echo "scale=2;$ethprice * $coinbuy" | bc )
						newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 5) print $5}')
						percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $ethprice" | bc) / $ethprice" | bc ) * 100" | bc)
						while [ $SECONDS -lt $end ]
						do
							echo Checking prices now...
							newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 5) print $5}')
							percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $ethprice" | bc) / $ethprice" | bc )*100" | bc)
							
							if [ $(bc <<< "percentincrease" ) > "percent" ]
							then
								sellrevenue=$(echo "scale=2;$newprice * $coinbuy" | bc)
								profit=$(echo "scale=2;$sellrevenue - $worth" | bc)
								echo You have sold your $coinbuy Ethereum coins at $(date)
								echo Your profit from this is \$$profit!
								break
							else	
								echo Price has only changed by $percentincrease% so far.
							fi
							sleep $(echo "scale=2;$interval * 60" | bc)
							echo
						done				
				elif [ $strat -eq 1 ]
					then
						while [ $SECONDS -lt $endtime ]
							do
							echo Going to check prices in $checktime minutes.
							sleep $checkseconds
							echo Checking price now...
							
							newprice=$(echo $(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 5) print $5}'))
							priceincreaseper=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $ethprice" | bc) / $ethprice" | bc ) * 100" | bc)
							clear
							if (($(echo "$percentincrease $priceincrease" | awk '{print($1 > $2)}')))
								then
								echo Price is now \$$newprice for one Ethereum coin. There has only been a price change of $priceincreaseper%.
							elif (($(echo "$percentincrease >= $priceincrease" | bc -l)))
								then
								value=$(echo "scale=2;$coinstobuy*$newprice" | bc)
								echo You just bought \$$value worth of Ethereum coins. Now holding for $afterbuy minutes.
								sleep $aftersecs
								clear
								newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"|sed -r "s/\x0f//g"|awk '{if(NR==5)print$5}')
								sold=$(echo "scale=2;$newprice*$coinstobuy" | bc)
								profit=$(echo "scale=2;$sold - $value" | bc)
								echo After $afterbuy minutes, you have sold your Ethereum coins for a total of \$$sold. A profit of \$$profit!

									
						
							fi
							done
				fi
		elif [ $x -eq 3 ]
			then
				if [ $strat -eq 2 ]
					then
						echo How many Litecoins do you want to purchase?
						read coinbuy
						worth=$(echo "scale=2;$liteprice * $coinbuy" | bc )
						newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 6) print $5}')
						percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $liteprice" | bc) / $liteprice" | bc ) * 100" | bc)
						while [ $SECONDS -lt $end ]
						do
							echo Checking prices now...
							newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 6) print $5}')
							percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $liteprice" | bc) / $liteprice" | bc )*100" | bc)
							
							if [ $(bc <<< "percentincrease" ) > "percent" ]
							then
								sellrevenue=$(echo "scale=2;$newprice * $coinbuy" | bc)
								profit=$(echo "scale=2;$sellrevenue - $worth" | bc)
								echo You have sold your $coinbuy Litecoins at $(date)
								echo Your profit from this is \$$profit!
								break
							else	
								echo Price has only changed by $percentincrease% so far.
							fi
							sleep $(echo "scale=2;$interval * 60" | bc)
							echo
						done				
				elif [ $strat -eq 1 ]
					then
						while [ $SECONDS -lt $endtime ]
							do
							echo Going to check prices in $checktime minutes.
							sleep $checkseconds
							echo Checking price now...
							
							newprice=$(echo $(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 6) print $5}'))
							priceincreaseper=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $liteprice" | bc) / $liteprice" | bc ) * 100" | bc)
							clear
							if (($(echo "$percentincrease $priceincrease" | awk '{print($1 > $2)}')))
								then
								echo Price is now \$$newprice for one Litecoin. There has only been a price change of $priceincreaseper%.
							elif (($(echo "$percentincrease >= $priceincrease" | bc -l)))
								then
								value=$(echo "scale=2;$coinstobuy*$newprice" | bc)
								echo You just bought \$$value worth of Litecoin. Now holding for $afterbuy minutes.
								sleep $aftersecs
								clear
								newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"|sed -r "s/\x0f//g"|awk '{if(NR==6)print$5}')
								sold=$(echo "scale=2;$newprice*$coinstobuy" | bc)
								profit=$(echo "scale=2;$sold - $value" | bc)
								echo After $afterbuy minutes, you have sold your Litecoins for a total of \$$sold. A profit of \$$profit!

									
						
							fi
							done
				fi
		elif [ $x -eq 4 ]
			then
				if [ $strat -eq 2 ]
					then
						echo How much Bitcoin cash do you want to purchase?
						read coinbuy
						worth=$(echo "scale=2;$bchprice * $coinbuy" | bc )
						newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 7) print $5}')
						percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $bchprice" | bc) / $bchprice" | bc ) * 100" | bc)
						while [ $SECONDS -lt $end ]
						do
							echo Checking prices now...
							newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 7) print $5}')
							percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $bchprice" | bc) / $bchprice" | bc )*100" | bc)
							
							if [ $(bc <<< "percentincrease" ) > "percent" ]
							then
								sellrevenue=$(echo "scale=2;$newprice * $coinbuy" | bc)
								profit=$(echo "scale=2;$sellrevenue - $worth" | bc)
								echo You have sold your $coinbuy Bitcoin cash at $(date)
								echo Your profit from this is \$$profit!
								break
							else	
								echo Price has only changed by $percentincrease% so far.
							fi
							sleep $(echo "scale=2;$interval * 60" | bc)
							echo
						done				
				elif [ $strat -eq 1 ]
					then
						while [ $SECONDS -lt $endtime ]
							do
							echo Going to check prices in $checktime minutes.
							sleep $checkseconds
							echo Checking price now...
							
							newprice=$(echo $(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 7) print $5}'))
							priceincreaseper=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $bchprice" | bc) / $bchprice" | bc ) * 100" | bc)
							clear
							if (($(echo "$percentincrease $priceincrease" | awk '{print($1 > $2)}')))
								then
								echo Price is now \$$newprice for one Bitcoin Cash. There has only been a price change of $priceincreaseper%.
							elif (($(echo "$percentincrease >= $priceincrease" | bc -l)))
								then
								value=$(echo "scale=2;$coinstobuy*$newprice" | bc)
								echo You just bought \$$value worth of Bitcoin Cash. Now holding for $afterbuy minutes.
								sleep $aftersecs
								clear
								newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"|sed -r "s/\x0f//g"|awk '{if(NR==7)print$5}')
								sold=$(echo "scale=2;$newprice*$coinstobuy" | bc)
								profit=$(echo "scale=2;$sold - $value" | bc)
								echo After $afterbuy minutes, you have sold your Bitcoin cash for a total of \$$sold. A profit of \$$profit!

									
						
							fi
							done
				fi
		elif [ $x -eq 5 ]
			then
				if [ $strat -eq 2 ]
					then
						echo How much Dash coin do you want to purchase?
						read coinbuy
						worth=$(echo "scale=2;$dashprice * $coinbuy" | bc )
						newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 8) print $5}')
						percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $dashprice" | bc) / $dashprice" | bc ) * 100" | bc)
						while [ $SECONDS -lt $end ]
						do
							echo Checking prices now...
							newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 8) print $5}')
							percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $dashprice" | bc) / $dashprice" | bc )*100" | bc)
							
							if [ $(bc <<< "percentincrease" ) > "percent" ]
							then
								sellrevenue=$(echo "scale=2;$newprice * $coinbuy" | bc)
								profit=$(echo "scale=2;$sellrevenue - $worth" | bc)
								echo You have sold your $coinbuy Dash coins at $(date)
								echo Your profit from this is \$$profit!
								break
							else	
								echo Price has only changed by $percentincrease% so far.
							fi
							sleep $(echo "scale=2;$interval * 60" | bc)
							echo
						done				
				elif [ $strat -eq 1 ]
					then
						while [ $SECONDS -lt $endtime ]
							do
							echo Going to check prices in $checktime minutes.
							sleep $checkseconds
							echo Checking price now...
							
							newprice=$(echo $(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 8) print $5}'))
							priceincreaseper=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $dashprice" | bc) / $dashprice" | bc ) * 100" | bc)
							clear
							if (($(echo "$percentincrease $priceincrease" | awk '{print($1 > $2)}')))
								then
								echo Price is now \$$newprice for one Dash coin. There has only been a price change of $priceincreaseper%.
							elif (($(echo "$percentincrease >= $priceincrease" | bc -l)))
								then
								value=$(echo "scale=2;$coinstobuy*$newprice" | bc)
								echo You just bought \$$value worth of Dash coins. Now holding for $afterbuy minutes.
								sleep $aftersecs
								clear
								newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"|sed -r "s/\x0f//g"|awk '{if(NR==8)print$5}')
								sold=$(echo "scale=2;$newprice*$coinstobuy" | bc)
								profit=$(echo "scale=2;$sold - $value" | bc)
								echo After $afterbuy minutes, you have sold your Dash coins for a total of \$$sold. A profit of \$$profit!

									
						
							fi
							done
				fi
		elif [ $x -eq 6 ]
			then
				if [ $strat -eq 2 ]
					then
						echo How much Ripple coin do you want to purchase?
						read coinbuy
						worth=$(echo "scale=2;$rippleprice * $coinbuy" | bc )
						newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 9) print $5}')
						percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $rippleprice" | bc) / $rippleprice" | bc ) * 100" | bc)
						while [ $SECONDS -lt $end ]
						do
							echo Checking prices now...
							newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 9) print $5}')
							percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $rippleprice" | bc) / $rippleprice" | bc )*100" | bc)
							
							if [ $(bc <<< "percentincrease" ) > "percent" ]
							then
								sellrevenue=$(echo "scale=2;$newprice * $coinbuy" | bc)
								profit=$(echo "scale=2;$sellrevenue - $worth" | bc)
								echo You have sold your $coinbuy Ripple coins at $(date)
								echo Your profit from this is \$$profit!
								break
							else	
								echo Price has only changed by $percentincrease% so far.
							fi
							sleep $(echo "scale=2;$interval * 60" | bc)
							echo
						done				
				elif [ $strat -eq 1 ]
					then
						while [ $SECONDS -lt $endtime ]
							do
							echo Going to check prices in $checktime minutes.
							sleep $checkseconds
							echo Checking price now...
							
							newprice=$(echo $(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 9) print $5}'))
							priceincreaseper=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $rippleprice" | bc) / $rippleprice" | bc ) * 100" | bc)
							clear
							if (($(echo "$percentincrease $priceincrease" | awk '{print($1 > $2)}')))
								then
								echo Price is now \$$newprice for one Dash coin. There has only been a price change of $priceincreaseper%.
							elif (($(echo "$percentincrease >= $priceincrease" | bc -l)))
								then
								value=$(echo "scale=2;$coinstobuy*$newprice" | bc)
								echo You just bought \$$value worth of Ripple coins. Now holding for $afterbuy minutes.
								sleep $aftersecs
								clear
								newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"|sed -r "s/\x0f//g"|awk '{if(NR==9)print$5}')
								sold=$(echo "scale=2;$newprice*$coinstobuy" | bc)
								profit=$(echo "scale=2;$sold - $value" | bc)
								echo After $afterbuy minutes, you have sold your Ripple coins for a total of \$$sold. A profit of \$$profit!

									
						
							fi
							done
				fi
		elif [ $x -eq 7  ]
			then
				if [ $strat -eq 2 ]
					then
						echo How much Digibyte coin do you want to purchase?
						read coinbuy
						worth=$(echo "scale=2;$digiprice * $coinbuy" | bc )
						newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 10) print $5}')
						percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $digiprice" | bc) / $digiprice" | bc ) * 100" | bc)
						while [ $SECONDS -lt $end ]
						do
							echo Checking prices now...
							newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 10) print $5}')
							percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $digiprice" | bc) / $digiprice" | bc )*100" | bc)
							
							if [ $(bc <<< "percentincrease" ) > "percent" ]
							then
								sellrevenue=$(echo "scale=2;$newprice * $coinbuy" | bc)
								profit=$(echo "scale=2;$sellrevenue - $worth" | bc)
								echo You have sold your $coinbuy Digibyte coins at $(date)
								echo Your profit from this is \$$profit!
								break
							else	
								echo Price has only changed by $percentincrease% so far.
							fi
							sleep $(echo "scale=2;$interval * 60" | bc)
							echo
						done				
				elif [ $strat -eq 1 ]
					then
						while [ $SECONDS -lt $endtime ]
							do
							echo Going to check prices in $checktime minutes.
							sleep $checkseconds
							echo Checking price now...
							
							newprice=$(echo $(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 10) print $5}'))
							priceincreaseper=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $digiprice" | bc) / $digiprice" | bc ) * 100" | bc)
							clear
							if (($(echo "$percentincrease $priceincrease" | awk '{print($1 > $2)}')))
								then
								echo Price is now \$$newprice for one Digibyte coin. There has only been a price change of $priceincreaseper%.
							elif (($(echo "$percentincrease >= $priceincrease" | bc -l)))
								then
								value=$(echo "scale=2;$coinstobuy*$newprice" | bc)
								echo You just bought \$$value worth of Digibyte coins. Now holding for $afterbuy minutes.
								sleep $aftersecs
								clear
								newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"|sed -r "s/\x0f//g"|awk '{if(NR==10)print$5}')
								sold=$(echo "scale=2;$newprice*$coinstobuy" | bc)
								profit=$(echo "scale=2;$sold - $value" | bc)
								echo After $afterbuy minutes, you have sold your Digibyte coins for a total of \$$sold. A profit of \$$profit!

									
						
							fi
							done
				fi
		elif [ $x -eq 8 ]
			then
				if [ $strat -eq 2 ]
					then
						echo How much Stellar coin do you want to purchase?
						read coinbuy
						worth=$(echo "scale=2;$stellarprice * $coinbuy" | bc )
						newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 11) print $5}')
						percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $stellarprice" | bc) / $stellarprice" | bc ) * 100" | bc)
						while [ $SECONDS -lt $end ]
						do
							echo Checking prices now...
							newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 10) print $5}')
							percentincrease=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $stellarprice" | bc) / $stellarprice" | bc )*100" | bc)
							
							if [ $(bc <<< "percentincrease" ) > "percent" ]
							then
								sellrevenue=$(echo "scale=2;$newprice * $coinbuy" | bc)
								profit=$(echo "scale=2;$sellrevenue - $worth" | bc)
								echo You have sold your $coinbuy Digibyte coins at $(date)
								echo Your profit from this is \$$profit!
								break
							else	
								echo Price has only changed by $percentincrease% so far.
							fi
							sleep $(echo "scale=2;$interval * 60" | bc)
							echo
						done				
				elif [ $strat -eq 1 ]
					then
						while [ $SECONDS -lt $endtime ]
							do
							echo Going to check prices in $checktime minutes.
							sleep $checkseconds
							echo Checking price now...
							
							newprice=$(echo $(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | sed -r "s/\x0f//g" | awk '{if (NR == 11) print $5}'))
							priceincreaseper=$(echo "scale=2;$(echo "scale=2;$(echo "scale=2;$newprice - $stellarprice" | bc) / $stellarprice" | bc ) * 100" | bc)
							clear
							if (($(echo "$percentincrease $priceincrease" | awk '{print($1 > $2)}')))
								then
								echo Price is now \$$newprice for one Stellar coin. There has only been a price change of $priceincreaseper%.
							elif (($(echo "$percentincrease >= $priceincrease" | bc -l)))
								then
								value=$(echo "scale=2;$coinstobuy*$newprice" | bc)
								echo You just bought \$$value worth of Stellar coins. Now holding for $afterbuy minutes.
								sleep $aftersecs
								clear
								newprice=$(cryptowatch | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"|sed -r "s/\x0f//g"|awk '{if(NR==11)print$5}')
								sold=$(echo "scale=2;$newprice*$coinstobuy" | bc)
								profit=$(echo "scale=2;$sold - $value" | bc)
								echo After $afterbuy minutes, you have sold your Stellar coins for a total of \$$sold. A profit of \$$profit!

									
						
							fi
							done
				fi
		fi
fi

