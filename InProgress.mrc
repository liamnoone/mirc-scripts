;;; Aliases needed for colouring. Changing colour by changing "$Chr(3),12,$Chr(2)" to "Chr(3),<Colour>,$Chr(2)" $h is the main colour, $hh is the secondary colour.
alias -l h { return $+($chr(3),12,$chr(2),$chr(2),$1-,$chr(3),$chr(2),$chr(2)) }
alias -l hh { return $+($chr(3),14,$chr(2),$chr(2),$1-,$chr(3),$chr(2),$chr(2)) }
alias -l Tags { Return $+($hh([),$h($1-),$hh(]) $hh(—),$h(>),) }
;;;

alias FML {
  if ($Sock(FML)) { SockClose FML }
  Set %FMLOut $iif($1 = -s, Say, Echo -a)
  Sockopen FML rscript.org 80
}
On *:SockOpen:FML: {
  Sockwrite -nt FML GET /lookup.php?type=fml
  SockWrite -nt FML Host: rscript.org
  SockWrite -nt FML $crlf
}
on *:SockRead:FML: {
  if ($SockErr) { SockClose FML | SockOpen FML rscript.org 80 }
  Var %FML 
  SockRead %FML
  if ($Regex(%FML,ID:)) { Set %FMLID $GetTok(%FML,2-,32) }
  if ($Regex(%FML,Cate:)) { Set %FMLCate $GetTok(%FML,2-,32) }
  if ($Regex(%FML,TEXT:)) { Set %FMLText $GetTok(%FML,2-,32) }
  if ($Regex(%FML,Agree:)) { Set %FMLAggree $Bytes($GetTok(%FML,2-,32),bd) }
  if ($Regex(%FML,Deserved:)) { Set %FMLDisaggree $Bytes($GetTok(%FML,2-,32),bd) }
  if ($Regex(%FML,Comments:)) { Set %FMLComments $Bytes($GetTok(%FML,2-,32),bd) }
  if ($Regex(%FML,END)) { SockClose FML }
  if (!$Sock(FML)) {
    %FMLOut $Tags(FML) $hh(FML:) $h(%FMLText)
    Echo -a $Tags(FML) $hh(Information:) $hh(Agreed:) $h(%FMLAggree) $hh($(|)) $hh(Deserved:) $h(%FMLDisaggree) $hh($(|)) $hh(Comments:) $h(%FMLComments) 
    Echo -a $Tags(FML) $hh(Link:) $h($+(,http://www.fmylife.com,/,%FMLCate,/,%FMLID,/,))
    Unset %FML*
  }
}
on *:SockError:FML: { echo -a Error: $Error }
