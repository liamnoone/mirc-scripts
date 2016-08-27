alias -l AR { return $+($chr(3),%AwayRand,$chr(2),$chr(2),$1-,$chr(3),$chr(2),$chr(2)) }
alias -l HH { return $+($chr(3),14,$chr(2),$chr(2),$1-,$chr(3),$chr(2),$chr(2),$chr(15)) }
alias -l ARU { return $+($Chr(31),$Chr(3),%AwayRand,$chr(2),$chr(2),$1-,$chr(3),$chr(2),$chr(2),$chr(15)) }

alias Aaway {
  if (%Afk) { Echo -at $hh(You're Already set Away! $Chr(124)  Type /Bback To Return, or /Change to change away reason.) | HALT }
  var -g %AwayRand $Rand(2,14), %Afk 1, %AwayTime $Replace($time,:,¤), %AwayCtime $ctime, %AwayMSG $iif($1 = -q,$iif(!$2,z0mg,$2-),$iif(!$1,z0mg,$1-)), %AwayQ $iif($1 = -q,0,1), %AwayNick $Me
  var %beginning $+($hh([),$Aru(Away),$hh(]))
  var %mid $+($hh(¤) $Ar(A),$hh(way) $Ar(R),$hh(eason: $chr(91)))
  var %mid2 $+($Aru(%AwayMsg),$hh($chr(93)))
  var %mid3 $+($AR(L),$hh(eft) $AR(A),$hh(t: [))
  var %end $+($Aru(%AwayTime),$hh($chr(93)))
  if (%AwayQ) Amsg $+(%beginning %mid,%mid2 $hh(¤) %mid3, %end)
  Away %AwayMSG
  if (%AwayQ && *|Away !iswm $Me) TNick $Me $+ |Away
}
alias Bback {
  if (%Afk != 1) { Echo -at $hh(You're not Away!) | HALT }
  unset %Afk
  if (%AwayQ && *|Away iswm $Me) TNick %AwayNick
  var %TimeAFK $Replace($duration($calc($ctime - %AwayCTime),3),:,¤)
  var %beginning $+($hh([),$Aru(Back),$hh(]))
  var %mid $+($hh(¤) $Ar(A),$hh(way) $Ar(R),$hh(eason: $chr(91)))
  var %mid2 $+($Aru(%AwayMsg),$hh($chr(93)))
  var %mid3 $+($Ar(A),$hh(way) $Ar(D),$hh(uration: [))
  var %end $+($Aru(%TimeAFK),$hh($chr(93)))
  if (%AwayQ) Amsg $+(%Beginning %Mid, %Mid2 $hh(¤) %Mid3, %End) 
  Away
  Unset %AwayCTime
  Unset %AwayTime
  Unset %AwayRand
  Unset %AwayMSG
  Unset %Told.Afk.*
  Unset %TimeAfk
  Unset %AwayQ
  Unset %AwayNick

}

alias Change {
  if (%Afk != 1) { Echo -at $hh(You're not away! $Chr(124) Cannot Change Away Reason) | HALT }
  Var %FirstAFK %AwayMSG
  set %AwayMSG $1-
  Var %CurTimeAFK $Replace($duration($calc($ctime - %AwayCTime),3),:,¤)
  Var %Beginning $+($hh([),$Aru(Away),$hh(]))
  var %mid $+($hh(¤) $Ar(A),$hh(way) $Ar(R),$hh(eason) $Ar(C),$hh(hanged) $Ar(F),$hh(rom: $chr(91))))
  var %mid2 $+($Aru(%FirstAFK),$hh($chr(93)) $Ar(t),$hh(o: $chr(91)))
  var %mid3 $+($Aru(%AwayMSG),$hh($chr(93))) 
  var %mid4 $+($Ar(C),$hh(urrent) $Ar(T),$hh(ime) $Ar(A),$hh(way: $chr(91)))
  var %End $+($Aru(%CurTimeAFK),$hh($chr(93))))
  if (%AwayQ) Amsg $+(%Beginning %Mid, %Mid2,%Mid3 $hh(¤) %Mid4,%End)
  Away %AwayMSG
}

on *:Text:*:#: { 
  if (%Afk == 1) {
    if ((!%Told.Afk. [ $+ [ $Nick ] ]) && ((Wetty isin $Strip($1-)) || (Wetai isin $Strip($1-)) || ($Me isin $Strip($1-))) && ($Nick !isin %SwiftServices)) { 
      Set -e %Told.Afk. [ $+ [ $nick ] ] 1
      .Notice $Nick $hh(I Am Currently) $+($hh($Chr(91)),$Aru(Away),$hh($chr(93))) $hh(Reason: [) $+ $+($Aru(%AwayMSG),$hh($chr(93))) $& 
        $hh(Time Left: [) $+ $+($Aru(%AwayTime),$hh($chr(93))) $+ $hh(.) 
    }
  }
}
on *:Action:*:#: { 
  if (%Afk == 1) {
    if ((!%Told.Afk. [ $+ [ $Nick ] ]) && ((Wetty isin $Strip($1-)) || (Wetai isin $Strip($1-)) || ($Me isin $Strip($1-))) && ($Nick !isin %SwiftServices)) { 
      Set -e %Told.Afk. [ $+ [ $nick ] ] 1
      .Notice $Nick $hh(I Am Currently) $+($hh($Chr(91)),$Aru(Away),$hh($chr(93))) $hh(Reason: [) $+ $+($Aru(%AwayMSG),$hh($chr(93))) $&
        $hh(Time Left: [) $+ $+($Aru(%AwayTime),$hh($chr(93))) $+ $hh(.) 
    }
  }
}
