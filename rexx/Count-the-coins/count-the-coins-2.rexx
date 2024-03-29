/*REXX program counts the number of ways to make change with coins from an given amount.*/
numeric digits 20                                /*be able to handle large amounts of $.*/
parse arg N $                                    /*obtain optional arguments from the CL*/
if N='' | N=","    then N= 100                   /*Not specified?  Then Use $1  (≡100¢).*/
if $='' | $=","    then $= 1 5 10 25             /*Use penny/nickel/dime/quarter default*/
if left(N,1)=='$'  then N= 100 * substr(N, 2)    /*the amount was specified in  dollars.*/
NN= N;                     coins= words($)       /*the number of coins specified.       */
!.= .;        do j=1  for coins                  /*create a fast way of accessing specie*/
              _= word($, j);    ?= _ ' coin'     /*define an array element for the coin.*/
              if _=='½' | _=="1/2"   then _= .5  /*an alternate spelling of a half─cent.*/
              if _=='¼' | _=="1/4"   then _= .25 /* "     "         "     " " quarter─¢.*/
              $.j= _                             /*assign the value to a particular coin*/
              end   /*j*/
_= n // 100;                    cnt=' cents'     /* [↓]  is the amount in whole dollars?*/
if _=0  then do;   NN= '$'  ||  (NN%100);  cnt=  /*show the amount in dollars, not cents*/
             end
say 'with an amount of '      comma(NN)cnt",  there are "         comma( MKchg(N, coins) )
say 'ways to make change with coins of the following denominations: '    $
exit                                             /*stick a fork in it,  we're all done. */
/*──────────────────────────────────────────────────────────────────────────────────────*/
comma: procedure; parse arg _;     n= _'.9';      #= 123456789;      b= verify(n, #, "M")
       e= verify(n, #'0', , verify(n, #"0.", 'M'))  -  4
            do j=e  to b  by -3;   _= insert(',', _, j);    end  /*j*/;          return _
/*──────────────────────────────────────────────────────────────────────────────────────*/
MKchg: procedure expose $. !.;           parse arg a,k       /*function is recursive.   */
       if !.a.k\==.  then return !.a.k                       /*found this A & K before? */
       if a==0       then return 1                           /*unroll for a special case*/
       if k==1       then return 1                           /*   "    "  "    "      " */
       if k==2  then f= 1                                    /*handle this special case.*/
                else f= MKchg(a, k-1)                        /*count, recurse the amount*/
       if a==$.k  then do;  !.a.k= f+1;  return !.a.k;  end  /*handle this special case.*/
       if a <$.k  then do;  !.a.k= f  ;  return f    ;  end  /*   "     "     "      "  */
       !.a.k= f + MKchg(a-$.k, k);       return !.a.k        /*compute, define, return. */
