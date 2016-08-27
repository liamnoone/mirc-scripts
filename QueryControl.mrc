dialog GBQC {
  title "GB Query Control"
  size -1 -1 172 54
  option dbu
  button "Accept", 1, 24 37 37 12
  button "Decline", 2, 67 37 37 12
  button "Ignore", 3, 110 37 37 12
  text "", 4, 24 5 123 28
  text "V1.0", 5, 159 46 13 8, disable
}
menu Status,Channel,MenuBar,Query {
  -
  $iif($group(#qc) == on,$style(1)Disable,$style(0)Enable) Use Query Control: {
    var %status = $iif($group(#qc) == on,Disable,Enable)
    $+(.,%status) #qc
    echo -ta 14Query control has been12 $+(%status,d,14.)
  }
  -
}
menu Query {
  $iif($hget(GBQC,$address($active,3)),$style(1),$style(0)) Auto-Accept queries from $active: {
    var %status = $iif($hget(GBQC,$address($active,3)) = 1,Del,Add)
    $+(h,%status) GBQC $address($active,3) 1
    echo -ta $+(12,$active,14) has been12 $iif(%status = del,deleted from,added to) 14Auto-Accept.
  }
}

#qc off
on *:OPEN:?:{
  %QC.nick.address = $address($nick,3)
  %QC.nick = $nick
  if ($hget(GBQC,%QC.nick.address)) {
    .msg $nick $EWRap(PM Auto-Accepted. $iif($away,I may not reply as I am currently away.))
    echo -ta 14Query Control:12Auto-Accept from ' $+ $nick $+ '.
  }
  elseif (!$hget(GBQC,%QC.nick.address)) {
    if ($dialog(GBQC)) { .msg $nick $EWrap(I currently have a que of PMs. If this is important please try again later or send me a memo. /ms send $me yourmessage) | halt }
    window -h $nick
    .msg $nick $EWrap(Please wait for your query to be accepted/declined.)
    dialog -mo GBQC GBQC
    did -ra GBQC 4 %QC.nick ( $+ %QC.nick.address $+ ) has PMed you. Do you want to accept, decline or ignore?
  }
}
on *:exit:{
  .hsave -s GBQC GBQC.hsh
}
on *:start:{
  .hmake GBQC 100
  if ($exists(GBQC.hsh)) {
    .hload -s GBQC GBQC.hsh
  }
}
#qc end
on *:dialog:GBQC:sclick:1:{
  window -w %QC.nick
  window -a %QC.nick
  .msg %QC.nick $Ewrap(I have accepted your PM. You do not have to repeat your last message as I can see it already. $iif($away,I may not reply as I am currently away.))
  dialog -x GBQC
  if ($?!"Do you want to add this user ( $+ %QC.nick $+ ) to your auto-accept list?") addexc %QC.nick.address
  unset %QC.nick
}
on *:dialog:GBQC:sclick:2:{
  .msg %QC.nick $EWrap(I have declined your Private Message. A 2 minute ignore has been put on your nick for private messages to prevent abuse.)
  .ignore -pu120 %QC.nick.address
  close -m %QC.nick
  dialog -x GBQC
  unset %QC.*
}
on *:dialog:GBQC:sclick:3:{
  msg %QC.nick $EWrap(Private Message Declined. You have been ignored.)
  .ignore -pu1200 %QC.nick.address
  close -m %QC.nick
  dialog -x GBQC
  unset %QC.*
}
alias addexc {
  if (!$hget(GBQC)) hmake GBQC 100
  hadd GBQC %QC.nick.address 1
  echo -ta 14Query Control:12 Added ' $+ $address(%QC.nick,3) $+ ' to auto-accept list.
}
alias ewrap {
  var %msg
  var %tok = 1
  var %word
  while ($gettok($1-,%tok,32) != $null) {
    %word = $gettok($1-,%tok,32)
    %msg = %msg 15 $+ $upper($left(%word,1)) $+ 15 $+ $right(%word,-1) 
    inc %tok
  }
  return 12,1(15 $+ %msg $+ 12)
}
