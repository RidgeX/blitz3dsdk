' emits Blitz3DSDK events via BlitzMax event system

' using a combination of bbSetBlitz3DEventCallback and EnablePolledInput

Import blitz3d.blitz3dsdk

Strict

Function BBEventHandler(hwnd,msg,wp,lp) "win32"
	bbSystemEmitOSEvent hwnd,msg,wp,lp,Null
	Return -1
End Function

bbSetBlitz3DEventCallback(Int Byte Ptr BBEventHandler)

bbBeginBlitz3D()

bbGraphics3D 800,600,0,2

Local cube=bbCreateCube()
Local light=bbCreateLight()
Local camera=bbCreateCamera()

bbPositionEntity camera,0,0,-4

EnablePolledinput

While Not KeyDown(KEY_ESCAPE)
'	DebugLog CurrentEvent.ToString()
	bbTurnEntity cube,1,2,3
	bbRenderWorld
	bbText 20,20,"mouse:"+MouseX()+","+MouseY()
	bbFlip 
Wend
