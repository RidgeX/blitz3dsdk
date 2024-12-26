Import blitz3d.blitz3dsdk

Import "bbtype.bmx"
Import "blitz3d.bmx"

bbBeginBlitz3D()

Global info1$="Flag demo"
Global info2$="Features mesh deformation"

Include "../start.bmx"

Const segs=128,width#=4,depth#=.125

mesh=bbCreateMesh()
surf=bbCreateSurface( mesh )

For k=0 To segs
	x#=Float(k)*width/segs-width/2
	u#=Float(k)/segs
	bbAddVertex surf,x,1,0,u,0
	bbAddVertex surf,x,-1,0,u,1
Next

For k=0 To segs-1
	bbAddTriangle surf,k*2,k*2+2,k*2+3
	bbAddTriangle surf,k*2,k*2+3,k*2+1
Next

b=bbLoadBrush( "b3dlogo.jpg" )
bbPaintSurface surf,b

camera=bbCreateCamera()
bbPositionEntity camera,0,0,-5

light=bbCreateLight()
bbTurnEntity light,45,45,0

While Not bbKeyHit(1)

	ph#=MilliSecs()/4
	cnt=bbCountVertices(surf)-1
	For k=0 To cnt
		x#=bbVertexX(surf,k)
		y#=bbVertexY(surf,k)
		z#=Sin(ph+x*300)*depth
		bbVertexCoords surf,k,x,y,z
	Next
	bbUpdateNormals mesh
	
	If bbKeyDown(26) bbTurnEntity camera,0,1,0
	If bbKeyDown(27) bbTurnEntity camera,0,-1,0
	If bbKeyDown(30) bbMoveEntity camera,0,0,.1
	If bbKeyDown(44) bbMoveEntity camera,0,0,-.1
	
	If bbKeyDown(203) bbTurnEntity mesh,0,1,0,True
	If bbKeyDown(205) bbTurnEntity mesh,0,-1,0,True
	If bbKeyDown(200) bbTurnEntity mesh,1,0,0,True
	If bbKeyDown(208) bbTurnEntity mesh,-1,0,0,True
	
	bbUpdateWorld
	bbRenderWorld
	bbFlip
Wend
End
