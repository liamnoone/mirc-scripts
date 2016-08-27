; ––––––––––––––––––––––––––––––––––––––––
; Dialogs File
; ––––––––––––––––––––––––––––––––––––––––
alias xcalc { var %x $replace($remove($1-,$chr(44),a,c,d,e,f,g,h,i,j,l,n,o,p,q,r,s,u,v,w,x,y,z,:),k,*1000,m,*1000000,b,*1000000000,t,*1000000000000) | return $bytes($calc(%x),bd) }
alias htmlfree {
  var %x, %i = $regsub($replace($1-,<td>,$chr(32),<tr>,$chr(20),<br>,$chr(20)),/(^[^<]*>|<[^>]*>|<[^>]*$)/g,$null,%x), %x = $remove(%x,&nbsp;)
  return %x
}
; ––––––––––––––––––––––––––––––––––––––––
; Dialogs File
; ––––––––––––––––––––––––––––––––––––––––
Dialog Charms {
  Title "Charm Drop Rates"
  Option DBU
  Size -1 -1 100 50
  Edit "Total Charms.", 1, 1 5 97 10, Center Read AutoHS
  Button "Gold.", 2, 1 17 47 10, Read Flat Center
  Button "Green.", 3, 52 17 45 10, Read Flat Center
  Button "Crimson.", 4, 1 27 47 10, Read Flat Center
  Button "Blue.", 5, 52 27 45 10, Read Flat Center
  Button "No Charm.", 6, 1 37 47 10, Read Flat Center
  Button "Close.", 7, 52 37 45 10, Read Flat Center, Ok
}
on *:Dialog:Charms:*:*: { 
  if ($Devent == Init) { 
    Set %Charm.STime $Replace($Time,:,¤) | Set %Charm.SCtime $Ctime
  } 
  if (($DEvent == SClick) && ($Did isnum 2-6)) {
    if ($Did == 2) { Inc %Charm.Gold | Inc %Charm.Total }
    if ($Did == 3) { Inc %Charm.Green | Inc %Charm.Total }
    if ($Did == 4) { Inc %Charm.Crimson | Inc %Charm.Total }
    if ($Did == 5) { Inc %Charm.Blue | Inc %Charm.Total }
    if ($Did == 6) { Inc %Charm.None | Inc %Charm.Total }
    Var %Charm.Ttotal $Calc(%Charm.Total - %Charm.None)
    Did -ra Charms 1 Total Charms: %Charm.Ttotal $+($Chr(40),%Charm.Ttotal,/,%Charm.Total $Chr(40),$PerCent(%Charm.Ttotal,%Charm.Total,1).Suf,$Chr(41),$Chr(41))
    Did -ra Charms 2 Gold: $iif(%Charm.Gold,$v1,0) $+($Chr(40),$Floor($Calc((%Charm.Gold / %Charm.Total) * 100)),%,$chr(41))
    Did -ra Charms 3 Green: $iif(%Charm.Green,$v1,0) $+($Chr(40),$Floor($Calc((%Charm.Green / %Charm.Total) * 100)),%,$chr(41))
    Did -ra Charms 4 Crimson: $iif(%Charm.Crimson,$v1,0) $+($Chr(40),$Floor($Calc((%Charm.Crimson / %Charm.Total) * 100)),%,$chr(41))
    Did -ra Charms 5 Blue: $iif(%Charm.Blue,$v1,0) $+($Chr(40),$Floor($Calc((%Charm.Blue / %Charm.Total) * 100)),%,$chr(41))
    Did -ra Charms 6 None: $iif(%Charm.None,$v1,0) $+($Chr(40),$Floor($Calc((%Charm.None / %Charm.Total) * 100)),%,$Chr(41))
  }
  if ($DEvent == Close) { 
    if (%Charm.Total) {
      Var %Charm.SLogging $Replace( $Duration($Calc($Ctime - %Charm.SCtime),3) ,:,¤) 
      Var %Charm.GCount Gold Charms: %Charm.Gold $+($Chr(40),%Charm.Gold,/,$calc(%Charm.Total - %Charm.None) $&
        $Chr(40),$Percent(%Charm.Gold,$Calc(%Charm.Total - %Charm.None),1).Suf,$Chr(41),$chr(41))
      Var %Charm.GrCount Green Charms: %Charm.Green $+($Chr(40),%Charm.Green,/,$calc(%Charm.Total - %Charm.None) $&
        $Chr(40),$Percent(%Charm.Green,$Calc(%Charm.Total - %Charm.None),1).Suf,$Chr(41),$chr(41))
      Var %Charm.CrCount Crimson Charms: %Charm.Crimson $+($Chr(40),%Charm.Crimson,/,$calc(%Charm.Total - %Charm.None) $&
        $Chr(40),$Percent(%Charm.Crimson,$Calc(%Charm.Total - %Charm.None),1).Suf,$Chr(41),$chr(41))
      Var %Charm.BCount Blue Charms: %Charm.Blue $+($Chr(40),%Charm.Blue,/,$calc(%Charm.Total - %Charm.None) $&
        $Chr(40),$Percent(%Charm.Blue,$Calc(%Charm.Total - %Charm.None),1).Suf,$Chr(41),$chr(41))
      Var %Charm.NCount None: %Charm.None $+($Chr(40),%Charm.None,/,%Charm.Total $Chr(40),$Percent(%Charm.None,%Charm.Total,1).Suf,$Chr(41),$chr(41))
      Var %Charm.Average $Round($Calc(((%Charm.Total - %Charm.None)/($Ctime - %Charm.SCtime)) * 3600)),1)
      Echo -a $ac(Charm Rate(s): $Did(Charms,1) ¤ Average Charms/h: %Charm.Average ¤ %Charm.GCount ¤ %Charm.GrCount ¤ $&
        %Charm.CrCount ¤ %Charm.BCount ¤ %Charm.NCount ¤ Logging Started at %Charm.STime ¤ Finished at $Replace($Time,:,¤) (Duration: %Charm.SLogging $+ ))
      Write CharmLogging.txt $+([,$Calc($iif($Lines(CharmLogging.txt),$v1,0) + 1) [,$Date [,%Charm.STime,-,$Replace($Time,:,¤),]]]) Charm Rate(s): $Did(Charms,1) ¤ $&
        Average Charms/h: %Charm.Average ¤ %Charm.GCount ¤ %Gr.Count ¤ %Charm.CrCount ¤ %Charm.BCount ¤ %charm.NCount ¤ Logging Started at $&
        %Charm.STime ¤ Finished at $Replace($Time,:,¤) (Logging Duration: %Charm.SLogging $+ )
      if ($Input($+(Summoning Level to calculate experience?.,$crlf,Must be a level 1-99.),ego,Summoning Level?) isnum 1-99) {
        Tokenize 32 %Charm.Gold %Charm.Green %Charm.Crimson %Charm.Blue
        Charms $v1 $1 $2 $3 $4
      }
      Unset %Charm.* 
    }
  }
}
alias CharmRates { Run CharmLogging.txt }
alias charm { $iif($Dialog(Charms), Dialog -x Charms) | dialog -md Charms Charms }
alias -l percent { 
  Return $round($iif($1 > $2,$calc(100 - $calc($iif($1 > $2,$2 / $1 * 100,$1 / $2 * 100))),$calc($iif($1 > $2,$2 / $1 * 100,$1 / $2 * 100))),$iif($3,$v1,15)) $&
    $+ $iif($prop = suf,$chr(37)) 
}

alias Charms {
  Var %Gold = $Charm.Gold($1), %Green = $Charm.Green($1), %Crimson $Charm.Crimson($1), %Blue = $Charm.Blue($1)
  Var %Gold2 = $Calc(%Gold * $2), %Green2 = $Calc(%Green * $3), %Crim2 = $Calc(%Crimson * $4), %Blue2 = $Calc(%Blue * $5)
  Var %Total = $calc(%Crim2 + %Gold2 + %Blue2 + %Green2)
  Echo -a $ac([Charms] ¤ $+(Gold: $2 [,%Gold Exp Each] ¤ Green: $3 [,%Green Exp Each] $&
    ¤ Crimson: $4 $Chr(91),%Crimson Exp Each] ¤ Blue: $5 [,%Blue Exp Each]))
  Echo -a $ac(Total Experience at Level $+($1,: %Total Exp))
}
alias bet { return $iif($1 >= $2 && $1 < $3,true) }
alias Charm.Gold { 
  var %x = $1
  if (%x == 0) { return 0 } | elseif ($bet(%x,1,4)) { return 4.8 }
  elseif ($bet(%x,4,10)) { return 9.3 } | elseif ($bet(%x,10,13)) { return 12.6 }
  elseif ($bet(%x,13,16)) { return 12.6 } | elseif ($bet(%x,16,17)) { return 21.6 }
  Elseif ($bet(%x,17,40)) { return 46.5 }
  elseif ($bet(%x,40,52)) { return 52.8 } | elseif ($bet(%x,52,66)) { return 68.4 }
  elseif (%x == 66) { return 87 } | elseif ($bet(%x,67,71)) { return 58.6 }
  elseif (%x >= 71) { return 93.2 }
}
alias Charm.Green { 
  var %x = $1
  if ($bet(%x,0,18)) { return 0 } | elseif ($bet(%x,18,28)) { return 31.2 }
  elseif ($bet(%x,28,33)) { return 49.8 } | elseif ($bet(%x,33,34)) { return 57.6 }
  elseif ($bet(%x,34,41)) { return 59.6 }
  elseif ($bet(%x,41,43)) { return 72.4 } | elseif ($bet(%x,43,47)) { return 75.2 }
  elseif ($bet(%x,47,54)) { return 83.2 } | elseif ($bet(%x,54,56)) { return 94.8 }
  elseif ($bet(%x,56,62)) { return 98.8 } | elseif ($bet(%x,62,68)) { return 109.6 }
  elseif (%x == 68) { return 119.2 } | elseif ($bet(%x,69,78)) { return 121.2 }
  elseif ($bet(%x,78,80)) { return 136.8 } | elseif ($bet(%x,80,88)) { return 140.8 }
  elseif ($bet(%x,88,93)) { return 154.4 } | Elseif (%x >= 93) { Return 163.2 }
}
alias Charm.Crimson {
  var %x = $1
  if ($bet(%x,0,19)) { return 0 } | Elseif ($Bet(%x,19,22)) { Return 83.2 } 
  elseif ($bet(%x,22,31)) { return 96.8 }
  elseif (%x == 31) { return  136 } | elseif ($bet(%x,32,42)) { return 140.8 }
  elseif ($Bet(%x,42,46)) { Return 184.8 }
  elseif ($bet(%x,46,49)) { return 202.4 } | elseif ($bet(%x,49,61)) { return 215.2 }
  elseif ($bet(%x,61,63)) { return 268 } | elseif (%x == 63) { return 276.8 }
  elseif ($bet(%x,64,70)) { return 281.6 } | Elseif (%x == 70) { Return 132 }
  elseif ($bet(%x,70,72)) { return 132.0 } | elseif ($Bet(%x,72,74)) { return 301.8 }
  elseif (%x == 74) { return 325.6 } | elseif ($bet(%x,75,83)) { return 329.6 } 
  elseif ($bet(%x,83,85)) { return 364.8 } | elseif ($bet(%x,85,92)) { return 373.6 }
  elseif ($bet(%x,92,95)) { return 404.8 } | elseif ($Bet(%x,95,96)) { return 422.4 }
  elseif (%x = 99) { return 435.2 }
}
alias Charm.Blue { 
  var %x = $1
  if ($bet(%x,0,23)) { return 0 } | elseif ($bet(%x,23,25)) { return 202.4 }
  elseif ($bet(%x,25,29)) { return 220 } | elseif ($bet(%x,29,34)) { return 255.2 }
  elseif ($bet(%x,34,36)) { return 59.6 } | elseif ($bet(%x,36,46)) { return 316.8 }
  elseif ($bet(%x,46,55)) { return 404.8 } | elseif (%x == 55) { return 484 }
  elseif ($bet(%x,56,57)) { return 492.8 } | elseif ($bet(%x,57,58)) { return 501.6 }
  elseif ($bet(%x,58,66)) { return 510.4 } | elseif ($bet(%x,66,76)) { return 580.8 } 
  elseif ($bet(%x,76,79)) { return 666.8 } | elseif ($bet(%x,79,83)) { return 695.2 }
  elseif ($bet(%x,83,86)) { return 730.4 } | elseif ($bet(%x,86,89)) { return 756.8 }
  elseif (%x >= 89) { return 783.2 }
}

; ––––––––––––––––––––––––––––––––––––––––

alias Smith {
  if ($dialog(Smith)) { dialog -x Smith }
  dialog -md Smith Smith
  if ( $Regex($1,[Ee](xp(erience)?)?) ) { Did -fu Smith 10 }
  if ( $Regex($1,[Nn](ext)?) ) { Did -fu Smith 12 }
  if ( $Regex($1,[Ss](etting(s)?)?) ) { Did -fu Smith 16 }
  if ($Sock(Smith)) { .SockClose Smith }
  if ($Sock(Tracker.*)) { .SockClose Tracker.* }
  sockopen Smith rscript.org 80
}
dialog Smith {
  title "Smithing"
  size -1 -1 210 138
  option dbu
  text "Level", 2, 7 4 52 8
  text "Experience", 3, 65 4 55 8
  text "Information", 4, 125 4 83 8
  text "Rank", 6, 7 15 53 8
  check "Morphic Hammers.", 7, 65 14 59 10
  text "", 11, 124 15 82 8
  text "Track (1 Day):", 1, 6 27 54 15
  text "Track (1 Week):", 5, 64 27 55 15
  text "Track (1 Year):", 9, 124 27 82 15
  tab "Experience", 10, 1 53 206 83
  list 8, 3 69 202 64, tab 10 size
  tab "Next Level", 12
  list 13, 3 69 202 64, tab 12 size
  tab "Settings", 16
  box "Use SC Hammers By Default", 17, 94 67 84 32, tab 16
  box "Set Default RSN", 18, 4 67 84 32, tab 16
  button "Set.", 19, 54 85 31 12, tab 16
  check "SC Hammers by Default", 20, 99 79 74 10, tab 16
  edit , 21, 9 75 44 10, tab 16,  Center
  button "Close.", 14, 40 45 38 10, ok
  button "Refresh.", 15, 1 45 38 10
}

on *:Dialog:Smith:Close:*: {
  Sockclose Tracker.* | Sockclose Smith
}
on *:DIALOG:Smith:init:0:{ 
  mdx SetControlMDX Smith 8,13 ListView report showsel rowselect > $mdxfile(views)
  Did -i Smith 8 1 headerdims 60:1 90:2 90:3 79:4 60:5
  Did -i Smith 8 1 headertext +c Item $chr(9) $+ +c Level Required $chr(9) $+ +c Smelting EXP $chr(9) $+ +c Smithing EXP $chr(9) $+ +c Total
  Did -i Smith 13 1 headerdims 60:1 75:2 85:3 80:4 80:5
  Did -i Smith 13 1 headertext +c Item $chr(9) $+ +c Smelt Only $chr(9) $+ +c Smith Only $chr(9) $+ +c Both $chr(9) $+ +c Bars/Hammer
  if ($Readini(Smith.ini, Rsn, Hammers) == Yes) { 
    Did -c Smith 7,20
  }
  Did -a Smith 21 $iif($Readini(Smith.ini, Rsn, Rsn), $v1, $Me)
}
on *:SOCKOPEN:Smith:{
  sockwrite -nt $sockname GET $+(/lookup.php?type=stats&user=,$Readini(Smith.ini, Rsn, Rsn)) HTTP/1.1
  sockwrite -nt $sockname Host: rscript.org
  sockwrite -nt $sockname $crlf
}

on *:SOCKREAD:Smith:{
  if ($sockerr) { .sockclose Smith | sockopen Smith rscript.org 80 }
  else {
    var %Smith
    sockread %Smith
    if (Smithing isin %Smith) {
      tokenize 32 $gettok(%Smith,2-,32) 
      Did -ra Smith 2 Level: $2
      Did -ra Smith 3 Experience: $Bytes($xp($Calc($2 + 1)),bd)
      Did -ra Smith 4 Next Level: $xcalc($xp($Calc($2 + 1)) - $3) ( $+ $round($calc($3 / $xp($Calc($2 + 1)) *100),1) $+ % $+ )
      Did -ra Smith 6 Rank: $bytes($1,bd)
      if ($Did(Smith,7).State) { Did -ra Smith 11 Morphic Hammers to level: $Ceil($xCalc($GetTok($Did(Smith,4), 3, 32) / 64000)) }
      sockclose Smith
      .inc %ID
      .sockopen $+(tracker.,%ID) rscript.org 80
      .sockmark $+(tracker.,%ID) $iif($readini(Smith.ini,Rsn,Rsn),$v1,$me)
      SmithCon
    }
  }
}
on *:Dialog:Smith:Sclick:*: { 
  if ($Did = 8) { SortMDX Smith 8 }
  if ($Did = 13) { SortMDX Smith 13 }
  if ($Did = 7) {
    if ($Did(Smith,7).state) {
      Did -ra Smith 11 Morphic Hammers to level: $Ceil($xCalc($GetTok($Did(Smith,4), 3, 32) / 64000))
    }
    Else {
      Did -r Smith 11
    }
  }
  Elseif ($Did = 15) {
    if ($Sock(Smith)) { Sockclose Smith }
    Did -r Smith 1,2,3,4,5,6,8,9,11,13
    sockopen Smith rscript.org 80
    .inc %ID
    .sockopen $+(tracker.,%ID) rscript.org 80
    .sockmark $+(tracker.,%ID) $iif($readini(Smith.ini,Rsn,Rsn),$v1,$me)
  }
  if ($Did = 20) {
    if ($Did(Smith,20).state) { Did -c Smith 7 | Writeini Smith.ini Rsn Hammers Yes }
    Elseif (!$Did(Smith,20).state) { Did -u Smith 7 | Did -h Smith 11 | Writeini smith.ini Rsn Hammers No }
  }
  if ($Did = 19) { 
    Writeini Smith.ini Rsn Rsn $Replace($Did(Smith,21),$Chr(32),+)
    Did -r Smith 1,2,3,4,5,6,9,11
    Sockopen Smith rscript.org 80
    Inc %Id
    .sockopen $+(tracker.,%ID) rscript.org 80
    .sockmark $+(tracker.,%ID) $iif($readini(Smith.ini,Rsn,Rsn),$v1,$me)
  }
}
alias SmithCon {
  Did -r Smith 8,13
  Var %c 1
  While (%c <= 11) {
    Var %x $ini(Smith.ini, Level, %c), %xx $Readini(Smith.ini, Level, %x)
    Var %xxx $Readini(Smith.ini, Smelt, %x), %xxxx $Readini(Smith.ini, $iif($Did(Smith,7).state, Hammer, Exp), %x)
    Did -a Smith 8 +c 0 0 0 $Replace(%x,_,$Chr(32)) $chr(9) $+ +c 0 0 0 %xx $chr(9) $+ +c 0 0 0 %xxx $chr(9) $+ +c 0 0 0 %xxxx $chr(9) $+ +c 0 0 0 $Calc(%xxx + %xxxx)
    Inc %c
  }
  Var %o 1, %Exp $Remove($GetTok($Did(Smith,4),3, 32), $Chr(44))
  While (%o <= 11) {
    Var %a $ini(Smith.ini, Smelt, %o), %aa $Calc(%Exp / $Readini(Smith.ini, Smelt, %a))
    Var %aaa $Calc(%Exp / $Readini(Smith.ini, $iif($Did(Smith,7).state, Hammer, Exp), %a)), %aaaa $Calc(%Exp / ($Readini(Smith.ini, $iif($did(Smith,7).state, Hammer, Exp), %a) + $readini(Smith.ini, Smelt, %a)))
    VAr %aaaaa $Readini(Smith.ini, hBar, %a)
    Did -a Smith 13 +c 0 0 0 $Replace(%a,_,$Chr(32)) $chr(9) $+ +c 0 0 0 $Bytes($Ceil(%aa),bd) $chr(9) $+ +c 0 0 0 $Bytes($Ceil(%aaa),bd) $Chr(9) $+ +c 0 0 0 $Bytes($Ceil(%aaaa),bd) $chr(9) $+ +c 0 0 0 $Bytes($Ceil(%aaaaa),bd)
    inc %o
  }
}
on *:SOCKOPEN:tracker.*:{
  .sockwrite -nt $sockname GET $+(/lookup.php?type=track&user=,$sock($sockname).mark,&skill=all&time=,86400,$chr(44),604800,$chr(44),1209600,$chr(44),2419200,$chr(44),14515200,$chr(44),31449600) HTTP/1.1
  .sockwrite -nt $sockname Host: www.rscript.org
  .sockwrite -nt $sockname $clrf
}

on *:SOCKREAD:tracker.*:{
  .var %sockreader
  .sockread %sockreader
  if ($regex(%sockreader,/-1/)) {
    .did -a Smith Tracker Gains 1,5,9 Not found.
    .sockclose $sockname | halt
  }
  if ($regex(%sockreader,/start:Smithing:(.*)/)) {
    .hadd -m $sockname start $regml(1)
  }
  if ($regex(%sockreader,/gain:Smithing:(.*):(.*)/)) {
    .var %lvl.gain = $undoexp($hget($sockname,start)), %lvl.start = $undoexp($calc($hget($sockname,start) - $regml(2)))
    .var %lvl.finish = $+($chr(40),$iif(%lvl.start > 99,99,%lvl.start),$iif(%lvl.start != %lvl.gain && %lvl.start < 99,$+( -> ,%lvl.gain)),$chr(41))
    if ($regml(1) == 86400) { .did -a Smith 1 Track (1 Day): $bytes($regml(2),db) %lvl.finish }
    if ($regml(1) == 604800) { .did -a Smith 5 Track (1 Week): $bytes($regml(2),db) %lvl.finish }
    if ($regml(1) == 31449600) { .did -a Smith 9 Track (1 Year): $bytes($regml(2),db) %lvl.finish }
  }
}
alias undoexp {
  if ($isid) {
    var %e = 0, %x = 1, %y = $1
    while (%e <= %y) {
      inc %e $calc($floor($calc(%x + 300 * 2 ^ (%x / 7))) / 4)
      inc %x
    }
    return $calc(%x - 1)
  }
}

on *:Load: {

  Writeini -n Smith.ini Level Bronze 1
  Writeini -n Smith.ini Level Blurite 8
  Writeini -n Smith.ini Level Iron 15
  Writeini -n Smith.ini Level Elemental 20
  Writeini -n Smith.ini Level Silver 20
  Writeini -n Smith.ini Level Steel 30
  Writeini -n Smith.ini Level Gold 40
  Writeini -n Smith.ini Level Gold_(G) 40
  Writeini -n Smith.ini Level Mithril 50
  Writeini -n Smith.ini Level Adamant 70
  Writeini -n Smith.ini Level Runite 85

  Writeini -n Smith.ini Smelt Bronze 6.2
  Writeini -n Smith.ini Smelt Blurite 8
  Writeini -n Smith.ini Smelt Iron 12.5
  Writeini -n Smith.ini Smelt Elemental 7.5
  Writeini -n Smith.ini Smelt Silver 13.7
  Writeini -n Smith.ini Smelt Steel 17.5
  Writeini -n Smith.ini Smelt Gold 22.5
  Writeini -n Smith.ini Smelt Gold_(G) 56.2
  Writeini -n Smith.ini Smelt Mithril 30
  Writeini -n Smith.ini Smelt Adamant 37.5
  Writeini -n Smith.ini Smelt Runite 50

  Writeini -n Smith.ini Exp Bronze 12
  Writeini -n Smith.ini Exp Blurite 17
  Writeini -n Smith.ini Exp Iron 25
  Writeini -n Smith.ini Exp Elemental 10
  Writeini -n Smith.ini Exp Silver 0
  Writeini -n Smith.ini Exp Steel 37.5
  Writeini -n Smith.ini Exp Gold 0
  Writeini -n Smith.ini Exp Gold_(G) 0
  Writeini -n Smith.ini Exp Mithril 50
  Writeini -n Smith.ini Exp Adamant 62.5
  Writeini -n Smith.ini Exp Runite 75

  Writeini -n Smith.ini Hammer Bronze=24
  Writeini -n Smith.ini Hammer Blurite=0
  Writeini -n Smith.ini Hammer Iron=50
  Writeini -n Smith.ini Hammer Elemental=0
  Writeini -n Smith.ini Hammer Silver=0
  Writeini -n Smith.ini Hammer Steel=75
  Writeini -n Smith.ini Hammer Gold=0
  Writeini -n Smith.ini Hammer Gold_(G)=0
  Writeini -n Smith.ini Hammer Mithril=100
  Writeini -n Smith.ini Hammer Adamant=125
  Writeini -n Smith.ini Hammer Runite=150

  Writeini -n Smith.ini hBar Bronze 2560
  Writeini -n Smith.ini hBar Blurite 0
  Writeini -n Smith.ini hBar Iron 1283
  Writeini -n Smith.ini hBar Elemental 0
  Writeini -n Smith.ini hBar Silver 0
  Writeini -n Smith.ini hBar Steel 854
  Writeini -n Smith.ini hBar Gold 0
  Writeini -n Smith.ini hBar Gold_(G) 0
  Writeini -n Smith.ini hBar Mithril 640
  Writeini -n Smith.ini hBar Adamant 513
  Writeini -n Smith.ini hBar Runite 427
}
