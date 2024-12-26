
Global Tfm  [lensDiameter * lensDiameter * 2+1]
Global Org  [lensDiameter * lensDiameter * 2+1, 3+1]
Global Dest [lensDiameter * lensDiameter * 2+1, 3+1]

Function CreateLens (diameter, magnification)
	r = Int (diameter / 2)
	s# = Sqr (r * r - magnification * magnification)
	For y = -r To -r + (diameter)
		For x = -r To r + (diameter - 1)
			If (x * x + y * y) >= (s * s)
				a = x
				b = y
			Else
				z = Sqr (r * r - x * x - y * y)
				a = Int (x * magnification / z + 0.5)
				b = Int (y * magnification / z + 0.5)
			EndIf
			Tfm (1 + (y + r) * diameter + (x + r)) = (b + r) * diameter + (a + r)
		Next
	Next
End Function

Function DrawLens (x, y, diameter)
	bbLockBuffer bbBackBuffer ()
	For i = x To (x + diameter) - 1
		For j = y To (y + diameter) - 1
			rgb = bbReadPixelFast (i, j)
			Org (cx, 1) = rgb Shr 16 & %11111111
			Org (cx, 2) = rgb Shr 8 & %11111111
			Org (cx, 3) = rgb & %11111111
			cx = cx + 1
		Next
	Next
	cx = 1
	For i = x To (x + diameter) - 1
		For j = y To (y + diameter) - 1
			Dest (cx, 1) = Org (Tfm (cx), 1)
			Dest (cx, 2) = Org (Tfm (cx), 2)
			Dest (cx, 3) = Org (Tfm (cx), 3)
			bbWritePixelFast i, j, Dest (cx, 3) | (Dest (cx, 2) Shl 8) | (Dest (cx, 1) Shl 16)
			bbPlot (i, j)
			cx = cx + 1
		Next
	Next
	bbUnlockBuffer bbBackBuffer ()
End Function
