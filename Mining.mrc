alias xCalc { Var %x $Replace($Remove($1-,$Chr(44),a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,:),k,*1000,m,*1000000,b,*1000000000,t,*1000000000000) | return $Bytes($Calc(%x),bd) }
alias Mining { 
  Dialog $iif($Dialog(Mining),-v,-mdo Mining) Mining
  if ($Sock(Mining.Pr)) SockClose $v1
  if ($Sock(Mining.St)) SockClose $v1
  SockOpen Mining.St rscript.org 80
}
Dialog Mining {
  Title Mining
  Option DBU
  Size 694 76 101 50
  Menu "Select an Ore", 1
  Item "Silver", 2
  Item "Gold", 3
  Item "Iron", 4
  Item "Coal", 5
  Item "Mithril", 6
  Item "Adamantite", 7
  Item "Runite", 8
  Menu "Coal Bag", 9
  Item "Yes", 10
  Item "No", 11

  Edit "", 12, 42 18 41 10
  Text "", 13, 43 28 54 7, center
  Button "+28", 14, 84 18 15 10
  Box "", 15, 40 10 60 27
  Text "Exp:", 16, 1 1 14 8, right
  Text "Rank:", 17, 1 9 16 8, right
  Text "Ores:", 18, 1 17 15 8
  Text "", 19, 19 1 80 8
  Text "", 20, 19 9 20 8
  Text "", 21, 19 17 20 8
  Button "Update", 22, 2 26 25 11
  Text "", 23, 2 39 97 9
}
on *:Dialog:Mining:*:*:{
  if ($DEvent = Init) { 
    Did -b Mining 9,14,12
    Did -h Mining 18
    mdx SetColor Mining 12,13,15,19,20,21 text $rgb(0,0,255)
    mdx SetControlMDX Mining 23 ProgressBar smooth > $mdxfile(ctl_gen)
    mdx SetFont Mining 12,13,14,15,16,17,18,19,20,21 -11.5 400 Calibri
  }
  if ($DEvent = Menu) {
    Did -ra Mining 14 $iif($Did = 10,+54,+28)
    if ($Did = 5) Did -e Mining 9
    Elseif (($Did != 5) && ($Did isnum 2-8)) { 
      Did -b Mining 9 | Did -u Mining 10,11 
    }
    Did -u Mining $iif($Did isnum 2-8,$v2,10-11)
    Did -c Mining $Did
    if ($Did isnum 2-8) { 
      Did -r Mining 12,13
      hAdd -m Mining Ore $Did
      Dialog -t Mining Mining
      ;; Old: Dialog -t Mining Mining: $iif($+($Chr(40),*,$Chr(41)) iswm $Dialog(Mining).title,$Did($Did), $Did($Did) $Chr(40) $+ $Gettok($v2,-1,40))
      Did -ra Mining 15 $Readini(Mining.ini,Full,$hGet(Mining,Ore))
      if ($Sock(Mining.Pr)) SockClose $v1
      SockOpen Mining.Pr rscript.org 80
      if ($lvl($Remove($Gettok($Did(Mining,19),1,40),$Chr(44))) < 99) {     
        Did -ra Mining 21 $Bytes($Ceil($Calc($Calc($Gettok($Remove($Did(Mining,19),$Chr(40),$Chr(41),$Chr(44)),2,32) / $Readini(Mining.ini,XP,$hGet(Mining,Ore))))),bd)
        Did -v Mining 18
      }
    }
  }
  if ($DEvent = SClick) {
    if ($Did = 14) { 
      Did -ra Mining 12 $xCalc($Did(Mining,12) $Did(Mining,14))
      Did -ra Mining 13 $xCalc($xCalc($Did(Mining,12) $Did(Mining,14)) * $Gettok($Did(Mining,15),2,58)))
    }
    if ($Did = 22) {
      Did -r Mining 13,19,20,21
      Dialog -t Mining Mining
      ;; Old: Dialog -t Mining $Gettok($Dialog(Mining).title,1-2,32)
      Did -ra Mining 15 $Readini(Mining.ini,Full,$hGet(Mining,Ore))
      if ($Sock(Mining.St)) SockClose $v1
      if ($Sock(Mining.Pr)) SockClose $v1
      SockOpen Mining.St rscript.org 80
      if ($hGet(Mining,Ore)) SockOpen Mining.Pr rscript.org 80
    }
  }
  if ($DEvent = Close) {
    if ($hGet(Mining)) hFree Mining
    if ($Sock(Mining.Pr)) SockClose $v1
    if ($Sock(Mining.St)) SockClose $v1
  }
  if (($DEvent = Edit) && ($Did = 12)) {
    Did -ra Mining 13 $xCalc($Did(Mining,12) * $Gettok($Did(Mining,15),2,58))
    Did -ra Mining 12 $xCalc($Did(Mining,12))
  }
}
on *:SockOpen:Mining.St: {
  SockWrite -nt Mining.St GET $+(/lookup.php?type=stats&user=,$Readini(Mining.ini,RSN,RSN)) HTTP/1.1
  SockWrite -nt Mining.St Host: rscript.org
  SockWrite -nt Mining.St $crlf
}
on *:SockOpen:Mining.Pr: {
  SockWrite -nt Mining.Pr GET $+(/lookup.php?type=ge&search=,$Replace($Readini(Mining.ini,Full,$hGet(Mining,Ore)),$Chr(32),_),&exact=1) HTTP/1.1
  SockWrite -nt Mining.Pr Host: rscript.org
  SockWrite -nt Mining.Pr $crlf
}
;; STAT:Mining 184296 75 1256450
on *:SockRead:Mining.St: {
  if ($SockErr) { SockClose Mining.St | SockOpen Mining.St rscript.org 80 }
  Var %St | SockRead %St 
  if (Mining isin %St) {
    Tokenize 32 $Gettok(%St,2-,32)
    Dialog -t Mining Mining
    ;; Old: Dialog -t Mining $Dialog(Mining).title ( $+ $2 $+ )
    Did -ra Mining 23 $Calc($3 - $Xp($2)) 0 $Calc($Xp($Calc($2 + 1)) - $Xp($2))
    Did -ra Mining 20 $Bytes($1,bd)
    if (($hGet(Mining,Ore)) && ($2 < 99)) {
      Did -ra Mining 21 $Bytes($Ceil($Calc($Calc($Xp($Calc($2 + 1)) - $3) / $Readini(Mining.ini,XP,$hGet(Mining,Ore)))),bd)
      Did -v Mining 18
    }
    if (!$hGet(Mining,Ore)) Did -h Mining 18
    if ($2 <= 98) Did -ra Mining 19 $Bytes($3,bd) ( $+ $xcalc($xp($Calc($2 + 1)) - $3) ( $+ $Round($Calc((($3 - ($Xp($2))) / ($xp($Calc($2 + 1)) -  $Xp($2))) * 100),2) $+ % $+ ) $+ )
    elseif ($2 >= 99) Did -ra Mining 19 $Bytes($3,bd)
    SockClose Mining.St
  }
}
on *:SockRead:Mining.Pr: {
  if ($SockErr) { SockClose Mining.Pr | SockOpen Mining.Pr rscript.org 80 }
  Var %Pr | SockRead %Pr
  if (Item: isin %Pr && Multiitem !isin %Pr) {
    Did -ra Mining 15 $Gettok($Readini(Mining.ini,Full,$hGet(Mining,Ore)),1,32) $+ : $Bytes($GetTok(%Pr,5,32),bd) gp
    if ($Did(Mining,12) != $Null) Did -ra Mining 13 $xCalc($Did(Mining,15) * $Did(Mining,12))
    Did -e Mining 14,12
    SockClose Mining.Pr
  }
}
on *:Load:{
  Writeini -n Mining.ini Full 2 Silver Ore
  Writeini -n Mining.ini Full 3 Gold Ore
  Writeini -n Mining.ini Full 4 Iron Ore
  Writeini -n Mining.ini Full 5 Coal
  Writeini -n Mining.ini Full 6 Mithril Ore
  Writeini -n Mining.ini Full 7 Adamantite Ore
  Writeini -n Mining.ini Full 8 Runite Ore

  Writeini -n Mining.ini XP 2 35
  Writeini -n Mining.ini XP 3 65
  Writeini -n Mining.ini XP 4 40
  Writeini -n Mining.ini XP 5 50
  Writeini -n Mining.ini XP 6 80
  Writeini -n Mining.ini XP 7 95
  Writeini -n Mining.ini XP 8 125


  Writeini -n Mining.ini RSN RSN Wetai
}
on *:Unload: if (Mining.ini isfile) .Remove $v1
