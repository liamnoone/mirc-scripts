Alias Script { $iif($Dialog(Script), Dialog -x Script) | Dialog -m Script Script }
dialog Script {
  title "Script Manager."
  size -1 -1 149 94
  option dbu
  list 1, 9 10 132 50, size
  box "Script Files/Status.", 3, 3 1 143 65
  button "Load", 4, 3 69 45 11
  button "Unload", 5, 53 69 45 11
  button "Unload + Delete", 6, 53 81 45 11
  button "Delete", 7, 3 81 45 11
  button "Close.", 8, 101 81 45 11, ok
  button "Information", 9, 101 69 45 11
}
on *:Dialog:Script:Init:0: { 
  Did -a Script 1 Script Manager
  Did -a Script 1 Format: File Name ¤ File Status
  Var %x 0, %xx $FindFile($MircDirScripts,*,0), %xxx, %xxxx, %o 1, %oo $Script(0)
  while (%x <= %xx) {
    Inc %x
    Var %xxx $FindFile($MircDirScripts,*,%x), %xxxx $Remove(%xxx,$MircDirScripts\)
    if (!$Regex($Right(%xxx,3),/(txt|nns|ini)/Si)) { Continue }
    Did -a Script 1 $+($Upper($Left(%xxxx,1)),$Right(%xxxx,-1)) ¤ $iif($Script(%xxx), Loaded, Not Loaded)
  }
  Unset %x
}
on *:Dialog:Script:dClick:1: {
  Var %o $Findtok($Did(Script,1).Seltext, ¤, 32)
  .Run $+($MircDirScripts,\,$GetTok($Did(Script,1).seltext, $+(1,-,$Calc(%o - 1)), 32))
}
on *:Dialog:Script:Sclick:*: { 
  Var %o $Findtok($Did(Script,1).Seltext, ¤, 32), %oooo $+(1,-,$Calc(%o - 1)), %ooooo $+(Scripts,\,$GetTok($Did(Script,1).seltext, %oooo, 32))
  if ($Did = 4) {
    Did -o Script 1 $Did(Script,1).sel $GetTok($Did(Script,1).seltext, %oooo, 32) $iif($Script($Gettok($Did(Script,1).seltext,1,32)), ¤ Not Loaded, ¤ Loaded)
    .Load -rs %ooooo
  }
  if ($Did = 5) {
    Did -o Script 1 $Did(Script,1).sel $GetTok($Did(Script,1).seltext, %oooo, 32) $iif($Script($Gettok($Did(Script,1).seltext,1,32)), ¤ Not Loaded, ¤ Loaded)
    .UnLoad -rs %ooooo
  }
  if ($Did = 6) {
    If ($input($+(Remove $GetTok($Did(Script,1).seltext, %oooo, 32),?,$crlf,Doing this will erase the file,$chr(44) only do it if you're completely sure as this action cannot be reversed without a backup!),yg, Remove?)) {
      .Unload -rs $+(Scripts,\,$GetTok($Did(Script,1).seltext, %oooo, 32))
      .Remove -b $+(Scripts,\,$GetTok($Did(Script,1).seltext, %oooo, 32))
      Did -d Script 1 $Did(Script,1).Sel
    }
  }
  if ($Did = 7) {
    Var %o $Findtok($Did(Script,1).Seltext, ¤, 32), %oooo $+(1,-,$calc(%o - 1)),  %ooooo $+(Scripts,\,$GetTok($Did(Script,1).seltext, %oooo, 32))
    if ($Script($GetTok($Did(Script,1).seltext, %oooo, 32))) {
      Noop $Input(Cannot Perform Action as you cannot delete a running file without first unloading it! Click "Unload + Delete" if you must delete this running script., go)
      Halt
    }
    If ($input($+(Remove $Gettok($Did(Script,1).seltext, %oooo, 32),?,$crlf,Doing this will erase the file,$chr(44) only do it if you're completely sure as this action cannot be reversed without a backup!),yg, Remove?)) {
      Did -d Script 1 $Did(Script,1).Sel
      .Remove -b %ooooo
    }
  }
  if ($Did = 9) {
    Var %o $Findtok($Did(Script,1).Seltext, ¤, 32), %oo $GetTok($Did(Script,1).seltext, $+(1,-,$calc(%o - 1)), 32), %ooo $+($MircDirScripts,\,%oo)
    Noop $Input(File Information for $+(%oo,:,$Crlf) $+ $&
      Creation Date: $+($AscTime($File(%ooo).cTime),$Crlf) $+ $&
      Last Accessed: $+($AscTime($File(%ooo).aTime),$Crlf) $+ $&
      Last Modified: $+($AscTime($File(%ooo).mTime),$Crlf) $+ $&
      Size: $+($Bytes($File(%ooo).Size,bd) Bytes,$Crlf) $+ $&
      ,go)
  }
}
