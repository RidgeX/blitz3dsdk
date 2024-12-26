
; Play with this value!

#NUM_CUBES = 200 ; 1000 - 2000 fine here on Core 2 Duo 6300 / Geforce 6800 GS

; Include Blitz3D engine...

IncludeFile "../../include/blitz3dsdk.pbi"

; Initialise Blitz3D engine...

bbBeginBlitz3D ()

; Set debug mode (it's on by default -- just added this so you can turn it off)...

bbSetBlitz3DDebugMode (1) ; 1 = DEBUG ON, 0 = DEBUG OFF

; Window title and close gadget warning text...

bbSetBlitz3DTitle ("Use cursors plus A & Z", "Are you sure?")

; Open dislay...

bbGraphics3D (640, 480)

; Camera...

cam = bbCreateCamera ()
bbCameraClsColor (cam, 64, 128, 180)
bbCameraRange (cam, 0.1, 1000)
bbMoveEntity (cam, 0, 5, 0)

; Light...

light = bbCreateLight ()
bbMoveEntity (light, -10, 5, -1)

; Grass...

grasstex = bbLoadTexture ("grass.png")
plane = bbCreatePlane ()
bbEntityTexture (plane, grasstex)

; Cube (will be hidden and 20 copies made)...

cubetex = bbLoadTexture ("boing.png")
cube = bbCreateCube ()
bbMoveEntity (cube, 0, 0, 5)
bbEntityTexture (cube, cubetex)
bbHideEntity (cube)

; Point light to centre of world...

bbPointEntity (light, cube)

; Create duplicates of cube entity...

Dim cubes (#NUM_CUBES)

For dupe = 1 To #NUM_CUBES
    cubes (dupe) = bbCopyEntity (cube)
    bbPositionEntity (cubes (dupe), Random (50) - 25, Random (25) + 2, Random (50))
    bbTurnEntity (cubes (dupe), Random (720) - 360, Random (720) - 360, Random (720) - 360)
Next

Repeat

    ; Rotate all cubes...
    
    For dupe = 1 To #NUM_CUBES
        bbTurnEntity (cubes (dupe), 0.1, 0.2, 0.3)
    Next

    ; Camera control...
    
    ; Turn left/right...
    
    If bbKeyDown (#KEY_LEFT)
        bbTurnEntity (cam, 0, 1, 0, 1)		; The last parameter here makes sure we rotate
    Else									; on the 3D world's y-axis. Change to 0 to see
        If bbKeyDown (#KEY_RIGHT)			; the undesired effect of rotating on the entity's
            bbTurnEntity (cam, 0, -1, 0, 1)	; own y-axis (at least in this case)...
        EndIf
    EndIf
    
    ; Tilt up/down...
    
    If bbKeyDown (#KEY_UP)
        bbTurnEntity (cam, 1, 0, 0)
    Else                                
        If bbKeyDown (#KEY_DOWN)
            bbTurnEntity (cam, -1, 0, 0)
        EndIf
    EndIf

    ; Forwards/backwards...
    
    If bbKeyDown (#KEY_A)
        bbMoveEntity (cam, 0, 0, 0.25)
    Else
        If bbKeyDown (#KEY_Z)
            bbMoveEntity (cam, 0, 0, -0.25)
        EndIf
    EndIf
    
    ; Render 3D world to back buffer...

    bbRenderWorld ()
    
    ; Show the rendered buffer (flips back buffer to front buffer)...
    
    bbFlip ()
    
Until bbKeyHit (1)

; Close down Blitz3D engine...

bbEndBlitz3D ()

End

; IDE Options = PureBasic 4.30 (Windows - x86)
; CursorPosition = 84
; FirstLine = 54
; Folding = -
; EnableXP