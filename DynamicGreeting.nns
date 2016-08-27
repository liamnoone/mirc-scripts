;on *:Connect: { DynamicGreet }
Alias DynamicGreet {
  if ($Sock(Greet)) { SockClose Greet }
  if (!%Greet-RSN) { Set %Greet-RSN $?="Insert RSN Here." }
  if (!%Greet-Skill) { Set %Greet-Skill $?="Pick a skill! If the skill is Overall the script won't function correctly." }
  SockOpen Greet rscript.org 80 
}
on *:SockOpen:Greet: {
  SockWrite -nt Greet GET $+(/Lookup.php?type=stats&user=,%Greet-RSN) HTTP/1.1
  SockWrite -nt Greet Host: rscript.org
  SockWrite -nt Greet $crlf
}
on *:SockRead:Greet: {
  if ($SockErr) { SockClose Greet | SockOpen Greet rscript.org 80 }
  Else {
    Var %Greet
    SockRead %Greet
    if (%Greet-Skill isin %Greet) {
      Tokenize 32 $GetTok(%Greet,2-,32)
      Set %Greet.Rank $Bytes($1,bd) | Set %Greet.Level $Bytes($2,bd)
      Set %Greet.Exp $Bytes($3,bd) | Set %Greet.99 $Bytes($Calc(13034431 - $3),bd) 
      Ns set greet %Greet-Skill Statistics: Level: %Greet.Level ¤ $&
        Rank: %Greet.Rank ¤ Exp: %Greet.Exp $+($Chr(40),%Greet.99 To 99 $Chr(40), $&
        $Round($Calc(($3 /13034431)*100),2),%,$chr(41),$Chr(41))
      Unset %Greet.*
      SockClose Greet
    }
  }
}
Menu Channel {
  Refresh Stats Info: DynamicGreet
}
