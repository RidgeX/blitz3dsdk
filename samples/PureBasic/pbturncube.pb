
IncludeFile "../../include/blitz3dsdk.pbi"

bbBeginBlitz3D ()

bbSetBlitz3DTitle ("PB Cube - use cursors to move, ESC to exit", "Are you sure?")

bbGraphics3D (640, 480, 0, 2)

cam = bbCreateCamera ()
cube = bbCreateCube ()
light = bbCreateLight ()

bbMoveEntity (cube, 0, 0, 5)
bbMoveEntity (light, -10, 5, -1)
bbPointEntity (light, cube)

Repeat

    If bbKeyDown (#KEY_LEFT)
        bbTurnEntity (cube, 0, -0.5, 0)
    EndIf

    If bbKeyDown (#KEY_RIGHT)
        bbTurnEntity (cube, 0, 0.5, 0)
    EndIf

    If bbKeyDown (#KEY_UP)
        bbTurnEntity (cube, 1, 0, 0, 0)
    EndIf

    If bbKeyDown (#KEY_DOWN)
        bbTurnEntity (cube, -1, 0, 0, 0)
    EndIf
    
    bbRenderWorld ()
    bbFlip ()
    
Until bbKeyHit (#KEY_ESCAPE)

bbEndBlitz3D ()

End

; IDE Options = PureBasic 4.20 (Windows - x86)
; CursorPosition = 1
; Folding = -
; EnableXP