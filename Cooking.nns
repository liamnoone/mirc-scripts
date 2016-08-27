alias Cook {
  if ($dialog(Cooking)) { dialog -x Cooking }
  dialog -md Cooking Cooking
  if ($sock(Fish.Raw)) { .sockclose Fish.Raw }
  if ($sock(Fish.Cooked)) { .sockclose Fish.Raw }
  if ($sock(Cooking)) { .sockclose Cooking }
  sockopen Fish.Raw itemdb-rs.runescape.com 80
  sockopen Fish.Cook itemdb-rs.runescape.com 80
  sockopen Cooking rscript.org 80
}
dialog Cooking {
  title "Cooking"
  size 694 76 101 50
  option dbu
  edit "", 6, 42 18 41 10
  text "", 4, 43 28 54 7, center
  button "+28", 3, 84 18 15 10
  box "Counter", 7, 40 10 60 27
  text "Exp:", 9, 3 1 14 8, right
  text "Rank:", 10, 1 9 16 8, right
  text "Monks:", 12, 2 17 15 8
  text "", 14, 19 1 80 8
  text "", 15, 19 9 20 8
  text "", 17, 19 17 20 8
  button "Update", 18, 2 26 25 11
  text "", 8, 2 39 97 9
}
on *:DIALOG:Cooking:init:0:{ 
  mdx SetMircVersion $version | mdx MarkDialog $dname | mdx MarkDialog $dname $dialog($dname).hwnd 
  mdx SetColor Cooking 4,6,14,15,17 text $rgb(0,0,255)
  mdx SetControlMDX $dname 8 ProgressBar smooth > $mdxfile(ctl_gen)
  mdx SetFont $dname 4,9,10,12,14,15,17,18 -11.5 400 Calibri
}
on *:DIALOG:Cooking:sclick:18:{
  dialog -t Cooking Cooking
  did -r Cooking 4,8,14,15,17
  did -ra Cooking 7 Cooking
  if ($sock(Fish.Raw)) { .sockclose Fish.Raw }
  if ($sock(Fish.Cooked)) { .sockclose Fish.Cook }
  if ($sock(Cooking)) { .sockclose Cooking }
  sockopen Fish.Raw itemdb-rs.runescape.com 80
  sockopen Fish.Cook itemdb-rs.runescape.com 80
  sockopen Cooking rscript.org 80
}
on *:DIALOG:Cooking:edit:6:{
  var %price $gettok($did(Cooking,7),2,32)
  tokenize 32 $did(Cooking,6) 
  did -ra Cooking 4 $xcalc($1 * %price)
}
on *:DIALOG:Cooking:sclick:3:{
  var %price $gettok($did(Cooking,7),2,32)
  tokenize 32 $did(Cooking,6) 
  did -ra Cooking 6 $calc($1 + 28)
  did -ra Cooking 4 $xcalc($did(Cooking,6) * %price)
}
on *:SOCKOPEN:Cooking:{
  sockwrite -nt $sockname GET $+(/lookup.php?type=stats&user=,Wetai) HTTP/1.1
  sockwrite -nt $sockname Host: rscript.org
  sockwrite -nt $sockname $crlf
}

on *:SOCKREAD:Cooking:{
  if ($sockerr) { .sockclose Cooking | sockopen Cooking rscript.org 80 }
  else {
    var %xx
    sockread %xx
    if (Cooking isin %xx) {
      tokenize 32 $gettok(%xx,2-,32) 
      dialog -t Cooking Cooking( $+ $2 $+ )
      did -ra Cooking 14 $bytes($3,bd) ( $+ $xcalc($xp($Calc($GetLVL($3) + 1)) - $3) ( $+ $round($calc($3 / $xp($Calc($GetLVL($3) + 1)) *100),1) $+ % $+ ))
      did -ra Cooking 15 $bytes($1,bd)
      did -ra Cooking 17 $bytes($ceil($calc(($xp($Calc($GetLVL($3) + 1)) - $3)/150)),bd)
      did -ra Cooking 8 $3 0 $xp($Calc($GetLVL($3) + 1)) 
      sockclose Cooking
    }
  }
}
on *:SOCKOPEN:Fish.Raw:{
  sockwrite -nt $sockname GET /results.ws?query=raw+monkfish&price=all&members=yes HTTP/1.1
  sockwrite -nt $sockname Host: itemdb-rs.runescape.com
  sockwrite -nt $sockname $crlf
}
on *:SOCKREAD:Fish.Raw:{
  if ($sockerr) { sockclose Fish.Raw | sockopen Fish.Raw itemdb-rs.runescape.com 80 }
  else {
    var %Raw
    sockread %Raw
    if (<td><a href="http://itemdb-rs.runescape.com/Raw_monkfish/viewitem.ws?obj=7944"> Raw monkfish</a></td> == %Raw) {
      sockread %Raw | Set %Raw.Price $Htmlfree(%Raw) 
      sockclose $sockname
    }
  }
}

on *:SOCKOPEN:Fish.Cook:{
  sockwrite -nt $sockname GET /results.ws?query=Monkfish&price=all&members=yes HTTP/1.1
  sockwrite -nt $sockname Host: itemdb-rs.runescape.com
  sockwrite -nt $sockname $crlf
}
on *:SOCKREAD:Fish.Cook:{
  if ($sockerr) { sockclose Fish.Cook | sockopen Fish.Cook itemdb-rs.runescape.com 80 }
  else {
    var %Cooked
    sockread %Cooked 
    if (<td><a href="http://itemdb-rs.runescape.com/Monkfish/viewitem.ws?obj=7946"> Monkfish</a></td> == %Cooked) {
      sockread %Cooked | Set %Cooked.Price $HtmlFree(%Cooked) | Set %Cooked.Diff $xCalc(%Raw.Price - %Cooked.Price)
      did -ra Cooking 7 $iif($Left(%Cooked.Diff,1) = -,Loss:,Gain:) $Remove(%Cooked.Diff,-)
      if ($len($did(Cooking,6))) { did -ra Cooking 4 $xcalc($did(Cooking,6) * %Cooked.Diff) }
      sockclose $sockname
    }
  }
}
