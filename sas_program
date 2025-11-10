ods listing gpath="C:\Users\there\OneDrive\Desktop\SaS_Figs";
ods graphics on / imagename="fig" imagefmt=pdf reset=index;

ods pdf file="C:\Users\there\OneDrive\Desktop\SaS_Figs\Correlation_matrix.pdf";
 proc corr data=WORK.ANGELSBATTING_2000_2025 noprob;
   var W 'R/G'n PA AB R H '2B'n '3B'n HR RBI SB CS BB SO BA OBP SLG OPS E DP 
   'Fld%'n BatAge;
	title "Correlation Matrix";
run;
ods pdf close;

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
    histogram BatAvg;
    title "Distribution of Batting Average";
run;

proc sgplot data=work.angels4vars;
    histogram Doubles;
    title "Distribution of Doubles";
run;

proc sgplot data=work.angels4vars;
    histogram Runs;
    title "Distribution of Runs";
run;

proc sgplot data=work.angels4vars;
    scatter x=Hits y=Wins;
    reg x=Hits y=Wins;
    title "Wins vs Hits";
run;

proc sgplot data=work.angels4vars;
    scatter x=BatAvg y=Wins;
    reg x=BatAvg y=Wins;
    title "Wins vs Batting Average";
run;

proc sgplot data=work.angels4vars;
    scatter x=Doubles y=Wins;
    reg x=Doubles y=Wins;
    title "Wins vs Doubles";
run;

proc sgplot data=work.angels4vars;
    scatter x=Runs y=Wins;
    reg x=Runs y=Wins;
    title "Wins vs Runs";
run;

proc reg data=work.angels4vars;
   model Wins = Hits BatAvg;
   title "Wins = Hits + Batting Average";
run;

proc reg data=work.angels4vars;
   model Wins = Hits Doubles;
   title "Wins = Hits + Doubles";
run;

proc reg data=work.angels4vars;
   model Wins = Hits Runs;
   title "Wins = Hits + Runs";
run;

proc reg data=work.angels4vars;
   model Wins = BatAvg Doubles;
   title "Wins = BatAvg + Doubles";
run;

proc reg data=work.angels4vars;
   model Wins = BatAvg Runs;
   title "Wins = BatAvg + Runs";
run;

proc reg data=work.angels4vars;
   model Wins = Doubles Runs;
   title "Wins = Doubles + Runs";
run;

proc reg data=work.angels4vars;
   model Wins = Hits BatAvg Doubles;
   title "Wins = Hits + BatAvg + Doubles";
run;

proc reg data=work.angels4vars;
   model Wins = Hits BatAvg Runs;
   title "Wins = Hits + BatAvg + Runs";
run;

data work.angels4vars_expanded;
    set work.angels4vars;
    HitsBA = Hits * BatAvg;     
    Hits2   = Hits**2;           
    BA2     = BatAvg**2;        
run;

proc reg data=work.angels4vars_expanded;
   model Wins = Hits BatAvg HitsBA;
   title "Wins = Hits + BatAvg + Hits*BatAvg";
run;

proc reg data=work.angels4vars_expanded;
   model Wins = Hits BatAvg Hits2;
   title "Wins = Hits + BatAvg + Hits^2";
run;
