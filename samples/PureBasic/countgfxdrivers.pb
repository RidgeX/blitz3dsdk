
; RUN IN DEBUG MODE TO SEE OUTPUT!

IncludeFile "../../include/blitz3dsdk.pbi"

bbBeginBlitz3D ()

Debug ""
Debug "List of drivers..."
Debug ""

For gfx = 1 To bbCountGfxDrivers ()
    Debug "Driver " + Str (gfx) + ": " + PeekS (bbGfxDriverName (gfx))
Next

bbEndBlitz3D ()

End

; IDE Options = PureBasic 4.20 (Windows - x86)
; CursorPosition = 3
; Folding = -
; EnableXP