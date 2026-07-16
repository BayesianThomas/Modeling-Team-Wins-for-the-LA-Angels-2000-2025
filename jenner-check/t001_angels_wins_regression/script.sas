/* Adapted from program.sas (BayesianThomas/Modeling-Team-Wins-for-the-LA-Angels-2000-2025).
   Original reads WORK.ANGELSBATTING_2000_2025 (imported from AngelsBatting_2000-2025.xlsx)
   and writes figures to a hardcoded Windows ODS path (C:\Users\there\OneDrive\...).
   Here the same 25 seasons of Angels batting data (2000-2025, excluding the 2020
   COVID-shortened season) are loaded inline via DATALINES instead of PROC IMPORT,
   and the ODS PDF/graphics-file redirection is dropped since it targets a local
   desktop path outside the bundle. Every PROC step, variable list, and model
   specification below is copied verbatim from the author's script. To fit the
   hosted API's anonymous-tier time budget, this bundle keeps the correlation
   matrix, the derived 4-variable dataset, one histogram, one scatter+reg plot,
   and the three regression models the author's own README calls out (the
   winning 2-variable Hits+BatAvg model plus its two nearest competitors) rather
   than replaying all 12 PROC REG calls and 6 PROC SGPLOT calls from program.sas. */

data work.ANGELSBATTING_2000_2025;
  length Lg $10;
  input Year Lg $ W L Finish 'R/G'n G PA AB R H '2B'n '3B'n HR RBI SB CS BB SO
        BA OBP SLG OPS E DP 'Fld%'n BatAge;
  datalines;
2025 AL_West 72 90 5 4.15 162 5996 5374 673 1209 212 17 226 649 88 27 484 1627 0.225 0.298 0.397 0.695 97 159 0.983 28
2024 AL_West 63 99 5 3.92 162 5975 5357 635 1227 227 15 165 596 133 50 482 1416 0.229 0.301 0.369 0.671 97 152 0.983 27.3
2023 AL_West 73 89 4 4.56 162 6145 5489 739 1346 248 26 231 708 72 31 518 1524 0.245 0.317 0.426 0.743 95 124 0.983 28.6
2022 AL_West 73 89 3 3.85 162 5977 5423 623 1265 219 31 190 600 77 27 449 1539 0.233 0.297 0.39 0.687 84 134 0.985 28
2021 AL_West 77 85 4 4.46 162 6019 5437 723 1331 265 23 190 691 79 26 464 1394 0.245 0.31 0.407 0.717 88 131 0.985 29.1
2019 AL_West 72 90 4 4.75 162 6251 5542 769 1368 268 21 220 734 65 20 586 1276 0.247 0.324 0.422 0.746 92 118 0.984 28.8
2018 AL_West 80 82 4 4.45 162 6108 5472 721 1323 249 23 214 690 89 22 514 1300 0.242 0.313 0.413 0.726 76 173 0.987 29.5
2017 AL_West 80 82 2 4.38 162 6073 5415 710 1314 251 14 186 678 136 44 523 1198 0.243 0.315 0.397 0.712 80 135 0.986 29.9
2016 AL_West 74 88 4 4.43 162 6041 5431 717 1410 279 20 156 686 73 34 471 991 0.26 0.322 0.405 0.726 97 148 0.983 28.5
2015 AL_West 85 77 3 4.08 162 5990 5417 661 1331 243 21 176 621 52 34 435 1150 0.246 0.307 0.396 0.702 93 108 0.984 28.7
2014 AL_West 98 64 1 4.77 162 6285 5652 773 1464 304 31 155 729 81 39 492 1266 0.259 0.322 0.406 0.728 83 127 0.986 29.3
2013 AL_West 78 84 3 4.52 162 6260 5588 733 1476 270 39 164 696 82 34 523 1221 0.264 0.329 0.414 0.743 112 135 0.981 27.8
2012 AL_West 89 73 3 4.73 162 6121 5536 767 1518 273 22 187 732 134 33 449 1113 0.274 0.332 0.433 0.764 98 141 0.984 28.7
2011 AL_West 86 76 2 4.12 162 6088 5513 667 1394 289 34 155 629 135 52 442 1086 0.253 0.313 0.402 0.714 93 157 0.985 28.9
2010 AL_West 80 82 3 4.2 162 6089 5488 681 1363 276 19 155 656 104 52 466 1070 0.248 0.311 0.39 0.702 113 116 0.981 29.7
2009 AL_West 97 65 1 5.45 162 6305 5622 883 1604 293 33 173 841 148 63 547 1054 0.285 0.35 0.441 0.792 85 174 0.986 29.6
2008 AL_West 100 62 1 4.72 162 6155 5540 765 1486 274 25 159 721 129 48 481 987 0.268 0.33 0.413 0.743 91 159 0.985 29
2007 AL_West 94 68 1 5.07 162 6198 5554 822 1578 324 23 123 776 139 55 507 883 0.284 0.345 0.417 0.762 101 154 0.983 28.6
2006 AL_West 89 73 2 4.73 162 6221 5609 766 1539 309 29 159 737 148 57 486 914 0.274 0.334 0.425 0.759 124 154 0.979 28.8
2005 AL_West 95 67 1 4.7 162 6186 5624 761 1520 278 30 147 726 161 57 447 848 0.27 0.325 0.409 0.734 87 139 0.986 29.8
2004 AL_West 92 70 1 5.16 162 6296 5675 836 1603 272 37 162 783 143 46 450 942 0.282 0.341 0.429 0.77 90 126 0.985 28.9
2003 AL_West 77 85 3 4.54 162 6119 5487 736 1473 276 33 150 687 129 61 476 838 0.268 0.33 0.413 0.743 105 138 0.982 29.1
2002 AL_West 99 63 2 5.25 162 6327 5678 851 1603 333 32 152 811 117 51 462 805 0.282 0.341 0.433 0.773 87 151 0.986 28.3
2001 AL_West 75 87 3 4.27 162 6226 5551 691 1447 275 26 158 662 116 52 494 1001 0.261 0.327 0.405 0.732 103 142 0.983 27.9
2000 AL_West 82 80 3 5.33 162 6373 5628 864 1574 309 34 236 837 93 52 608 1024 0.28 0.352 0.472 0.825 134 182 0.978 27.6
;
run;

proc corr data=WORK.ANGELSBATTING_2000_2025 noprob;
  var W 'R/G'n PA AB R H '2B'n '3B'n HR RBI SB CS BB SO BA OBP SLG OPS E DP
  'Fld%'n BatAge;
  title "Correlation Matrix";
run;

data work.angels4vars;
    set work.ANGELSBATTING_2000_2025;
    Wins = W;
    Hits = H;
    BatAvg = BA;
    Doubles = '2B'n;
    Runs = R;
run;

proc means data=angels4vars min q1 mean median q3 max;
  var hits batavg doubles runs wins;
  title "Five-Number Summary for Selected Predictors";
run;

proc sgplot data=work.angels4vars;
    histogram Hits;
    title "Distribution of Hits";
run;

proc sgplot data=work.angels4vars;
    scatter x=Hits y=Wins;
    reg x=Hits y=Wins;
    title "Wins vs Hits";
run;

proc reg data=work.angels4vars;
   model Wins = Hits BatAvg;
   title "Wins = Hits + Batting Average";
run;

proc reg data=work.angels4vars;
   model Wins = Hits Runs;
   title "Wins = Hits + Runs";
run;

proc reg data=work.angels4vars;
   model Wins = BatAvg Runs;
   title "Wins = BatAvg + Runs";
run;
