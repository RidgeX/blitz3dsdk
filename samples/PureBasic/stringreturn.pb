
; RUN IN DEBUG MODE TO SEE OUTPUT!

IncludeFile "../../include/blitz3dsdk.pbi"

bbBeginBlitz3D ()

; Here's how to deal with Blitz3D functions that return strings...

gfx$ = PeekS (bbGfxDriverName (1))

Debug gfx$

bbEndBlitz3D ()

; IDE Options = PureBasic 4.20 (Windows - x86)
; CursorPosition = 3
; Folding = -
; EnableXP