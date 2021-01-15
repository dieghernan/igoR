
**state-year graphs 
cd "/Users/jonpevehouse/Dropbox/IGO Project/Codebook Paper/"

use "/Users/jonpevehouse/Dropbox/IGO Project/Codebook Paper/state_year_formatv3.dta", clear

mvdecode AAAID-Wassen, mv(-1)

egen nigos = anycount(AAAID-Wassen), v(1 2)
label var nigos "Number of memberships"

tsset ccode year

set scheme s2mono

twoway (line nigos year if ccode==710 & year>=1865, msymbol(i) cmissing(n)) ///
 (line nigos year if ccode==750 & year>=1865, cmissing(n)) ///
 (line nigos year if ccode==770 & year>=1865, cmissing(n)) /// 
 (line nigos year if ccode==850 & year>=1865, cmissing(n)) ///
 (line nigos year if ccode==771 & year>=1865, cmissing(n)), ///
 xtitle("") xlab(1865(25)2015) ///
 legend(r(2) label(1 "China") label(2 "India") label(3 "Pakistan") label(4 "Indonesia") label(5 "Bangladesh"))
graph export JPR_figure4.eps, replace

twoway (line nigos year if ccode==560 & year>=1890, msymbol(i) cmissing(n)) ///
 (line nigos year if ccode==510 & year>=1890, cmissing(n)) ///
 (line nigos year if ccode==475 & year>=1890, cmissing(n)) /// 
 (line nigos year if ccode==530 & year>=1890, cmissing(n)) ///
 (line nigos year if ccode==490 & year>=1890, cmissing(n)), ///
 xtitle("") xlab(1890(25)2015) ///
 legend(label(1 "South Africa") label(2 "Tanzania") label(3 "Nigeria") label(4 "Ethiopia") label(5 "DPRC") r(2))
graph export JPR_figure5.eps, replace


** igo-year analysis
cd "/Users/jonpevehouse/Dropbox/IGO Project/Codebook Paper/"
use "/Users/jonpevehouse/Dropbox/IGO Project/Codebook Paper/igo_year_formatv3.0.dta", clear


*set up and time series graph
set scheme s2mono
set more off

egen nstates = anycount(afghanistan-zimbabwe), v(0 1 2 3 -9)
label var nstates "Number of COW states"

gen empty = 1 if afghanistan==-9

mvdecode afghanistan-zimbabwe, mv(-1)

gen one = 1

egen totIGOs = sum(one), by(year)

tsset ionum year

egen totIGOs_data = sum(one) if empty~=1, by(year)
compress

label var totIGOs "Total IGOs"

*figure 1
twoway line totIGOs nstates year if nstates~=217, xtitle("") ///
  xline(1989) xline(1945) sort msymbol(i)
graph export JPR_figure1.eps, replace

*birth/death rates
sort ioname year
gen newigo = 1 if ioname~=ioname[_n-1]
egen igocreate = sum(newigo), by(year)
label var igocreate "IGO births"

egen igodeath = sum(dead), by(year)
label var igodeath "IGO deaths"

**figure 2
twoway line igocreate igodeath year if nstates~=217, xtitle("") ///
 sort msymbol(i)  xlab(1815(25)2015)
graph export JPR_figure2.eps, replace

*% imputed figure in text
tab imputed if year<=1964

**create regional variables**

*Asia
gen Asia = . 
replace Asia = 1 if ionum == 550
replace Asia = 1 if ionum == 560
replace Asia = 1 if ionum == 570
replace Asia = 1 if ionum == 580
replace Asia = 1 if ionum == 590
replace Asia = 1 if ionum == 600
replace Asia = 1 if ionum == 610
replace Asia = 1 if ionum == 640
replace Asia = 1 if ionum == 650
replace Asia = 1 if ionum == 660
replace Asia = 1 if ionum == 670
replace Asia = 1 if ionum == 725
replace Asia = 1 if ionum == 750
replace Asia = 1 if ionum == 825
replace Asia = 1 if ionum == 1030
replace Asia = 1 if ionum == 1345
replace Asia = 1 if ionum == 1400
replace Asia = 1 if ionum == 1530
replace Asia = 1 if ionum == 1532
replace Asia = 1 if ionum == 2300
replace Asia = 1 if ionum == 2770
replace Asia = 1 if ionum == 3185
replace Asia = 1 if ionum == 3330
replace Asia = 1 if ionum == 3560
replace Asia = 1 if ionum == 3930
replace Asia = 1 if ionum == 4115
replace Asia = 1 if ionum == 4150
replace Asia = 1 if ionum == 4160
replace Asia = 1 if ionum == 4170
replace Asia = 1 if ionum == 4190
replace Asia = 1 if ionum == 4200
replace Asia = 1 if ionum == 4220
replace Asia = 1 if ionum == 4265
replace Asia = 1 if ionum == 4440

*Middle East
gen MiddleEast = . 
replace MiddleEast = 1 if ionum == 370
replace MiddleEast = 1 if ionum == 380
replace MiddleEast = 1 if ionum == 390
replace MiddleEast = 1 if ionum == 400
replace MiddleEast = 1 if ionum == 410
replace MiddleEast = 1 if ionum == 420
replace MiddleEast = 1 if ionum == 430
replace MiddleEast = 1 if ionum == 440
replace MiddleEast = 1 if ionum == 450
replace MiddleEast = 1 if ionum == 460
replace MiddleEast = 1 if ionum == 470
replace MiddleEast = 1 if ionum == 490
replace MiddleEast = 1 if ionum == 500
replace MiddleEast = 1 if ionum == 510
replace MiddleEast = 1 if ionum == 520
replace MiddleEast = 1 if ionum == 1110
replace MiddleEast = 1 if ionum == 1410
replace MiddleEast = 1 if ionum == 1990
replace MiddleEast = 1 if ionum == 2000
replace MiddleEast = 1 if ionum == 2220
replace MiddleEast = 1 if ionum == 3450
replace MiddleEast = 1 if ionum == 3800
replace MiddleEast = 1 if ionum == 4140
replace MiddleEast = 1 if ionum == 4270
replace MiddleEast = 1 if ionum == 4380

*Europe
gen Europe = . 
replace Europe = 1 if ionum == 20
replace Europe = 1 if ionum == 300
replace Europe = 1 if ionum == 780
replace Europe = 1 if ionum == 800
replace Europe = 1 if ionum == 832
replace Europe = 1 if ionum == 840
replace Europe = 1 if ionum == 860
replace Europe = 1 if ionum == 1020
replace Europe = 1 if ionum == 1050
replace Europe = 1 if ionum == 1070
replace Europe = 1 if ionum == 1080
replace Europe = 1 if ionum == 1125
replace Europe = 1 if ionum == 1140
replace Europe = 1 if ionum == 1390
replace Europe = 1 if ionum == 1420
replace Europe = 1 if ionum == 1440
replace Europe = 1 if ionum == 1563
replace Europe = 1 if ionum == 1565
replace Europe = 1 if ionum == 1580
replace Europe = 1 if ionum == 1585
replace Europe = 1 if ionum == 1590
replace Europe = 1 if ionum == 1600
replace Europe = 1 if ionum == 1610
replace Europe = 1 if ionum == 1620
replace Europe = 1 if ionum == 1630
replace Europe = 1 if ionum == 1640
replace Europe = 1 if ionum == 1645
replace Europe = 1 if ionum == 1653
replace Europe = 1 if ionum == 1660
replace Europe = 1 if ionum == 1670
replace Europe = 1 if ionum == 1675
replace Europe = 1 if ionum == 1680
replace Europe = 1 if ionum == 1690
replace Europe = 1 if ionum == 1700
replace Europe = 1 if ionum == 1710
replace Europe = 1 if ionum == 1715
replace Europe = 1 if ionum == 1720
replace Europe = 1 if ionum == 1730
replace Europe = 1 if ionum == 1740
replace Europe = 1 if ionum == 1750
replace Europe = 1 if ionum == 1760
replace Europe = 1 if ionum == 1770
replace Europe = 1 if ionum == 1780
replace Europe = 1 if ionum == 1790
replace Europe = 1 if ionum == 1800
replace Europe = 1 if ionum == 1810
replace Europe = 1 if ionum == 1820
replace Europe = 1 if ionum == 1830
replace Europe = 1 if ionum == 1930
replace Europe = 1 if ionum == 1970
replace Europe = 1 if ionum == 1980
replace Europe = 1 if ionum == 2310
replace Europe = 1 if ionum == 2325
replace Europe = 1 if ionum == 2345
replace Europe = 1 if ionum == 2440
replace Europe = 1 if ionum == 2450
replace Europe = 1 if ionum == 2550
replace Europe = 1 if ionum == 2575
replace Europe = 1 if ionum == 2610
replace Europe = 1 if ionum == 2650
replace Europe = 1 if ionum == 2705
replace Europe = 1 if ionum == 2890
replace Europe = 1 if ionum == 2972
replace Europe = 1 if ionum == 3010
replace Europe = 1 if ionum == 3095
replace Europe = 1 if ionum == 3230
replace Europe = 1 if ionum == 3290
replace Europe = 1 if ionum == 3360
replace Europe = 1 if ionum == 3485
replace Europe = 1 if ionum == 3505
replace Europe = 1 if ionum == 3585
replace Europe = 1 if ionum == 3590
replace Europe = 1 if ionum == 3600
replace Europe = 1 if ionum == 3610
replace Europe = 1 if ionum == 3620
replace Europe = 1 if ionum == 3630
replace Europe = 1 if ionum == 3640
replace Europe = 1 if ionum == 3650
replace Europe = 1 if ionum == 3655
replace Europe = 1 if ionum == 3660
replace Europe = 1 if ionum == 3665
replace Europe = 1 if ionum == 3762
replace Europe = 1 if ionum == 3810
replace Europe = 1 if ionum == 3855
replace Europe = 1 if ionum == 3860
replace Europe = 1 if ionum == 3910
replace Europe = 1 if ionum == 4000
replace Europe = 1 if ionum == 4350
replace Europe = 1 if ionum == 4450
replace Europe = 1 if ionum == 4460
replace Europe = 1 if ionum == 4510
replace Europe = 1 if ionum == 4520
replace Europe = 1 if ionum == 4540

*Africa
gen Africa = . 
replace Africa = 1 if ionum == 30
replace Africa = 1 if ionum == 40
replace Africa = 1 if ionum == 50
replace Africa = 1 if ionum == 60
replace Africa = 1 if ionum == 80
replace Africa = 1 if ionum == 90
replace Africa = 1 if ionum == 100
replace Africa = 1 if ionum == 110
replace Africa = 1 if ionum == 115
replace Africa = 1 if ionum == 120
replace Africa = 1 if ionum == 125
replace Africa = 1 if ionum == 130
replace Africa = 1 if ionum == 140
replace Africa = 1 if ionum == 150
replace Africa = 1 if ionum == 155
replace Africa = 1 if ionum == 160
replace Africa = 1 if ionum == 170
replace Africa = 1 if ionum == 180
replace Africa = 1 if ionum == 190
replace Africa = 1 if ionum == 200
replace Africa = 1 if ionum == 210
replace Africa = 1 if ionum == 225
replace Africa = 1 if ionum == 240
replace Africa = 1 if ionum == 250
replace Africa = 1 if ionum == 260
replace Africa = 1 if ionum == 280
replace Africa = 1 if ionum == 290
replace Africa = 1 if ionum == 690
replace Africa = 1 if ionum == 700
replace Africa = 1 if ionum == 710
replace Africa = 1 if ionum == 940
replace Africa = 1 if ionum == 1060
replace Africa = 1 if ionum == 1150
replace Africa = 1 if ionum == 1170
replace Africa = 1 if ionum == 1260
replace Africa = 1 if ionum == 1290
replace Africa = 1 if ionum == 1310
replace Africa = 1 if ionum == 1320
replace Africa = 1 if ionum == 1330
replace Africa = 1 if ionum == 1340
replace Africa = 1 if ionum == 1355
replace Africa = 1 if ionum == 1430
replace Africa = 1 if ionum == 1450
replace Africa = 1 if ionum == 1460
replace Africa = 1 if ionum == 1470
replace Africa = 1 if ionum == 1475
replace Africa = 1 if ionum == 1480
replace Africa = 1 if ionum == 1500
replace Africa = 1 if ionum == 1510
replace Africa = 1 if ionum == 1520
replace Africa = 1 if ionum == 1870
replace Africa = 1 if ionum == 2080
replace Africa = 1 if ionum == 2090
replace Africa = 1 if ionum == 2230
replace Africa = 1 if ionum == 2330
replace Africa = 1 if ionum == 2795
replace Africa = 1 if ionum == 3300
replace Africa = 1 if ionum == 3310
replace Africa = 1 if ionum == 3470
replace Africa = 1 if ionum == 3480
replace Africa = 1 if ionum == 3510
replace Africa = 1 if ionum == 3520
replace Africa = 1 if ionum == 3570
replace Africa = 1 if ionum == 3740
replace Africa = 1 if ionum == 3760
replace Africa = 1 if ionum == 3761
replace Africa = 1 if ionum == 3790
replace Africa = 1 if ionum == 3820
replace Africa = 1 if ionum == 3875
replace Africa = 1 if ionum == 3905
replace Africa = 1 if ionum == 3970
replace Africa = 1 if ionum == 4010
replace Africa = 1 if ionum == 4030
replace Africa = 1 if ionum == 4050
replace Africa = 1 if ionum == 4055
replace Africa = 1 if ionum == 4080
replace Africa = 1 if ionum == 4110
replace Africa = 1 if ionum == 4120
replace Africa = 1 if ionum == 4130
replace Africa = 1 if ionum == 4230
replace Africa = 1 if ionum == 4240
replace Africa = 1 if ionum == 4250
replace Africa = 1 if ionum == 4251
replace Africa = 1 if ionum == 4340
replace Africa = 1 if ionum == 4365
replace Africa = 1 if ionum == 4480
replace Africa = 1 if ionum == 4485
replace Africa = 1 if ionum == 4490
replace Africa = 1 if ionum == 4500
replace Africa = 1 if ionum == 4501
replace Africa = 1 if ionum == 4503

*Americas
gen Americas = . 
replace Americas = 1 if ionum == 310
replace Americas = 1 if ionum == 320
replace Americas = 1 if ionum == 330
replace Americas = 1 if ionum == 340
replace Americas = 1 if ionum == 720
replace Americas = 1 if ionum == 760
replace Americas = 1 if ionum == 815
replace Americas = 1 if ionum == 875
replace Americas = 1 if ionum == 880
replace Americas = 1 if ionum == 890
replace Americas = 1 if ionum == 900
replace Americas = 1 if ionum == 910
replace Americas = 1 if ionum == 912
replace Americas = 1 if ionum == 913
replace Americas = 1 if ionum == 920
replace Americas = 1 if ionum == 950
replace Americas = 1 if ionum == 970
replace Americas = 1 if ionum == 980
replace Americas = 1 if ionum == 990
replace Americas = 1 if ionum == 1000
replace Americas = 1 if ionum == 1010
replace Americas = 1 if ionum == 1095
replace Americas = 1 if ionum == 1130
replace Americas = 1 if ionum == 1486
replace Americas = 1 if ionum == 1489
replace Americas = 1 if ionum == 1490
replace Americas = 1 if ionum == 1860
replace Americas = 1 if ionum == 1890
replace Americas = 1 if ionum == 1920
replace Americas = 1 if ionum == 1950
replace Americas = 1 if ionum == 2070
replace Americas = 1 if ionum == 2110
replace Americas = 1 if ionum == 2120
replace Americas = 1 if ionum == 2130
replace Americas = 1 if ionum == 2140
replace Americas = 1 if ionum == 2150
replace Americas = 1 if ionum == 2160
replace Americas = 1 if ionum == 2170
replace Americas = 1 if ionum == 2175
replace Americas = 1 if ionum == 2180
replace Americas = 1 if ionum == 2190
replace Americas = 1 if ionum == 2200
replace Americas = 1 if ionum == 2203
replace Americas = 1 if ionum == 2206
replace Americas = 1 if ionum == 2210
replace Americas = 1 if ionum == 2260
replace Americas = 1 if ionum == 2340
replace Americas = 1 if ionum == 2490
replace Americas = 1 if ionum == 2560
replace Americas = 1 if ionum == 2980
replace Americas = 1 if ionum == 3060
replace Americas = 1 if ionum == 3340
replace Americas = 1 if ionum == 3370
replace Americas = 1 if ionum == 3380
replace Americas = 1 if ionum == 3390
replace Americas = 1 if ionum == 3400
replace Americas = 1 if ionum == 3410
replace Americas = 1 if ionum == 3420
replace Americas = 1 if ionum == 3428
replace Americas = 1 if ionum == 3430
replace Americas = 1 if ionum == 3670
replace Americas = 1 if ionum == 3680
replace Americas = 1 if ionum == 3812
replace Americas = 1 if ionum == 3830
replace Americas = 1 if ionum == 3880
replace Americas = 1 if ionum == 3890
replace Americas = 1 if ionum == 3900
replace Americas = 1 if ionum == 3925
replace Americas = 1 if ionum == 3980
replace Americas = 1 if ionum == 4070
replace Americas = 1 if ionum == 4100
replace Americas = 1 if ionum == 4260
replace Americas = 1 if ionum == 4280
replace Americas = 1 if ionum == 4370

*universal
gen universal = . 
replace universal = 1 if ionum == 730
replace universal = 1 if ionum == 810
replace universal = 1 if ionum == 850
replace universal = 1 if ionum == 871
replace universal = 1 if ionum == 1040
replace universal = 1 if ionum == 1160
replace universal = 1 if ionum == 1380
replace universal = 1 if ionum == 1570
replace universal = 1 if ionum == 1650
replace universal = 1 if ionum == 1840
replace universal = 1 if ionum == 1880
replace universal = 1 if ionum == 1900
replace universal = 1 if ionum == 1905
replace universal = 1 if ionum == 1960
replace universal = 1 if ionum == 2010
replace universal = 1 if ionum == 2240
replace universal = 1 if ionum == 2250
replace universal = 1 if ionum == 2290
replace universal = 1 if ionum == 2320
replace universal = 1 if ionum == 2350
replace universal = 1 if ionum == 2360
replace universal = 1 if ionum == 2370
replace universal = 1 if ionum == 2390
replace universal = 1 if ionum == 2400
replace universal = 1 if ionum == 2430
replace universal = 1 if ionum == 2455
replace universal = 1 if ionum == 2460
replace universal = 1 if ionum == 2470
replace universal = 1 if ionum == 2480
replace universal = 1 if ionum == 2492
replace universal = 1 if ionum == 2495
replace universal = 1 if ionum == 2500
replace universal = 1 if ionum == 2510
replace universal = 1 if ionum == 2520
replace universal = 1 if ionum == 2530
replace universal = 1 if ionum == 2540
replace universal = 1 if ionum == 2570
replace universal = 1 if ionum == 2572
replace universal = 1 if ionum == 2590
replace universal = 1 if ionum == 2600
replace universal = 1 if ionum == 2620
replace universal = 1 if ionum == 2630
replace universal = 1 if ionum == 2640
replace universal = 1 if ionum == 2660
replace universal = 1 if ionum == 2670
replace universal = 1 if ionum == 2680
replace universal = 1 if ionum == 2690
replace universal = 1 if ionum == 2700
replace universal = 1 if ionum == 2702
replace universal = 1 if ionum == 2720
replace universal = 1 if ionum == 2730
replace universal = 1 if ionum == 2760
replace universal = 1 if ionum == 2780
replace universal = 1 if ionum == 2790
replace universal = 1 if ionum == 2800
replace universal = 1 if ionum == 2805
replace universal = 1 if ionum == 2810
replace universal = 1 if ionum == 2820
replace universal = 1 if ionum == 2830
replace universal = 1 if ionum == 2840
replace universal = 1 if ionum == 2860
replace universal = 1 if ionum == 2870
replace universal = 1 if ionum == 2880
replace universal = 1 if ionum == 2910
replace universal = 1 if ionum == 2930
replace universal = 1 if ionum == 2940
replace universal = 1 if ionum == 2950
replace universal = 1 if ionum == 2960
replace universal = 1 if ionum == 2970
replace universal = 1 if ionum == 2990
replace universal = 1 if ionum == 3030
replace universal = 1 if ionum == 3050
replace universal = 1 if ionum == 3070
replace universal = 1 if ionum == 3075
replace universal = 1 if ionum == 3090
replace universal = 1 if ionum == 3100
replace universal = 1 if ionum == 3110
replace universal = 1 if ionum == 3130
replace universal = 1 if ionum == 3140
replace universal = 1 if ionum == 3150
replace universal = 1 if ionum == 3160
replace universal = 1 if ionum == 3170
replace universal = 1 if ionum == 3175
replace universal = 1 if ionum == 3177
replace universal = 1 if ionum == 3180
replace universal = 1 if ionum == 3190
replace universal = 1 if ionum == 3200
replace universal = 1 if ionum == 3210
replace universal = 1 if ionum == 3220
replace universal = 1 if ionum == 3240
replace universal = 1 if ionum == 3245
replace universal = 1 if ionum == 3250
replace universal = 1 if ionum == 3260
replace universal = 1 if ionum == 3270
replace universal = 1 if ionum == 3350
replace universal = 1 if ionum == 3460
replace universal = 1 if ionum == 3530
replace universal = 1 if ionum == 3540
replace universal = 1 if ionum == 3550
replace universal = 1 if ionum == 3705
replace universal = 1 if ionum == 3720
replace universal = 1 if ionum == 3730
replace universal = 1 if ionum == 3770
replace universal = 1 if ionum == 3940
replace universal = 1 if ionum == 3950
replace universal = 1 if ionum == 3960
replace universal = 1 if ionum == 3965
replace universal = 1 if ionum == 4040
replace universal = 1 if ionum == 4085
replace universal = 1 if ionum == 4360
replace universal = 1 if ionum == 4400
replace universal = 1 if ionum == 4410
replace universal = 1 if ionum == 4420
replace universal = 1 if ionum == 4430
replace universal = 1 if ionum == 4470
replace universal = 1 if ionum == 4530
replace universal = 1 if ionum == 4550
replace universal = 1 if ionum == 4560
replace universal = 1 if ionum == 4570
replace universal = 1 if ionum == 4580


*crossreg
gen crossreg = .
replace crossreg = 1 if ionum == 10
replace crossreg = 1 if ionum == 25
replace crossreg = 1 if ionum == 70
replace crossreg = 1 if ionum == 220
replace crossreg = 1 if ionum == 230
replace crossreg = 1 if ionum == 270
replace crossreg = 1 if ionum == 275
replace crossreg = 1 if ionum == 360
replace crossreg = 1 if ionum == 530
replace crossreg = 1 if ionum == 540
replace crossreg = 1 if ionum == 620
replace crossreg = 1 if ionum == 630
replace crossreg = 1 if ionum == 680
replace crossreg = 1 if ionum == 740
replace crossreg = 1 if ionum == 770
replace crossreg = 1 if ionum == 820
replace crossreg = 1 if ionum == 870
replace crossreg = 1 if ionum == 873
replace crossreg = 1 if ionum == 1090
replace crossreg = 1 if ionum == 1100
replace crossreg = 1 if ionum == 1115
replace crossreg = 1 if ionum == 1120
replace crossreg = 1 if ionum == 1145
replace crossreg = 1 if ionum == 1180
replace crossreg = 1 if ionum == 1190
replace crossreg = 1 if ionum == 1200
replace crossreg = 1 if ionum == 1210
replace crossreg = 1 if ionum == 1220
replace crossreg = 1 if ionum == 1230
replace crossreg = 1 if ionum == 1240
replace crossreg = 1 if ionum == 1250
replace crossreg = 1 if ionum == 1270
replace crossreg = 1 if ionum == 1280
replace crossreg = 1 if ionum == 1300
replace crossreg = 1 if ionum == 1350
replace crossreg = 1 if ionum == 1360
replace crossreg = 1 if ionum == 1370
replace crossreg = 1 if ionum == 1455
replace crossreg = 1 if ionum == 1535
replace crossreg = 1 if ionum == 1540
replace crossreg = 1 if ionum == 1545
replace crossreg = 1 if ionum == 1550
replace crossreg = 1 if ionum == 1560
replace crossreg = 1 if ionum == 1850
replace crossreg = 1 if ionum == 1910
replace crossreg = 1 if ionum == 1940
replace crossreg = 1 if ionum == 2015
replace crossreg = 1 if ionum == 2020
replace crossreg = 1 if ionum == 2030
replace crossreg = 1 if ionum == 2033
replace crossreg = 1 if ionum == 2036
replace crossreg = 1 if ionum == 2040
replace crossreg = 1 if ionum == 2050
replace crossreg = 1 if ionum == 2055
replace crossreg = 1 if ionum == 2060
replace crossreg = 1 if ionum == 2100
replace crossreg = 1 if ionum == 2105
replace crossreg = 1 if ionum == 2270
replace crossreg = 1 if ionum == 2280
replace crossreg = 1 if ionum == 2285
replace crossreg = 1 if ionum == 2315
replace crossreg = 1 if ionum == 2380
replace crossreg = 1 if ionum == 2410
replace crossreg = 1 if ionum == 2580
replace crossreg = 1 if ionum == 2710
replace crossreg = 1 if ionum == 2740
replace crossreg = 1 if ionum == 2750
replace crossreg = 1 if ionum == 2850
replace crossreg = 1 if ionum == 2900
replace crossreg = 1 if ionum == 2920
replace crossreg = 1 if ionum == 3000
replace crossreg = 1 if ionum == 3040
replace crossreg = 1 if ionum == 3280
replace crossreg = 1 if ionum == 3320
replace crossreg = 1 if ionum == 3440
replace crossreg = 1 if ionum == 3490
replace crossreg = 1 if ionum == 3580
replace crossreg = 1 if ionum == 3690
replace crossreg = 1 if ionum == 3700
replace crossreg = 1 if ionum == 3710
replace crossreg = 1 if ionum == 3750
replace crossreg = 1 if ionum == 3780
replace crossreg = 1 if ionum == 3840
replace crossreg = 1 if ionum == 3850
replace crossreg = 1 if ionum == 3870
replace crossreg = 1 if ionum == 3920
replace crossreg = 1 if ionum == 4020
replace crossreg = 1 if ionum == 4060
replace crossreg = 1 if ionum == 4075
replace crossreg = 1 if ionum == 4090
replace crossreg = 1 if ionum == 4180
replace crossreg = 1 if ionum == 4210
replace crossreg = 1 if ionum == 4290
replace crossreg = 1 if ionum == 4300
replace crossreg = 1 if ionum == 4320
replace crossreg = 1 if ionum == 4375
replace crossreg = 1 if ionum == 4390

egen Asia_ts = sum(Asia), by(year)
egen Europe_ts = sum(Europe), by(year)
egen Africa_ts = sum(Africa), by(year)
egen universal_ts = sum(universal), by(year)
egen crossreg_ts = sum(crossreg), by(year)
egen MiddleEast_ts = sum(MiddleEast), by(year)
egen Americas_ts = sum(Americas), by(year)

label var Asia_ts "Asia"
label var Africa_ts "Africa"
label var Europe_ts "Europe"
label var Americas_ts "Americas"
label var MiddleEast_ts "Middle east"
label var crossreg_ts "Cross-regional"
label var universal_ts "Universal"

compress

**figure 3
twoway line Asia_ts Europe_ts Africa_ts Americas_ts MiddleEast_ts year, xtitle("") sort msymbol(i) ///
 xlab(1815(25)2015)
graph export JPR_figure3.eps, replace

