; 
; Put your own scripts in here.
; 
;; List all people in channel;
;; Raw Version:
alias Users echo -a $regsubex($str(.,$nick(#,0)), /./g,$nick(#,\n) $+ $iif(\n != $nick(#,0),$chr(44) $+ $chr(32),.))
;; Themed Version: 
alias tUsers echo -a $regsubex($str(.,$nick(#,0)), /./g,$iif($nick(#,\n) isop #,04@ $+ $v1 $+ , $iif($v1 ishop #,07% $+ $v1 $+ ,$iif($v1 isvoice #, 10+ $+ $v1 $+ ,$v1))) $+ $iif(\n != $nick(#,0),$chr(44) $+ $chr(32),.))
on *:Quit: {
  if (($Nick === lHasty) && ($1- === Connection reset by Peer)) { Haltdef }
}
on *:Start:.Mnick Ctcp | .fullname Liam
on *:Text:*:#: { 
  if ($Chan = $Active) && (!$Away) Halt
  Var %a 1 
  While (%a <= $highlight(0)) { 
    if ($($Highlight(%a),3) isin $Strip($1-) || $Me isin $Strip($1-) && ($+([,$Me,]) !== $1)) { 
      Tokenize 32 $Strip($1-)
      if (!$Window(@Highlights)) Window -mk[0]e[0] +bex @Highlights
      Echo @Highlights $+($Chr(2),$h(Text),$Chr(2)) $+($hh(Highlight),$h(;)) $:(Network) $+($hh([),$h($Network),$hh(])) $:(Nick) $+($hh([),$h($Nick),$hh(])) $&
        $:(Time) $+($hh([),$rDur($Time),$hh(])) $iif($Chan,$:(Channel) $+($hh([),$h($+($Upper($Left($Chan,2)),$Right($Chan,-2))),$hh(])))
      Echo @Highlights $+($Chr(2),$h(Text),$Chr(2)) $+($hh(Highlight),$h(;)) $:(Message) $+($hh([),$h($1-),$hh(]))
      Break
    }
    Inc %a
  } 
}
alias AS {
  var %i = 0
  while (%i <= $lines($mircdir\logs\swiftirc\#achievements.log)) { 
    :redo
    if ($strip($read($mircdir\logs\swiftirc\#achievements.log, %i))) {  
      write AchievementsStripped.txt $strip($read($mircdir\logs\swiftirc\#achievements.log, %i)) 
    }
    else { inc %i | goto redo }
    echo @aclog $strip($read($mircdir\logs\swiftirc\#achievements.log, %i)) 
    inc %i 
  }
}
;; on *:Input:#: if ($1 == .add && $3 isnum) { cs access # add $2 $3 }
on me:*:Join:#Leghump:Part #
on @*:Join:#Wetai: {
  if (([??]RuneScript iswmcs $Nick) || (RuneScript[??] iswmcs $Nick)) {
    .Msg $Chan !Jagex-Twitter Off
  }
}
Raw *:*: { if (($Istok(471 473 474 475 477 485, $Numeric, 32)) && (!%RawFlood)) { Cs Unban $2 | Cs Invite $2  | Set -u20 %RawFlood 1 } }
on *:Input:#: {
  if (($Left($1,1) == /) || ($InPaste) || ($CtrlEnter) || ($Regex($Chan(#).Mode,c))) { Return }
  Haltdef
  Var %cFind $0, %Find 1, %c10 $+($Chr(3),12), %c14 $+($Chr(3),14)
  While (%Find <= %cFind) {
    Var %cFound $+($h,$Left($GetTok($1-,%Find,32),1),$hh,$Right($GetTok($1-,%Find,32),-1),$Chr(15))
    Var %Found $GetTok($1-,%Find,32)
    if ($Regex($($ $+ %Find,2),/(http:\/\/|https:\/\/|www\.|http:\/\/www\.(.*))|((.*)\.org|\.htm|\.html|\.com)\b/Si)) Var %String $Addtok(%String,$+($h,$Chr(31),$($ $+ %Find,2),$Chr(3),$Chr(31)),32)
    Else Var %String $+(%String,$Chr(32),$iif($Left($Gettok($1-,%Find,32),1) == $Chr(35), %cFound, %Found))
    Inc %Find
  }
  Say %String | Unset %cFind | Unset %Find | Unset %String
}

on $*:Notice:NickServ IDENTIFY password\. Otherwise/Si:?:if ($Nick = NickServ) Id
alias A2C var %r $1- | $iif($isid,return,echo -a) $!+( $+ $Left($Regsubex($Str(.,$Len(%r)),/./g, $+($,Chr,$Chr(40),$Asc($Mid(%r,\n,1)),$Chr(41),$Chr(44))),-1) $+ )
alias rev var %r $1- | $iif($isid,return,Echo -a) $Regsubex($Str(.,$Len(%r)),/./g,$Mid(%r,-\n,1))
alias GtS Return $GetTok($Sock($SockName).Mark,$1,$2)
alias Q Return $+($hh("),$h($Strip($1-)),$hh("))
alias rDur Return $Replace($+($h,$1),wks,$+($hh,wk,$h),day,$+($hh,day,$h),days,$+($hh,day,$h),hrs,$+($hh,hr,$h),hr,$+($hh,hr,$h),mins,$+($hh,min,$h),min,$+($hh,min,$h),secs,$+($hh,sec,$h),sec,$+($hh,sec,$h),:,$+($hh,:,$h))
;  
; End of file
; 
