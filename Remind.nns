Alias Remind {
  if (!$1 && %Remind*) || ($1 == Info) { Echo -a $+($hh([),$h(Timer),$hh(]) $hh(—),$h(>)) $hh(Current Timer Info:) $h(%RemindRes) $+ $&
    $hh(; Timer Started:) $h(%RemTime) $+ $hh(; Current Timer Duration:) $h($Duration($Calc($CTime - %RemCTime))) $+ $hh(.) | Halt }
  elseif ($1 == Off) { Unset %RemindRes | Unset %RemTime | Unset %RemCtime | Unset %RemindTime | .Timer.Remind Off 
  Echo -a $Tags(Timer) $hH(Current Timer) $h(Removed.) | Halt }
  elseif (%RemindTime) { Echo -a $Tags(Timer) $hh(You already have a timer active! Timer Reason:) $h(%RemindRes) $+ $&
    $hh(; Timer Started:) $h(%RemTime) $+ $hh(; Current Timer Duration:) $h($Duration($Calc($CTime - %RemCTime))) $+ $hh(.) | Halt }
  elseif (!%RemindTime && !%RemindRes && !%RemTime && !%RemCtime) {
    Set %RemindTime $Calc($Replace($1,h,*3600,m,*60,s,*1))
    Set %RemindT $1
    Set %RemindRes $2-
    Set %RemTime $Time
    Set %RemCTime $Ctime
    Echo -a $Tags(Timer) $hh(Your Timer for) $h(%RemindRes $+($chr(40),%RemindT,$chr(41))) $hh(has now been started. $chr(40) $+ Started at) $&
      $h(%RemTime) $+ $hh($chr(41))
    .Timer.Remind 1 %RemindTime RemindMe
  }
}
Alias RemindMe {
  Echo -a $Tags(Timer) $hh(Your Timer for) $h(%RemindRes) $+ $hh(; Started at) $h(%RemTime $chr(40)) $&
    $+ $h($Duration($Calc($CTime - %RemCTime)) Ago $+ $chr(41)) $hh(is now complete.)
  Unset %RemindRes | Unset %RemTime | Unset %RemCTime | Unset %RemindTime | Unset %RemindT
}
