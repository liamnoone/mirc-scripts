/Alias Tags Return $+($hh([),$h($1-),$hh(]))
Alias RN Var %c $+($nick($chan,$rand(1,$nick(#,0)))) | $iif($Isid, Return , Echo -a) $+($Upper($Left(%c,1)),$Lower($Right(%c,-1)))
Alias RC Var %x $Chan($Rand(1,$Chan(0))) | $iif($Isid , Return , Echo -a) $+($Upper($Left(%x,2)),$Lower($Right(%x,-2)))
Alias lvl var %a 0,%b 1,%c $1 | while (%a <= %c) { inc %a $calc($floor($calc(%b + 300 * 2 ^ (%b / 7))) / 4) | inc %b } | return $calc(%b - 1)
Alias main TNick Ctcp
Alias csk cs kick # $1 $2-
Alias cskb cs ban # $1 $2-
Alias e Echo -at $1-
Alias e Echo -at $1-
Alias up ns update
Alias cinfo cs info $1
Alias ninfo ns info $1
Alias alist ns alist $1-
Alias glist ns glist
Alias access cs access $chan $2 $3
Alias memo Ms Send $1 $2-
Alias read .msg MemoServ Read $iif($1 isnum,$1,New)
alias kb { mode # -Q+bb-qaohveeeIII $address($1,2) $address($1,3) $1 $1 $1 $1 $1 $1 $address($1,2) $address($1,3) $1 $address($1,2) $address($1,3)
if ($Regex($Chan(#).Mode,Q)) { cs kick $chan $1 $3- } | Elseif (!$Regex($Chan(#).Mode,Q)) { kick $chan $1 $2- } }
alias inv { mode $Chan -V | Invite $1 $iif($2,$2,$Chan) | Mode $chan +V }
alias parser {
  if (!$1) Url -an rscript.org/lookup.php
  Else Url -an $+(rscript.org/lookup.php/?type=,$lower($1-))
}
alias samsg Var %a = $r(2,14) | Amsg $+($hh([),$Chr(31),$Chr(3),$iif($Len(%a) = 1,$+(0,%a),%a),Amsg,$hh(]),$Chr(15)) $hh() $1-
alias csk { 
  if (($1 ischan) && ($2 ison $1)) { 
    cs kick $1 $2 $3- 
  }
  else { 
    cs kick $chan $1 $iif($2-,$2-,$me) 
  }
}

alias cskb { 
  if (($1 ischan) && ($2 ison $1)) { 
    cs Ban $1 $2 $3- 
  }
  else { 
    cs Ban $chan $1 $iif($2-,$2-,$me) 
  }
}


alias yt echo -at $+($hh(Link),$h(:) $hh(http://www.youtube.com/),$h($iif($1, $+ results?search_query= $+ $replace($1-,$chr(32),+),&search_type=&aq=f)))
alias hk echo -at $+($hh(Link),$h(:) $hh(http://www.hawkee.com/),$h($iif($1, $+ snippets/?search_query= $+ $replace($1-,$chr(32),+))))
alias rsof echo -at $+($hh(Link),$h(:) $hh(http://forum.runescape.com/forums.ws),$h($iif($1, ? $+ $replace($1-,$chr(45),$chr(44),$chr(32),$chr(44)))))
alias list {
  if ($Active == #Tezz && !$1) { Cs Access #Tezz List $Me }
  Else { cs access $Chan List $1- }
}

alias ac {
  var %a 1, %b, %c $+($Chr(3),10), %d $+($Chr(3),14)
  while (%a <= $0) { var %b $+(%b,$chr(32),%c,$Left($gettok($1-,%a,32),1),%d,$Right($Gettok($1-,%a,32),-1)) | inc %a }
  $iif($isid, Return, Echo -a) %b
}
Alias Cpc {
  Var %a 1, %b 1, %d 0, %c $iif($1 == -s, $2-, $1-)
  While (%b <= $Len(%c)) {
    if ($Mid(%c,%b,1) !isalpha) { Inc %b | Continue }
    if ($Mid(%c,%b,1) isupper) { Inc %d }
    inc %b
  }
  Var %e $Len(%c), %cCount $+($h(%d),$hh(/),$hh(%e)), %cPc $h($Replace($Percent(%d,%e,1),%,$hh(%)))
  $iif($1 == -s, Say, Echo -a) $hh(Caps PerCent for %c $+ :) $h(%d) $+($hh($Chr(40)),%cCount $hh($Chr(40)),%cPc,$hh($Chr(41)),$hh($Chr(41)))
  Unset %b | unset %d
}
alias Drop { 
  var %rtime $calc($ctime($remove($1-,UTC)) +7200) 
  echo -a 14Drops at:12 $asctime($calc(%rtime + 5184000), mmm ddoo hh:nntt) 14(12 $+ $duration($calc((%rtime + 5184000) - $ctime)) $+ 14) 
}
alias val { 
  var %x $(,$1-),%t $ticks,%tt $iif($eval(%x,2),%x,$!Null)
  Echo -a $+($Chr(31),$h(E),$Chr(31),$hh(val:)) $+($hh([),$h($Eval($1-,1)),$Chr(15),$chr(32),$hh(),$chr(32),$iif($Regex(%tt,/(\x2|\x3|\x15|\x22|\x31)/i),%tt,$h(%tt)),$Chr(15),$hh(])) $+($h(-),$h($calc($ticks - %t)),$hh(ms),$h(-))
}

alias xp { 
  var %total 0
  var %currlv 1
  while (%currlv < $1) {
    %total = $calc(%total + $floor($calc(%currlv + 300 * (2 ^ (%currlv / 7)))))    
    inc %currlv
  }
  return $floor($calc(%total / 4)) 
}
