/*REXX program displays  various alignments  for words in an array of  text strings.    */
size= 0;        t.=;   cols= 0;   wid.= 0;   @.= /*zero or nullify some variables.      */
                t.1 = "Given$a$text$file$of$many$lines,$where$fields$within$a$line$"
                t.2 = "are$delineated$by$a$single$'dollar'$character,$write$a$program"
                t.3 = "that$aligns$each$column$of$fields$by$ensuring$that$words$in$each$"
                t.4 = "column$are$separated$by$at$least$one$space."
                t.5 = "Further,$allow$for$each$word$in$a$column$to$be$either$left$"
                t.6 = "justified,$right$justified,$or$center$justified$within$its$column."
  do r=1  while t.r\==''                         /* [↓]  process all the text lines.    */
  _= strip(t.r,,'$')                             /*strip leading & trailing dollar signs*/
                      do c=1  until _==''        /* [↓]  process each of the words.     */
                      parse var _   @.r.c '$' _  /*extract the words from a line of text*/
                      wid.c= max(wid.c, length(@.r.c) )   /*find the maximum word width.*/
                      end   /*c*/
  cols= max(cols, c)                             /*use the maximum COLS found.          */
  end    /*r*/

  do k=1  for cols;   size= size + wid.k;   end  /*find the width of the biggest line.  */
rows= r - 1                                      /*adjust ROWS because of the  DO  loop.*/
  do j=1  for 3;      say;      say              /*show two blank lines for a separator.*/
  say center(word('left right center', j)  "aligned", size+cols+1, "═")     /*show title*/

                 do r=0  to rows;       _=;    != '│';              if r==0  then != '┬'
                       do c=1  for cols;                            x= @.r.c
                       if r==0  then x= copies("─", wid.c + 1)
                       if j==1  then _= _  ||  !  ||    left(x, wid.c)   /*justify  left*/
                       if j==2  then _= _  ||  !  ||   right(x, wid.c)   /*   "    ruggt*/
                       if j==3  then _= _  ||  !  ||  center(x, wid.c)   /*   "     ctr.*/
                       end   /*c*/
                 if r==0  then do;    _= '┌'substr(_, 2, length(_) - 1)"┐"   /*top line.*/
                                    bot= '└'substr(_, 2, length(_) - 2)"┘"   /*bot   "  */
                               end
                          else _= _ || !         /*append trailing end boxing character.*/
                 say _
                 end         /*r*/               /* [↑]  shows words in boxes.          */
  say translate(bot, '┴', "┬")                   /*display the bottom line of the box.  */
  end   /*j*/                                    /*stick a fork in it,  we're all done. */
