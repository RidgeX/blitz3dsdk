
; IMPORTANT: The BBGraphics type is called _BBGraphics in PureBasic!

Global b3ddll = OpenLibrary (#PB_Any, "b3d.dll")
If b3ddll = 0
	MessageRequester ("Fatal error!", "Failed to open b3d.dll!", #PB_MessageRequester_Ok)
	End
EndIf

#BBFALSE = 0
#BBTRUE = 1

#GFX_DEFAULT = 0
#GFX_FULLSCREEN = 1
#GFX_WINDOWED = 2
#GFX_WINDOWEDSCALED = 3

#PROJ_NONE = 0
#PROJ_PERSPECTIVE = 1
#PROJ_ORTHO = 2

#LIGHT_DIRECTIONAL = 1
#LIGHT_POINT = 2
#LIGHT_SPOT = 3

#TX_COLOR = 1
#TX_ALPHA = 2
#TX_MASKED = 4
#TX_MIP = 8
#TX_CLAMPU = 16
#TX_CLAMPV = 32
#TX_SPHERE = 64
#TX_CUBIC = 128
#TX_VRAM = 256
#TX_HIGHCOLOR = 512

#TX_BLEND_NONE = 0
#TX_BLEND_ALPHA = 1
#TX_BLEND_MULT = 2
#TX_BLEND_ADD = 3
#TX_BLEND_DOT3 = 4
#TX_BLEND_MULT2 = 5

#CUBEFACE_LEFT = 0
#CUBEFACE_FRONT = 1
#CUBEFACE_RIGHT = 2
#CUBEFACE_BACK = 3
#CUBEFACE_TOP = 4
#CUBEFACE_BOTTOM = 5

#CUBEMODE_SPECULAR = 1
#CUBEMODE_DIFFUSE = 2
#CUBEMODE_REFRACTION = 3

#BRUSHBLEND_NONE = 0
#BRUSHBLEND_ALPHA = 1
#BRUSHBLEND_MULTIPLY = 2
#BRUSHBLEND_ADD = 3

#BRUSHFX_NONE = 0
#BRUSHFX_FULLBRIGHT = 1
#BRUSHFX_VERTEXCOLOR = 2
#BRUSHFX_FLAT = 4
#BRUSHFX_NOFOG = 8
#BRUSHFX_DOUBLESIDED = 16
#BRUSHFX_VERTEXALPHA = 32

#COLLIDE_SPHERESPHERE = 1
#COLLIDE_SPHEREPOLY = 2
#COLLIDE_SPHEREBOX = 3

#COLLIDE_STOP = 1
#COLLIDE_SLIDE1 = 2
#COLLIDE_SLIDE2 = 3

#PICK_NONE = 0
#PICK_SPHERE = 1
#PICK_POLY = 2
#PICK_BOX = 3

#ANIM_STOP = 0
#ANIM_LOOP = 1
#ANIM_PINGPONG = 2
#ANIM_ONCE = 3

#SPRITE_TURNXY = 1
#SPRITE_STILL = 2
#SPRITE_ALIGNZ = 3
#SPRITE_TURNY = 4

#PLAYCD_SINGLE = 1
#PLAYCD_LOOP = 2
#PLAYCD_ALL = 3

#MOUSE_BUTTON = 1
#MOUSE_RIGHTBUTTON = 2
#MOUSE_MIDDLEBUTTON = 3

#JOYTYPE_NONE = 0
#JOYTYPE_DIGITAL = 1
#JOYTYPE_ANALOG = 2

#KEY_ESCAPE = 1
#KEY_TAB = 15
#KEY_SPACE = 57
#KEY_RETURN = 28
#KEY_LEFTSHIFT = 42
#KEY_LEFTCONTROL = 29
#KEY_LEFTALT = 56
#KEY_RIGHTSHIFT = 54
#KEY_RIGHTCONTROL = 157
#KEY_RIGHTALT = 184
 
#KEY_UP = 200
#KEY_LEFT = 203
#KEY_RIGHT = 205
#KEY_DOWN = 208
 
#KEY_F1 = 59
#KEY_F2 = 60
#KEY_F3 = 61
#KEY_F4 = 62
#KEY_F5 = 63
#KEY_F6 = 64
#KEY_F7 = 65
#KEY_F8 = 66
#KEY_F9 = 67
#KEY_F10 = 68

#KEY_Q = 16
#KEY_W = 17
#KEY_E = 18
#KEY_R = 19
#KEY_T = 20
#KEY_Y = 21
#KEY_U = 22
#KEY_I = 23
#KEY_O = 24
#KEY_P = 25
 
#KEY_A = 30
#KEY_S = 31
#KEY_D = 32
#KEY_F = 33
#KEY_G = 34
#KEY_H = 35
#KEY_J = 36
#KEY_K = 37
#KEY_L = 38
 
#KEY_Z = 44
#KEY_X = 45
#KEY_C = 46
#KEY_V = 47
#KEY_B = 48
#KEY_N = 49
#KEY_M = 50
 
#KEY_1 = 2
#KEY_2 = 3
#KEY_3 = 4
#KEY_4 = 5
#KEY_5 = 6
#KEY_6 = 7
#KEY_7 = 8
#KEY_8 = 9
#KEY_9 = 10
#KEY_0 = 11

#KEY_MINUS = 12
#KEY_EQUALS = 13
#KEY_BACKSPACE = 14
#KEY_LEFTBRACKET = 26
#KEY_RIGHTBRACKET = 27
#KEY_SEMICOLON = 39
#KEY_APOSTROPHE = 40
#KEY_GRAVE = 41
#KEY_BACKSLASH = 43
#KEY_COMMA = 51
#KEY_PERIOD = 52
#KEY_SLASH = 53
#KEY_CAPSLOCK = 58
 
#KEY_PRINT = 183
#KEY_SCROLLLOCK = 70
#KEY_PAUSEBREAK = 197
#KEY_INSERT = 210
#KEY_DELETE = 211
#KEY_HOME = 199
#KEY_END = 207
#KEY_PAGEUP = 201
#KEY_PAGEDOWN = 209

#KEY_NUMLOCK = 69
#KEY_NUMPADDIVIDE = 181
#KEY_NUMPADMULT = 55
#KEY_NUMPADMINUS = 74
#KEY_NUMPADPLUS = 78
#KEY_NUMPADENTER = 156
#KEY_NUMPADDOT = 83
#KEY_NUMPAD0 = 82
#KEY_NUMPAD1 = 79
#KEY_NUMPAD2 = 80
#KEY_NUMPAD3 = 81
#KEY_NUMPAD4 = 75
#KEY_NUMPAD5 = 76
#KEY_NUMPAD6 = 77
#KEY_NUMPAD7 = 71
#KEY_NUMPAD8 = 72
#KEY_NUMPAD9 = 73

#KEY_F11 = 87
#KEY_F12 = 88
#KEY_LEFTWINDOWS = 219
#KEY_RIGHTWINDOWS = 220
#KEY_NUMPADEQUALS = 141
#KEY_NUMPADCOMMA = 179
#KEY_OEM_102 = 86
#KEY_AT = 145
#KEY_COLON = 146
#KEY_UNDERLINE = 147
#KEY_BREAK = 149

#KEY_PREVIOUSTRACK = 144
#KEY_NEXTTRACK = 153
#KEY_MUTE = 160
#KEY_PLAYPAUSE = 162
#KEY_STOP = 164
#KEY_VOLUMELESS = 174
#KEY_VOLUMEMORE = 176
 
#KEY_APPS = 221
#KEY_POWER = 222
#KEY_SLEEP = 223
#KEY_WAKE = 227

#KEY_WEBHOME = 178
#KEY_WEBSEARCH = 229
#KEY_WEBFAVORITES = 230
#KEY_WEBREFRESH = 231
#KEY_WEBSTOP = 232
#KEY_WEBFORWARD = 233
#KEY_WEBBACK = 234
 
#KEY_MYCOMPUTER = 235
#KEY_CALCULATOR = 161
#KEY_MAIL = 236
#KEY_MEDIASELECT = 237

;typedef void * BBObject

Macro BBObject: l: EndMacro

Macro BBTimer: BBObject: EndMacro
Macro BBSound : BBObject: EndMacro
Macro BBChannel : BBObject: EndMacro

Macro _BBGraphics : BBObject: EndMacro
Macro BBImage: BBObject: EndMacro
Macro BBMovie: BBObject: EndMacro
Macro BBFont: BBObject: EndMacro
Macro BBCanvas: BBObject: EndMacro
Macro BBScene: BBObject: EndMacro

Macro BBLight: BBObject: EndMacro
Macro BBCamera: BBObject: EndMacro
Macro BBModel: BBObject: EndMacro
Macro BBEntity: BBObject: EndMacro
Macro BBSurface: BBObject: EndMacro
Macro BBTexture: BBObject: EndMacro
Macro BBBrush: BBObject: EndMacro
Macro BBPivot: BBObject: EndMacro
Macro BBSprite: BBObject: EndMacro
Macro BBPlaneModel: BBObject: EndMacro
Macro BBMeshModel: BBObject: EndMacro
Macro BBQ3BSPModel: BBObject: EndMacro
Macro BBMD2Model: BBObject: EndMacro
Macro BBMirror: BBObject: EndMacro
Macro BBTerrain: BBObject: EndMacro

;bbruntime

PrototypeC.l bbVersionProc ()

PrototypeC.l bbSetBlitz3DDebugModeProc (debugmode.l)
PrototypeC.l bbSetBlitz3DDebugCallbackProc (*callback)
PrototypeC.l bbSetBlitz3DEventCallbackProc (*callback)
PrototypeC.l bbSetBlitz3DHWNDProc (hwndparent.l)
PrototypeC.l bbSetBlitz3DTitleProc (title.s, close.s)

PrototypeC.l bbBeginBlitz3DProc ()
PrototypeC.l bbBeginBlitz3DExProc (hwnd.l,flags.l)
PrototypeC.l bbEndBlitz3DProc ()
PrototypeC.l bbValidateGraphicsProc ()

PrototypeC.l bbRuntimeErrorProc (error.s)

PrototypeC.l bbMilliSecsProc ()

PrototypeC.l bbDelayProc (ms.l)
PrototypeC.l bbShowPointerProc ()
PrototypeC.l bbHidePointerProc ()

PrototypeC.BBTimer bbCreateTimerProc (hz.l)
PrototypeC.l bbFreeTimerProc (timer.BBTimer)
PrototypeC.l bbWaitTimerProc (timer.BBTimer)

; bbinput

;keyboard

PrototypeC.l bbKeyDownProc (n.l)
PrototypeC.l bbKeyHitProc (n.l)
PrototypeC.l bbGetKeyProc ()
PrototypeC.l bbWaitKeyProc ()
PrototypeC.l bbFlushKeysProc ()

;mouse

PrototypeC.l bbMouseDownProc (n.l)
PrototypeC.l bbMouseHitProc (n.l)
PrototypeC.l bbGetMouseProc ()
PrototypeC.l bbWaitMouseProc ()
PrototypeC.l bbMouseXProc ()
PrototypeC.l bbMouseYProc ()
PrototypeC.l bbMouseZProc ()
PrototypeC.l bbMouseXSpeedProc ()
PrototypeC.l bbMouseYSpeedProc ()
PrototypeC.l bbMouseZSpeedProc ()
PrototypeC.l bbMoveMouseProc (x.l, y.l)
PrototypeC.l bbFlushMouseProc ()

;joysticks

PrototypeC.l bbJoyTypeProc (port.l=0)
PrototypeC.l bbJoyDownProc (n.l, port.l=0)
PrototypeC.l bbJoyHitProc (n.l, port.l=0)
PrototypeC.l bbGetJoyProc (port.l=0)
PrototypeC.l bbWaitJoyProc (port.l=0)
PrototypeC.f bbJoyXProc (port.l=0)
PrototypeC.f bbJoyYProc (port.l=0)
PrototypeC.f bbJoyZProc (port.l=0)
PrototypeC.f bbJoyUProc (port.l=0)
PrototypeC.f bbJoyVProc (port.l=0)
PrototypeC.f bbJoyPitchProc (port.l=0)
PrototypeC.f bbJoyYawProc (port.l=0)
PrototypeC.f bbJoyRollProc (port.l=0)
PrototypeC.l bbJoyHatProc (port.l=0)
PrototypeC.l bbJoyXDirProc (port.l=0)
PrototypeC.l bbJoyYDirProc (port.l=0)
PrototypeC.l bbJoyZDirProc (port.l=0)
PrototypeC.l bbJoyUDirProc (port.l=0)
PrototypeC.l bbJoyVDirProc (port.l=0)
PrototypeC.l bbFlushJoyProc ()

; bbaudio

PrototypeC.BBSound bbLoadSoundProc (src.s, flags.l=0)
PrototypeC.l bbFreeSoundProc (sound.BBSound)
PrototypeC.BBChannel bbPlaySoundProc (sound.BBSound)
PrototypeC.l bbLoopSoundProc (sound.BBSound)
PrototypeC.l bbSoundPitchProc (sound.BBSound, pitch.l)
PrototypeC.l bbSoundVolumeProc (sound.BBSound, volume.f)
PrototypeC.l bbSoundPanProc (sound.BBSound, pan.f)
PrototypeC.BBChannel bbPlayMusicProc (src.s, mode.l=1)
PrototypeC.BBChannel bbPlayCDTrackProc (track.l, mode.l=1)
PrototypeC.l bbStopChannelProc (channel.BBChannel)
PrototypeC.l bbPauseChannelProc (channel.BBChannel)
PrototypeC.l bbResumeChannelProc (channel.BBChannel)
PrototypeC.l bbChannelPitchProc (channel.BBChannel, pitch.l)
PrototypeC.l bbChannelVolumeProc (channel.BBChannel, volume.f)
PrototypeC.l bbChannelPanProc (channel.BBChannel, pan.f)
PrototypeC.l bbChannelPlayingProc (channel.BBChannel)

; bbgraphics

PrototypeC.l bbGraphics3DProc (w.l, h.l, d.l=0, mode.l=0)
PrototypeC.l bbCountGfxDriversProc ()
PrototypeC.l bbGfxDriverNameProc (n.l)
PrototypeC.l bbGfxDriver3DProc (n.l)

PrototypeC.l bbGfxDriverCaps3DProc ()

PrototypeC.l bbCountGfxModes3DProc ()
PrototypeC.l bbGfxMode3DExistsProc (w.l, h.l, d.l)
PrototypeC.l bbGfxMode3DProc (n.l)
PrototypeC.l bbWindowed3DProc ()

PrototypeC.l bbGfxDriverXProc (n.l)
PrototypeC.l bbGfxDriverYProc (n.l)
PrototypeC.l bbGfxDriverHzProc (n.l)

PrototypeC.l bbSetGfxDriverProc (n.l)
PrototypeC.l bbGfxModeExistsProc (w.l, h.l, d.l)
PrototypeC.l bbCountGfxModesProc ()

PrototypeC.l bbGfxModeWidthProc (n.l)
PrototypeC.l bbGfxModeHeightProc (n.l)
PrototypeC.l bbGfxModeDepthProc (n.l)

PrototypeC.l bbGraphicsWidthProc ()
PrototypeC.l bbGraphicsHeightProc ()
PrototypeC.l bbGraphicsDepthProc ()

PrototypeC.l bbAvailVidMemProc ()
PrototypeC.l bbTotalVidMemProc ()

;mode functions

PrototypeC.l bbGraphicsProc (w.l, h.l, d.l, mode.l)
PrototypeC.BBCanvas bbFrontBufferProc ()
PrototypeC.BBCanvas bbBackBufferProc ()
PrototypeC.l bbEndGraphicsProc ()
PrototypeC.l bbScanLineProc ()
PrototypeC.l bbVWaitProc (n.l)
PrototypeC.l bbFlipProc (vwait.l=1)

;graphics buffer functions

PrototypeC.l bbSetBufferProc (buff.BBCanvas)
PrototypeC.BBCanvas bbGraphicsBufferProc ()
PrototypeC.l bbLoadBufferProc (buff.BBCanvas, str.s)
PrototypeC.l bbSaveBufferProc (buff.BBCanvas, str.s)
PrototypeC.l bbBufferDirtyProc (buff.BBCanvas)

;fast read/write operations...

PrototypeC.l bbLockBufferProc (buff.BBCanvas)
PrototypeC.l bbUnlockBufferProc (buff.BBCanvas)
PrototypeC.l bbReadPixelProc (x.l, y.l, buff.BBCanvas)
PrototypeC.l bbWritePixelProc (x.l, y.l, argb.l, buff.BBCanvas)
PrototypeC.l bbReadPixelFastProc (x.l, y.l, buff.BBCanvas)
PrototypeC.l bbWritePixelFastProc (x.l, y.l, argb.l, buff.BBCanvas)
PrototypeC.l bbCopyPixelProc (src_x.l, src_y.l, src.BBCanvas, dest_x.l, dest_y.l, buff.BBCanvas)
PrototypeC.l bbCopyPixelFastProc (src_x.l, src_y.l, src.BBCanvas, dest_x.l, dest_y.l, buff.BBCanvas)

;2d rendering functions

PrototypeC.l bbOriginProc (x.l, y.l)
PrototypeC.l bbViewportProc (x.l, y.l, w.l, h.l)
PrototypeC.l bbColorProc (r.l, g.l, b.l)
PrototypeC.l bbClsColorProc (r.l, g.l, b.l)
PrototypeC.l bbClsProc ()
PrototypeC.l bbPlotProc (x.l, y.l)
PrototypeC.l bbLineProc (x1.l, y1.l, x2.l, y2.l)
PrototypeC.l bbRectProc (x.l, y.l, w.l, h.l, solid.l=1)
PrototypeC.l bbOvalProc (x.l, y.l, w.l, h.l, solid.l=1)
PrototypeC.l bbTextProc (x.l, y.l, t.s, centre_x.l=0, centre_y.l=0)
PrototypeC.l bbCopyRectProc (sx.l, sy.l, w.l, h.l, dx.l, dy.l, src.BBCanvas, dest.BBCanvas)
PrototypeC.l bbGetColorProc (x.l, y.l)
PrototypeC.l bbColorRedProc ()
PrototypeC.l bbColorGreenProc ()
PrototypeC.l bbColorBlueProc ()

;font functions

PrototypeC.BBFont bbLoadFontProc (name.s, height.l, bold.l, italic.l, underline.l)
PrototypeC.l bbFreeFontProc (f.BBFont)
PrototypeC.l bbSetFontProc (f.BBFont)
PrototypeC.l bbFontWidthProc ()
PrototypeC.l bbFontHeightProc ()
PrototypeC.l bbStringWidthProc (str.s)
PrototypeC.l bbStringHeightProc (str.s)

;image functions

PrototypeC.BBImage bbLoadImageProc (s.s)
PrototypeC.BBImage bbCopyImageProc (sourceimage.BBImage)
PrototypeC.BBImage bbCreateImageProc (w.l, h.l, n.l)
PrototypeC.BBImage bbLoadAnimImageProc (s.s, w.l, h.l, first.l, cnt.l)
PrototypeC.l bbFreeImageProc (i.BBImage)
PrototypeC.l bbSaveImageProc (i.BBImage, filename.s, frame.l)
PrototypeC.l bbGrabImageProc (i.BBImage, x.l, y.l, n.l)
PrototypeC.BBCanvas bbImageBufferProc (i.BBImage, n.l)
PrototypeC.l bbDrawImageProc (i.BBImage, x.l, y.l, frame.l)
PrototypeC.l bbDrawBlockProc (i.BBImage, x.l, y.l, frame.l)
PrototypeC.l bbTileImageProc (i.BBImage, x.l, y.l, frame.l)
PrototypeC.l bbTileBlockProc (i.BBImage, x.l, y.l, frame.l)
PrototypeC.l bbDrawImageRectProc (i.BBImage, x.l, y.l, r_x.l, r_y.l, r_w.l, r_h.l, frame.l)
PrototypeC.l bbDrawBlockRectProc (i.BBImage, x.l, y.l, r_x.l, r_y.l, r_w.l, r_h.l, frame.l)
PrototypeC.l bbMaskImageProc (i.BBImage, r.l, g.l, b.l)
PrototypeC.l bbHandleImageProc (i.BBImage, x.l, y.l)
PrototypeC.l bbScaleImageProc (i.BBImage, w.f, h.f)
PrototypeC.l bbResizeImageProc (i.BBImage, w.f, h.f)
PrototypeC.l bbRotateImageProc (i.BBImage, angle.f)
PrototypeC.l bbTFormImageProc (i.BBImage, a.f, b.f, c.f, d.f)
PrototypeC.l bbTFormFilterProc (enable.l)
PrototypeC.l bbAutoMidHandleProc (enable.l)
PrototypeC.l bbMidHandleProc (i.BBImage)
PrototypeC.l bbImageWidthProc (i.BBImage)
PrototypeC.l bbImageHeightProc (i.BBImage)
PrototypeC.l bbImageXHandleProc (i.BBImage)
PrototypeC.l bbImageYHandleProc (i.BBImage)
PrototypeC.l bbImagesOverlapProc (i1.BBImage, x1.l, y1.l, i2.BBImage, x2.l, y2.l)
PrototypeC.l bbImagesCollideProc (i1.BBImage, x1.l, y1.l, f1.l, i2.BBImage, x2.l, y2.l, f2.l)
PrototypeC.l bbRectsOverlapProc (x1.l, y1.l, w1.l, h1.l, x2.l, y2.l, w2.l, h2.l)
PrototypeC.l bbImageRectOverlapProc (i.BBImage, x.l, y.l, r_x.l, r_y.l, r_w.l, r_h.l)
PrototypeC.l bbImageRectCollideProc (i.BBImage, x.l, y.l, f.l, r_x.l, r_y.l, r_w.l, r_h.l)

PrototypeC.l bbWriteProc (str.s)
PrototypeC.l bbPrintProc (str.s)
PrototypeC.l bbInputProc (prompt.s)
PrototypeC.l bbLocateProc (x.l, y.l)

; movie commands

PrototypeC.BBMovie bbOpenMovieProc (s.s)
PrototypeC.l bbDrawMovieProc (movie.BBMovie, x.l, y.l, w.l, h.l)
PrototypeC.l bbMovieWidthProc (movie.BBMovie)
PrototypeC.l bbMovieHeightProc (movie.BBMovie)
PrototypeC.l bbMoviePlayingProc (movie.BBMovie)
PrototypeC.l bbCloseMovieProc (movie.BBMovie)

; gamma commands

PrototypeC.l bbSetGammaProc (r.l, g.l, b.l, dr.f, dg.f, db.f)
PrototypeC.l bbUpdateGammaProc (calibrate.l)
PrototypeC.f bbGammaRedProc (n.l)
PrototypeC.f bbGammaGreenProc (n.l)
PrototypeC.f bbGammaBlueProc (n.l)

; bbgraphics3d

; global world commands 

PrototypeC.l bbLoaderMatrixProc (ext.s, xx.f, xy.f, xz.f, yx.f, yy.f, yz.f, zx.f, zy.f, zz.f)
PrototypeC.l bbHWTexUnitsProc ()

PrototypeC.l bbHWMultiTexProc (enable.l)
PrototypeC.l bbWBufferProc (enable.l)
PrototypeC.l bbDitherProc (enable.l)
PrototypeC.l bbAntiAliasProc (enable.l)
PrototypeC.l bbWireFrameProc (enable.l)
PrototypeC.l bbAmbientLightProc (r.f, g.f, b.f)
PrototypeC.l bbClearCollisionsProc ()

PrototypeC.l bbCollisionsProc (src_type.l, dest_type.l, method.l, response.l)

PrototypeC.l bbUpdateWorldProc (elapsed.f=1.0)
PrototypeC.l bbCaptureWorldProc ()
PrototypeC.l bbRenderWorldProc (tween.f=1.0)
PrototypeC.l bbTrisRenderedProc ()
PrototypeC.f bbStats3DProc (n.l)

; texture commands

PrototypeC.BBTexture bbLoadTextureProc (file.s, flags.l=1)
PrototypeC.BBTexture bbLoadAnimTextureProc (file.s, flags.l, w.l, h.l, first.l, cnt.l)
PrototypeC.BBTexture bbCreateTextureProc (w.l, h.l, flags.l=0, frames.l=1)
PrototypeC.l bbFreeTextureProc (t.BBTexture)
PrototypeC.l bbTextureBlendProc (t.BBTexture, blend.l)
PrototypeC.l bbTextureCoordsProc (t.BBTexture, flags.l)
PrototypeC.l bbScaleTextureProc (t.BBTexture, u_scale.f, v_scale.f)
PrototypeC.l bbRotateTextureProc (t.BBTexture, angle.f)
PrototypeC.l bbPositionTextureProc (t.BBTexture, u_pos.f, v_pos.f)
PrototypeC.l bbTextureWidthProc (t.BBTexture)
PrototypeC.l bbTextureHeightProc (t.BBTexture)

PrototypeC.l bbTextureNameProc (t.BBTexture)
PrototypeC.l bbSetCubeFaceProc (t.BBTexture, face.l)
PrototypeC.l bbSetCubeModeProc (t.BBTexture, mode.l)
PrototypeC.BBCanvas bbTextureBufferProc (t.BBTexture, frame.l=0)
PrototypeC.l bbClearTextureFiltersProc ()
PrototypeC.l bbTextureFilterProc (t.s, flags.l)

; brush commands

PrototypeC.BBBrush bbCreateBrushProc (r.f=255.0, g.f=255.0, b.f=255.0)
PrototypeC.BBBrush bbLoadBrushProc (file.s, flags.l=1, u_scale.f=1.0, v_scale.f=1.0)

PrototypeC.l bbFreeBrushProc (b.BBBrush)
PrototypeC.l bbBrushColorProc (br.BBBrush, r.f, g.f, b.f)
PrototypeC.l bbBrushAlphaProc (b.BBBrush, alpha.f)
PrototypeC.l bbBrushShininessProc (b.BBBrush, n.f)
PrototypeC.l bbBrushTextureProc (b.BBBrush, t.BBTexture, frame.l=0, index.l=0)
PrototypeC.BBTexture bbGetBrushTextureProc (b.BBBrush, index.l=0)
PrototypeC.l bbBrushBlendProc (b.BBBrush, blend.l)
PrototypeC.l bbBrushFXProc (b.BBBrush, fx.l)

; mesh commands

PrototypeC.BBModel bbCreateMeshProc (p.BBEntity=0)
PrototypeC.BBModel bbLoadMeshProc (f.s, p.BBEntity=0)
PrototypeC.BBModel bbLoadAnimMeshProc (f.s, p.BBEntity=0)
PrototypeC.BBModel bbCreateCubeProc (p.BBEntity=0)
PrototypeC.BBModel bbCreateSphereProc (segs.l=8, p.BBEntity=0)
PrototypeC.BBModel bbCreateCylinderProc (segs.l=8, solid.l=1, p.BBEntity=0)
PrototypeC.BBModel bbCreateConeProc (segs.l=8, solid.l=1, p.BBEntity=0)
PrototypeC.BBModel bbCopyMeshProc (m.BBModel, p.BBEntity=0)
PrototypeC.l bbScaleMeshProc (m.BBModel, x.f, y.f, z.f)
PrototypeC.l bbRotateMeshProc (m.BBModel, x.f, y.f, z.f)
PrototypeC.l bbPositionMeshProc (m.BBModel, x.f, y.f, z.f)
PrototypeC.l bbFitMeshProc (m.BBModel, x.f, y.f, z.f, w.f, h.f, d.f, uniform.l=0)
PrototypeC.l bbFlipMeshProc (m.BBModel)
PrototypeC.l bbPaintMeshProc (m.BBModel, b.BBBrush)
PrototypeC.l bbAddMeshProc (src.BBModel, dest.BBModel)
PrototypeC.l bbUpdateNormalsProc (m.BBModel)
PrototypeC.l bbLightMeshProc (m.BBModel, r.f, g.f, b.f, range.f, x.f, y.f, z.f)
PrototypeC.f bbMeshWidthProc (m.BBModel)
PrototypeC.f bbMeshHeightProc (m.BBModel)
PrototypeC.f bbMeshDepthProc (m.BBModel)
PrototypeC.l bbMeshesIntersectProc (a.BBModel, b.BBModel)
PrototypeC.l bbCountSurfacesProc (m.BBModel)
PrototypeC.BBSurface bbGetSurfaceProc (m.BBModel, index.l)
PrototypeC.l bbMeshCullBoxProc (m.BBModel, x.f, y.f, z.f, w.f, h.f, d.f)

; surface commands

PrototypeC.BBSurface bbFindSurfaceProc (m.BBModel, b.BBBrush)
PrototypeC.BBSurface bbCreateSurfaceProc (m.BBModel, b.BBBrush=0)
PrototypeC.BBBrush bbGetSurfaceBrushProc (s.BBSurface)
PrototypeC.BBBrush bbGetEntityBrushProc (m.BBModel)

PrototypeC.l bbClearSurfaceProc (s.BBSurface, verts.l, tris.l)
PrototypeC.l bbPaintSurfaceProc (s.BBSurface, b.BBBrush)
PrototypeC.l bbAddVertexProc (s.BBSurface, x.f, y.f, z.f, tu.f=0.0, tv.f=0.0, tw.f=0.0)
PrototypeC.l bbAddTriangleProc (s.BBSurface, v0.l, v1.l, v2.l)
PrototypeC.l bbVertexCoordsProc (s.BBSurface, n.l, x.f, y.f, z.f)
PrototypeC.l bbVertexNormalProc (s.BBSurface, n.l, x.f, y.f, z.f)

PrototypeC.l bbVertexColorProc (s.BBSurface, n.l, r.f, g.f, b.f, a.f)
PrototypeC.l bbVertexTexCoordsProc (s.BBSurface, n.l, u.f, v.f, w.f, set.l)
PrototypeC.l bbCountVerticesProc (s.BBSurface)
PrototypeC.l bbCountTrianglesProc (s.BBSurface)
PrototypeC.f bbVertexXProc (s.BBSurface, n.l)
PrototypeC.f bbVertexYProc (s.BBSurface, n.l)
PrototypeC.f bbVertexZProc (s.BBSurface, n.l)
PrototypeC.f bbVertexNXProc (s.BBSurface, n.l)
PrototypeC.f bbVertexNYProc (s.BBSurface, n.l)
PrototypeC.f bbVertexNZProc (s.BBSurface, n.l)
PrototypeC.f bbVertexRedProc (s.BBSurface, n.l)
PrototypeC.f bbVertexGreenProc (s.BBSurface, n.l)
PrototypeC.f bbVertexBlueProc (s.BBSurface, n.l)
PrototypeC.f bbVertexAlphaProc (s.BBSurface, n.l)
PrototypeC.f bbVertexUProc (s.BBSurface, n.l, t.l)
PrototypeC.f bbVertexVProc (s.BBSurface, n.l, t.l)
PrototypeC.f bbVertexWProc (s.BBSurface, n.l, t.l)
PrototypeC.l bbTriangleVertexProc (s.BBSurface, n.l, v.l)

; camera commands

PrototypeC.BBCamera bbCreateCameraProc (p.BBEntity=0)
PrototypeC.l bbCameraZoomProc (c.BBCamera, zoom.f)
PrototypeC.l bbCameraRangeProc (c.BBCamera, nr.f, fr.f)
PrototypeC.l bbCameraClsColorProc (c.BBCamera, r.f, g.f, b.f)
PrototypeC.l bbCameraClsModeProc (c.BBCamera, cls_color.l, cls_zbuffer.l)
PrototypeC.l bbCameraProjModeProc (c.BBCamera, mode.l)
PrototypeC.l bbCameraViewportProc (c.BBCamera, x.l, y.l, w.l, h.l)
PrototypeC.l bbCameraFogRangeProc (c.BBCamera, nr.f, fr.f)
PrototypeC.l bbCameraFogColorProc (c.BBCamera, r.f, g.f, b.f)
PrototypeC.l bbCameraFogModeProc (c.BBCamera, mode.l)
PrototypeC.l bbCameraProjectProc (c.BBCamera, x.f, y.f, z.f)
PrototypeC.f bbProjectedXProc ()
PrototypeC.f bbProjectedYProc ()
PrototypeC.f bbProjectedZProc ()
PrototypeC.BBEntity bbCameraPickProc (c.BBCamera, x.f, y.f)
PrototypeC.BBEntity bbLinePickProc (x.f, y.f, z.f, dx.f, dy.f, dz.f, radius.f)
PrototypeC.BBEntity bbEntityPickProc (src.BBObject, range.f)
PrototypeC.l bbEntityVisibleProc (src.BBObject, dest.BBObject)
PrototypeC.l bbEntityInViewProc (e.BBEntity, c.BBCamera)
PrototypeC.f bbPickedXProc ()
PrototypeC.f bbPickedYProc ()
PrototypeC.f bbPickedZProc ()
PrototypeC.f bbPickedNXProc ()
PrototypeC.f bbPickedNYProc ()
PrototypeC.f bbPickedNZProc ()
PrototypeC.f bbPickedTimeProc ()
PrototypeC.BBObject bbPickedEntityProc ()
PrototypeC.BBSurface bbPickedSurfaceProc ()
PrototypeC.l bbPickedTriangleProc ()

; light commands

PrototypeC.BBLight bbCreateLightProc (type.l=0, p.BBEntity=0)
PrototypeC.l bbLightColorProc (light.BBLight, r.f, g.f, b.f)
PrototypeC.l bbLightRangeProc (light.BBLight, range.f)
PrototypeC.l bbLightConeAnglesProc (light.BBLight, inner.f, outer.f)

; pivot commands

PrototypeC.BBPivot bbCreatePivotProc (p.BBEntity=0)

; sprite commands

PrototypeC.BBSprite bbCreateSpriteProc (p.BBEntity=0)
PrototypeC.BBSprite bbLoadSpriteProc (file.s, texture_flags.l=1, p.BBEntity=0)
PrototypeC.l bbRotateSpriteProc (s.BBSprite, angle.f)
PrototypeC.l bbScaleSpriteProc (s.BBSprite, x.f, y.f)
PrototypeC.l bbHandleSpriteProc (s.BBSprite, x.f, y.f)
PrototypeC.l bbSpriteViewModeProc (s.BBSprite, mode.l)

; mirror commands

PrototypeC.BBMirror bbCreateMirrorProc (p.BBEntity=0)

; plane commands

PrototypeC.BBPlaneModel bbCreatePlaneProc (segs.l=1, p.BBEntity=0)

; md2 commands

PrototypeC.BBMD2Model bbLoadMD2Proc (file.s, p.BBEntity=0)
PrototypeC.l bbAnimateMD2Proc (m.BBMD2Model, mode.l=1, speed.f=1.0, first.l=0, last.l=9999, trans.f=0.0)
PrototypeC.f bbMD2AnimTimeProc (m.BBMD2Model)
PrototypeC.l bbMD2AnimLengthProc (m.BBMD2Model)
PrototypeC.l bbMD2AnimatingProc (m.BBMD2Model)

; bsp commands

PrototypeC.BBQ3BSPModel bbLoadBSPProc (file.s, gam.f, p.BBEntity=0)
PrototypeC.l bbBSPAmbientLightProc (t.BBQ3BSPModel, r.f, g.f, b.f)
PrototypeC.l bbBSPLightingProc (t.BBQ3BSPModel, lmap.l)

; terrain commands

PrototypeC.BBTerrain bbCreateTerrainProc (n.l, p.BBEntity=0)
PrototypeC.BBTerrain bbLoadTerrainProc (file.s, p.BBEntity=0)
PrototypeC.l bbTerrainDetailProc (t.BBTerrain, n.l, m.l)
PrototypeC.l bbTerrainShadingProc (t.BBTerrain, enable.l)
PrototypeC.f bbTerrainXProc (t.BBTerrain, x.f, y.f, z.f)
PrototypeC.f bbTerrainYProc (t.BBTerrain, x.f, y.f, z.f)
PrototypeC.f bbTerrainZProc (t.BBTerrain, x.f, y.f, z.f)
PrototypeC.l bbTerrainSizeProc (t.BBTerrain)
PrototypeC.f bbTerrainHeightProc (t.BBTerrain, x.l, z.l)
PrototypeC.l bbModifyTerrainProc (t.BBTerrain, x.l, z.l, h.f, realtime.l)

; audio commands

PrototypeC.BBEntity bbCreateListenerProc (p.BBEntity=0, roll.f=1.0, dopp.f=1.0, dist.f=1.0)
PrototypeC.BBChannel bbEmitSoundProc (sound.BBSound, o.BBObject)

; entity commands

PrototypeC.BBEntity bbCopyEntityProc (e.BBEntity, p.BBEntity=0)
PrototypeC.l bbFreeEntityProc (e.BBEntity)
PrototypeC.l bbHideEntityProc (e.BBEntity)
PrototypeC.l bbShowEntityProc (e.BBEntity)
PrototypeC.l bbEntityParentProc (e.BBEntity, p.BBEntity=0, _global.l=1)
PrototypeC.l bbCountChildrenProc (e.BBEntity)
PrototypeC.BBEntity bbGetChildProc (e.BBEntity, index.l)
PrototypeC.BBEntity bbFindChildProc (e.BBEntity, t.s)

; animation commands

PrototypeC.l bbLoadAnimSeqProc (o.BBObject, f.s)
PrototypeC.l bbSetAnimTimeProc (o.BBObject, time.f, seq.l)
PrototypeC.l bbAnimateProc (o.BBObject, mode.l=1, speed.f=1.0, seq.l=0, trans.f=0.0)

PrototypeC.l bbSetAnimKeyProc (o.BBObject, frame.l, pos_key.l=1, rot_key.l=1, scl_key.l=1)
PrototypeC.l bbExtractAnimSeqProc (o.BBObject, first.l, last.l, seq.l)
PrototypeC.l bbAddAnimSeqProc (o.BBObject, length.l)
PrototypeC.l bbAnimSeqProc (o.BBObject)
PrototypeC.f bbAnimTimeProc (o.BBObject)
PrototypeC.l bbAnimLengthProc (o.BBObject)
PrototypeC.l bbAnimatingProc (o.BBObject)

; entity special fx commands

PrototypeC.l bbPaintEntityProc (e.BBEntity, b.BBBrush)
PrototypeC.l bbEntityColorProc (m.BBModel, r.f, g.f, b.f)
PrototypeC.l bbEntityAlphaProc (m.BBModel, alpha.f)
PrototypeC.l bbEntityShininessProc (m.BBModel, shininess.f)
PrototypeC.l bbEntityTextureProc (m.BBModel, t.BBTexture, frame.l=0, index.l=0)
PrototypeC.l bbEntityBlendProc (m.BBModel, blend.l)
PrototypeC.l bbEntityFXProc (m.BBModel, fx.l)
PrototypeC.l bbEntityAutoFadeProc (m.BBModel, nr.f, fr.f)
PrototypeC.l bbEntityOrderProc (o.BBObject, n.l)

; entity property commands

PrototypeC.f bbEntityXProc (e.BBEntity, _global.l=0)
PrototypeC.f bbEntityYProc (e.BBEntity, _global.l=0)
PrototypeC.f bbEntityZProc (e.BBEntity, _global.l=0)
PrototypeC.f bbEntityPitchProc (e.BBEntity, _global.l=0)
PrototypeC.f bbEntityYawProc (e.BBEntity, _global.l=0)
PrototypeC.f bbEntityRollProc (e.BBEntity, _global.l=0)
PrototypeC.f bbGetMatElementProc (e.BBEntity, row.l, col.l)
PrototypeC.l bbTFormPointProc (x.f, y.f, z.f, src.BBEntity, dest.BBEntity)
PrototypeC.l bbTFormVectorProc (x.f, y.f, z.f, src.BBEntity, dest.BBEntity)
PrototypeC.l bbTFormNormalProc (x.f, y.f, z.f, src.BBEntity, dest.BBEntity)
PrototypeC.f bbTFormedXProc ()
PrototypeC.f bbTFormedYProc ()
PrototypeC.f bbTFormedZProc ()
PrototypeC.f bbVectorYawProc (x.f, y.f, z.f)
PrototypeC.f bbVectorPitchProc (x.f, y.f, z.f)
PrototypeC.f bbDeltaYawProc (src.BBEntity, dest.BBEntity)
PrototypeC.f bbDeltaPitchProc (src.BBEntity, dest.BBEntity)

; entity collision commands

PrototypeC.l bbResetEntityProc (o.BBObject)
PrototypeC.l bbCaptureEntityProc (o.BBObject)
PrototypeC.l bbEntityTypeProc (o.BBObject, type.l, recurs.l=0)
PrototypeC.l bbEntityPickModeProc (o.BBObject, mode.l, obs.l)
PrototypeC.BBEntity bbGetParentProc (e.BBEntity)
PrototypeC.l bbGetEntityTypeProc (o.BBObject)
PrototypeC.l bbEntityRadiusProc (o.BBObject, x_radius.f, y_radius.f=0.0)
PrototypeC.l bbEntityBoxProc (o.BBObject, x.f, y.f, z.f, w.f, h.f, d.f)
PrototypeC.BBObject bbEntityCollidedProc (o.BBObject, type.l)
PrototypeC.l bbCountCollisionsProc (o.BBObject)
PrototypeC.f bbCollisionXProc (o.BBObject, index.l)
PrototypeC.f bbCollisionYProc (o.BBObject, index.l)
PrototypeC.f bbCollisionZProc (o.BBObject, index.l)
PrototypeC.f bbCollisionNXProc (o.BBObject, index.l)
PrototypeC.f bbCollisionNYProc (o.BBObject, index.l)
PrototypeC.f bbCollisionNZProc (o.BBObject, index.l)
PrototypeC.f bbCollisionTimeProc (o.BBObject, index.l)
PrototypeC.BBObject bbCollisionEntityProc (o.BBObject, index.l)
PrototypeC.BBSurface bbCollisionSurfaceProc (o.BBObject, index.l)
PrototypeC.l bbCollisionTriangleProc (o.BBObject, index.l)
PrototypeC.f bbEntityDistanceProc (src.BBEntity, dest.BBEntity)

; entity transformation commands

PrototypeC.l bbMoveEntityProc (e.BBEntity, x.f, y.f, z.f)
PrototypeC.l bbTurnEntityProc (e.BBEntity, p.f, y.f, r.f, _global.l=0)
PrototypeC.l bbTranslateEntityProc (e.BBEntity, x.f, y.f, z.f, _global.l=0)
PrototypeC.l bbPositionEntityProc (e.BBEntity, x.f, y.f, z.f, _global.l=0)
PrototypeC.l bbScaleEntityProc (e.BBEntity, x.f, y.f, z.f, _global.l=0)
PrototypeC.l bbRotateEntityProc (e.BBEntity, p.f, y.f, r.f, _global.l=0)
PrototypeC.l bbPointEntityProc (e.BBEntity, t.BBEntity, roll.f=0)
PrototypeC.l bbAlignToVectorProc (e.BBEntity, nx.f, ny.f, nz.f, axis.l, rate.f)

; entity misc commands

PrototypeC.l bbNameEntityProc (e.BBEntity, t.s)
PrototypeC.l bbEntityNameProc (e.BBEntity)
PrototypeC.l bbEntityClassProc (e.BBEntity)
PrototypeC.l bbClearWorldProc (e.l, b.l, t.l)
PrototypeC.l bbSetEntityIDProc (*e.BBEntity, id.l)
PrototypeC.l bbEntityIDProc (*e.BBEntity)

PrototypeC.l bbActiveTexturesProc ()

; Prototypes...

Global bbVersion.bbVersionProc
Global bbSetBlitz3DDebugMode.bbSetBlitz3DDebugModeProc
Global bbSetBlitz3DDebugCallback.bbSetBlitz3DDebugCallbackProc
Global bbSetBlitz3DEventCallback.bbSetBlitz3DEventCallbackProc
Global bbSetBlitz3DHWND.bbSetBlitz3DHWNDProc
Global bbSetBlitz3DTitle.bbSetBlitz3DTitleProc
Global bbBeginBlitz3D.bbBeginBlitz3DProc
Global bbBeginBlitz3DEx.bbBeginBlitz3DExProc
Global bbEndBlitz3D.bbEndBlitz3DProc
Global bbValidateGraphics.bbValidateGraphicsProc
Global bbRuntimeError.bbRuntimeErrorProc
Global bbMilliSecs.bbMilliSecsProc
Global bbDelay.bbDelayProc
Global bbShowPointer.bbShowPointerProc
Global bbHidePointer.bbHidePointerProc
Global bbCreateTimer.bbCreateTimerProc
Global bbFreeTimer.bbFreeTimerProc
Global bbWaitTimer.bbWaitTimerProc
Global bbKeyDown.bbKeyDownProc
Global bbKeyHit.bbKeyHitProc
Global bbGetKey.bbGetKeyProc
Global bbWaitKey.bbWaitKeyProc
Global bbFlushKeys.bbFlushKeysProc
Global bbMouseDown.bbMouseDownProc
Global bbMouseHit.bbMouseHitProc
Global bbGetMouse.bbGetMouseProc
Global bbWaitMouse.bbWaitMouseProc
Global bbMouseX.bbMouseXProc
Global bbMouseY.bbMouseYProc
Global bbMouseZ.bbMouseZProc
Global bbMouseXSpeed.bbMouseXSpeedProc
Global bbMouseYSpeed.bbMouseYSpeedProc
Global bbMouseZSpeed.bbMouseZSpeedProc
Global bbMoveMouse.bbMoveMouseProc
Global bbFlushMouse.bbFlushMouseProc
Global bbJoyType.bbJoyTypeProc
Global bbJoyDown.bbJoyDownProc
Global bbJoyHit.bbJoyHitProc
Global bbGetJoy.bbGetJoyProc
Global bbWaitJoy.bbWaitJoyProc
Global bbJoyX.bbJoyXProc
Global bbJoyY.bbJoyYProc
Global bbJoyZ.bbJoyZProc
Global bbJoyU.bbJoyUProc
Global bbJoyV.bbJoyVProc
Global bbJoyPitch.bbJoyPitchProc
Global bbJoyYaw.bbJoyYawProc
Global bbJoyRoll.bbJoyRollProc
Global bbJoyHat.bbJoyHatProc
Global bbJoyXDir.bbJoyXDirProc
Global bbJoyYDir.bbJoyYDirProc
Global bbJoyZDir.bbJoyZDirProc
Global bbJoyUDir.bbJoyUDirProc
Global bbJoyVDir.bbJoyVDirProc
Global bbFlushJoy.bbFlushJoyProc
Global bbLoadSound.bbLoadSoundProc
Global bbFreeSound.bbFreeSoundProc
Global bbPlaySound.bbPlaySoundProc
Global bbLoopSound.bbLoopSoundProc
Global bbSoundPitch.bbSoundPitchProc
Global bbSoundVolume.bbSoundVolumeProc
Global bbSoundPan.bbSoundPanProc
Global bbPlayMusic.bbPlayMusicProc
Global bbPlayCDTrack.bbPlayCDTrackProc
Global bbStopChannel.bbStopChannelProc
Global bbPauseChannel.bbPauseChannelProc
Global bbResumeChannel.bbResumeChannelProc
Global bbChannelPitch.bbChannelPitchProc
Global bbChannelVolume.bbChannelVolumeProc
Global bbChannelPan.bbChannelPanProc
Global bbChannelPlaying.bbChannelPlayingProc
Global bbGraphics3D.bbGraphics3DProc
Global bbCountGfxDrivers.bbCountGfxDriversProc
Global bbGfxDriverName.bbGfxDriverNameProc
Global bbGfxDriver3D.bbGfxDriver3DProc
Global bbGfxDriverCaps3D.bbGfxDriverCaps3DProc
Global bbCountGfxModes3D.bbCountGfxModes3DProc
Global bbGfxMode3DExists.bbGfxMode3DExistsProc
Global bbGfxMode3D.bbGfxMode3DProc
Global bbWindowed3D.bbWindowed3DProc
Global bbGfxDriverX.bbGfxDriverXProc
Global bbGfxDriverY.bbGfxDriverYProc
Global bbGfxDriverHz.bbGfxDriverHzProc
Global bbSetGfxDriver.bbSetGfxDriverProc
Global bbGfxModeExists.bbGfxModeExistsProc
Global bbCountGfxModes.bbCountGfxModesProc
Global bbGfxModeWidth.bbGfxModeWidthProc
Global bbGfxModeHeight.bbGfxModeHeightProc
Global bbGfxModeDepth.bbGfxModeDepthProc
Global bbGraphicsWidth.bbGraphicsWidthProc
Global bbGraphicsHeight.bbGraphicsHeightProc
Global bbGraphicsDepth.bbGraphicsDepthProc
Global bbAvailVidMem.bbAvailVidMemProc
Global bbTotalVidMem.bbTotalVidMemProc
Global bbGraphics.bbGraphicsProc
Global bbFrontBuffer.bbFrontBufferProc
Global bbBackBuffer.bbBackBufferProc
Global bbEndGraphics.bbEndGraphicsProc
Global bbScanLine.bbScanLineProc
Global bbVWait.bbVWaitProc
Global bbFlip.bbFlipProc
Global bbSetBuffer.bbSetBufferProc
Global bbGraphicsBuffer.bbGraphicsBufferProc
Global bbLoadBuffer.bbLoadBufferProc
Global bbSaveBuffer.bbSaveBufferProc
Global bbBufferDirty.bbBufferDirtyProc
Global bbLockBuffer.bbLockBufferProc
Global bbUnlockBuffer.bbUnlockBufferProc
Global bbReadPixel.bbReadPixelProc
Global bbWritePixel.bbWritePixelProc
Global bbReadPixelFast.bbReadPixelFastProc
Global bbWritePixelFast.bbWritePixelFastProc
Global bbCopyPixel.bbCopyPixelProc
Global bbCopyPixelFast.bbCopyPixelFastProc
Global bbOrigin.bbOriginProc
Global bbViewport.bbViewportProc
Global bbColor.bbColorProc
Global bbClsColor.bbClsColorProc
Global bbCls.bbClsProc
Global bbPlot.bbPlotProc
Global bbLine.bbLineProc
Global bbRect.bbRectProc
Global bbOval.bbOvalProc
Global bbText.bbTextProc
Global bbCopyRect.bbCopyRectProc
Global bbGetColor.bbGetColorProc
Global bbColorRed.bbColorRedProc
Global bbColorGreen.bbColorGreenProc
Global bbColorBlue.bbColorBlueProc
Global bbLoadFont.bbLoadFontProc
Global bbFreeFont.bbFreeFontProc
Global bbSetFont.bbSetFontProc
Global bbFontWidth.bbFontWidthProc
Global bbFontHeight.bbFontHeightProc
Global bbStringWidth.bbStringWidthProc
Global bbStringHeight.bbStringHeightProc
Global bbLoadImage.bbLoadImageProc
Global bbCopyImage.bbCopyImageProc
Global bbCreateImage.bbCreateImageProc
Global bbLoadAnimImage.bbLoadAnimImageProc
Global bbFreeImage.bbFreeImageProc
Global bbSaveImage.bbSaveImageProc
Global bbGrabImage.bbGrabImageProc
Global bbImageBuffer.bbImageBufferProc
Global bbDrawImage.bbDrawImageProc
Global bbDrawBlock.bbDrawBlockProc
Global bbTileImage.bbTileImageProc
Global bbTileBlock.bbTileBlockProc
Global bbDrawImageRect.bbDrawImageRectProc
Global bbDrawBlockRect.bbDrawBlockRectProc
Global bbMaskImage.bbMaskImageProc
Global bbHandleImage.bbHandleImageProc
Global bbScaleImage.bbScaleImageProc
Global bbResizeImage.bbResizeImageProc
Global bbRotateImage.bbRotateImageProc
Global bbTFormImage.bbTFormImageProc
Global bbTFormFilter.bbTFormFilterProc
Global bbAutoMidHandle.bbAutoMidHandleProc
Global bbMidHandle.bbMidHandleProc
Global bbImageWidth.bbImageWidthProc
Global bbImageHeight.bbImageHeightProc
Global bbImageXHandle.bbImageXHandleProc
Global bbImageYHandle.bbImageYHandleProc
Global bbImagesOverlap.bbImagesOverlapProc
Global bbImagesCollide.bbImagesCollideProc
Global bbRectsOverlap.bbRectsOverlapProc
Global bbImageRectOverlap.bbImageRectOverlapProc
Global bbImageRectCollide.bbImageRectCollideProc
Global bbWrite.bbWriteProc
Global bbPrint.bbPrintProc
Global bbInput.bbInputProc
Global bbLocate.bbLocateProc
Global bbOpenMovie.bbOpenMovieProc
Global bbDrawMovie.bbDrawMovieProc
Global bbMovieWidth.bbMovieWidthProc
Global bbMovieHeight.bbMovieHeightProc
Global bbMoviePlaying.bbMoviePlayingProc
Global bbCloseMovie.bbCloseMovieProc
Global bbSetGamma.bbSetGammaProc
Global bbUpdateGamma.bbUpdateGammaProc
Global bbGammaRed.bbGammaRedProc
Global bbGammaGreen.bbGammaGreenProc
Global bbGammaBlue.bbGammaBlueProc
Global bbLoaderMatrix.bbLoaderMatrixProc
Global bbHWTexUnits.bbHWTexUnitsProc
Global bbHWMultiTex.bbHWMultiTexProc
Global bbWBuffer.bbWBufferProc
Global bbDither.bbDitherProc
Global bbAntiAlias.bbAntiAliasProc
Global bbWireFrame.bbWireFrameProc
Global bbAmbientLight.bbAmbientLightProc
Global bbClearCollisions.bbClearCollisionsProc
Global bbCollisions.bbCollisionsProc
Global bbUpdateWorld.bbUpdateWorldProc
Global bbCaptureWorld.bbCaptureWorldProc
Global bbRenderWorld.bbRenderWorldProc
Global bbTrisRendered.bbTrisRenderedProc
Global bbStats3D.bbStats3DProc
Global bbLoadTexture.bbLoadTextureProc
Global bbLoadAnimTexture.bbLoadAnimTextureProc
Global bbCreateTexture.bbCreateTextureProc
Global bbFreeTexture.bbFreeTextureProc
Global bbTextureBlend.bbTextureBlendProc
Global bbTextureCoords.bbTextureCoordsProc
Global bbScaleTexture.bbScaleTextureProc
Global bbRotateTexture.bbRotateTextureProc
Global bbPositionTexture.bbPositionTextureProc
Global bbTextureWidth.bbTextureWidthProc
Global bbTextureHeight.bbTextureHeightProc
Global bbTextureName.bbTextureNameProc
Global bbSetCubeFace.bbSetCubeFaceProc
Global bbSetCubeMode.bbSetCubeModeProc
Global bbTextureBuffer.bbTextureBufferProc
Global bbClearTextureFilters.bbClearTextureFiltersProc
Global bbTextureFilter.bbTextureFilterProc
Global bbCreateBrush.bbCreateBrushProc
Global bbLoadBrush.bbLoadBrushProc
Global bbFreeBrush.bbFreeBrushProc
Global bbBrushColor.bbBrushColorProc
Global bbBrushAlpha.bbBrushAlphaProc
Global bbBrushShininess.bbBrushShininessProc
Global bbBrushTexture.bbBrushTextureProc
Global bbGetBrushTexture.bbGetBrushTextureProc
Global bbBrushBlend.bbBrushBlendProc
Global bbBrushFX.bbBrushFXProc
Global bbCreateMesh.bbCreateMeshProc
Global bbLoadMesh.bbLoadMeshProc
Global bbLoadAnimMesh.bbLoadAnimMeshProc
Global bbCreateCube.bbCreateCubeProc
Global bbCreateSphere.bbCreateSphereProc
Global bbCreateCylinder.bbCreateCylinderProc
Global bbCreateCone.bbCreateConeProc
Global bbCopyMesh.bbCopyMeshProc
Global bbScaleMesh.bbScaleMeshProc
Global bbRotateMesh.bbRotateMeshProc
Global bbPositionMesh.bbPositionMeshProc
Global bbFitMesh.bbFitMeshProc
Global bbFlipMesh.bbFlipMeshProc
Global bbPaintMesh.bbPaintMeshProc
Global bbAddMesh.bbAddMeshProc
Global bbUpdateNormals.bbUpdateNormalsProc
Global bbLightMesh.bbLightMeshProc
Global bbMeshWidth.bbMeshWidthProc
Global bbMeshHeight.bbMeshHeightProc
Global bbMeshDepth.bbMeshDepthProc
Global bbMeshesIntersect.bbMeshesIntersectProc
Global bbCountSurfaces.bbCountSurfacesProc
Global bbGetSurface.bbGetSurfaceProc
Global bbMeshCullBox.bbMeshCullBoxProc
Global bbFindSurface.bbFindSurfaceProc
Global bbCreateSurface.bbCreateSurfaceProc
Global bbGetSurfaceBrush.bbGetSurfaceBrushProc
Global bbGetEntityBrush.bbGetEntityBrushProc
Global bbClearSurface.bbClearSurfaceProc
Global bbPaintSurface.bbPaintSurfaceProc
Global bbAddVertex.bbAddVertexProc
Global bbAddTriangle.bbAddTriangleProc
Global bbVertexCoords.bbVertexCoordsProc
Global bbVertexNormal.bbVertexNormalProc
Global bbVertexColor.bbVertexColorProc
Global bbVertexTexCoords.bbVertexTexCoordsProc
Global bbCountVertices.bbCountVerticesProc
Global bbCountTriangles.bbCountTrianglesProc
Global bbVertexX.bbVertexXProc
Global bbVertexY.bbVertexYProc
Global bbVertexZ.bbVertexZProc
Global bbVertexNX.bbVertexNXProc
Global bbVertexNY.bbVertexNYProc
Global bbVertexNZ.bbVertexNZProc
Global bbVertexRed.bbVertexRedProc
Global bbVertexGreen.bbVertexGreenProc
Global bbVertexBlue.bbVertexBlueProc
Global bbVertexAlpha.bbVertexAlphaProc
Global bbVertexU.bbVertexUProc
Global bbVertexV.bbVertexVProc
Global bbVertexW.bbVertexWProc
Global bbTriangleVertex.bbTriangleVertexProc
Global bbCreateCamera.bbCreateCameraProc
Global bbCameraZoom.bbCameraZoomProc
Global bbCameraRange.bbCameraRangeProc
Global bbCameraClsColor.bbCameraClsColorProc
Global bbCameraClsMode.bbCameraClsModeProc
Global bbCameraProjMode.bbCameraProjModeProc
Global bbCameraViewport.bbCameraViewportProc
Global bbCameraFogRange.bbCameraFogRangeProc
Global bbCameraFogColor.bbCameraFogColorProc
Global bbCameraFogMode.bbCameraFogModeProc
Global bbCameraProject.bbCameraProjectProc
Global bbProjectedX.bbProjectedXProc
Global bbProjectedY.bbProjectedYProc
Global bbProjectedZ.bbProjectedZProc
Global bbCameraPick.bbCameraPickProc
Global bbLinePick.bbLinePickProc
Global bbEntityPick.bbEntityPickProc
Global bbEntityVisible.bbEntityVisibleProc
Global bbEntityInView.bbEntityInViewProc
Global bbPickedX.bbPickedXProc
Global bbPickedY.bbPickedYProc
Global bbPickedZ.bbPickedZProc
Global bbPickedNX.bbPickedNXProc
Global bbPickedNY.bbPickedNYProc
Global bbPickedNZ.bbPickedNZProc
Global bbPickedTime.bbPickedTimeProc
Global bbPickedEntity.bbPickedEntityProc
Global bbPickedSurface.bbPickedSurfaceProc
Global bbPickedTriangle.bbPickedTriangleProc
Global bbCreateLight.bbCreateLightProc
Global bbLightColor.bbLightColorProc
Global bbLightRange.bbLightRangeProc
Global bbLightConeAngles.bbLightConeAnglesProc
Global bbCreatePivot.bbCreatePivotProc
Global bbCreateSprite.bbCreateSpriteProc
Global bbLoadSprite.bbLoadSpriteProc
Global bbRotateSprite.bbRotateSpriteProc
Global bbScaleSprite.bbScaleSpriteProc
Global bbHandleSprite.bbHandleSpriteProc
Global bbSpriteViewMode.bbSpriteViewModeProc
Global bbCreateMirror.bbCreateMirrorProc
Global bbCreatePlane.bbCreatePlaneProc
Global bbLoadMD2.bbLoadMD2Proc
Global bbAnimateMD2.bbAnimateMD2Proc
Global bbMD2AnimTime.bbMD2AnimTimeProc
Global bbMD2AnimLength.bbMD2AnimLengthProc
Global bbMD2Animating.bbMD2AnimatingProc
Global bbLoadBSP.bbLoadBSPProc
Global bbBSPAmbientLight.bbBSPAmbientLightProc
Global bbBSPLighting.bbBSPLightingProc
Global bbCreateTerrain.bbCreateTerrainProc
Global bbLoadTerrain.bbLoadTerrainProc
Global bbTerrainDetail.bbTerrainDetailProc
Global bbTerrainShading.bbTerrainShadingProc
Global bbTerrainX.bbTerrainXProc
Global bbTerrainY.bbTerrainYProc
Global bbTerrainZ.bbTerrainZProc
Global bbTerrainSize.bbTerrainSizeProc
Global bbTerrainHeight.bbTerrainHeightProc
Global bbModifyTerrain.bbModifyTerrainProc
Global bbCreateListener.bbCreateListenerProc
Global bbEmitSound.bbEmitSoundProc
Global bbCopyEntity.bbCopyEntityProc
Global bbFreeEntity.bbFreeEntityProc
Global bbHideEntity.bbHideEntityProc
Global bbShowEntity.bbShowEntityProc
Global bbEntityParent.bbEntityParentProc
Global bbCountChildren.bbCountChildrenProc
Global bbGetChild.bbGetChildProc
Global bbFindChild.bbFindChildProc
Global bbLoadAnimSeq.bbLoadAnimSeqProc
Global bbSetAnimTime.bbSetAnimTimeProc
Global bbAnimate.bbAnimateProc
Global bbSetAnimKey.bbSetAnimKeyProc
Global bbExtractAnimSeq.bbExtractAnimSeqProc
Global bbAddAnimSeq.bbAddAnimSeqProc
Global bbAnimSeq.bbAnimSeqProc
Global bbAnimTime.bbAnimTimeProc
Global bbAnimLength.bbAnimLengthProc
Global bbAnimating.bbAnimatingProc
Global bbPaintEntity.bbPaintEntityProc
Global bbEntityColor.bbEntityColorProc
Global bbEntityAlpha.bbEntityAlphaProc
Global bbEntityShininess.bbEntityShininessProc
Global bbEntityTexture.bbEntityTextureProc
Global bbEntityBlend.bbEntityBlendProc
Global bbEntityFX.bbEntityFXProc
Global bbEntityAutoFade.bbEntityAutoFadeProc
Global bbEntityOrder.bbEntityOrderProc
Global bbEntityX.bbEntityXProc
Global bbEntityY.bbEntityYProc
Global bbEntityZ.bbEntityZProc
Global bbEntityPitch.bbEntityPitchProc
Global bbEntityYaw.bbEntityYawProc
Global bbEntityRoll.bbEntityRollProc
Global bbGetMatElement.bbGetMatElementProc
Global bbTFormPoint.bbTFormPointProc
Global bbTFormVector.bbTFormVectorProc
Global bbTFormNormal.bbTFormNormalProc
Global bbTFormedX.bbTFormedXProc
Global bbTFormedY.bbTFormedYProc
Global bbTFormedZ.bbTFormedZProc
Global bbVectorYaw.bbVectorYawProc
Global bbVectorPitch.bbVectorPitchProc
Global bbDeltaYaw.bbDeltaYawProc
Global bbDeltaPitch.bbDeltaPitchProc
Global bbResetEntity.bbResetEntityProc
Global bbCaptureEntity.bbCaptureEntityProc
Global bbEntityType.bbEntityTypeProc
Global bbEntityPickMode.bbEntityPickModeProc
Global bbGetParent.bbGetParentProc
Global bbGetEntityType.bbGetEntityTypeProc
Global bbEntityRadius.bbEntityRadiusProc
Global bbEntityBox.bbEntityBoxProc
Global bbEntityCollided.bbEntityCollidedProc
Global bbCountCollisions.bbCountCollisionsProc
Global bbCollisionX.bbCollisionXProc
Global bbCollisionY.bbCollisionYProc
Global bbCollisionZ.bbCollisionZProc
Global bbCollisionNX.bbCollisionNXProc
Global bbCollisionNY.bbCollisionNYProc
Global bbCollisionNZ.bbCollisionNZProc
Global bbCollisionTime.bbCollisionTimeProc
Global bbCollisionEntity.bbCollisionEntityProc
Global bbCollisionSurface.bbCollisionSurfaceProc
Global bbCollisionTriangle.bbCollisionTriangleProc
Global bbEntityDistance.bbEntityDistanceProc
Global bbMoveEntity.bbMoveEntityProc
Global bbTurnEntity.bbTurnEntityProc
Global bbTranslateEntity.bbTranslateEntityProc
Global bbPositionEntity.bbPositionEntityProc
Global bbScaleEntity.bbScaleEntityProc
Global bbRotateEntity.bbRotateEntityProc
Global bbPointEntity.bbPointEntityProc
Global bbAlignToVector.bbAlignToVectorProc
Global bbNameEntity.bbNameEntityProc
Global bbEntityName.bbEntityNameProc
Global bbEntityClass.bbEntityClassProc
Global bbClearWorld.bbClearWorldProc
Global bbSetEntityID.bbSetEntityIDProc
Global bbEntityID.bbEntityIDProc
Global bbActiveTextures.bbActiveTexturesProc

; Assign functions from DLL...

bbVersion = GetFunction (b3ddll, "bbVersion")
bbSetBlitz3DDebugMode = GetFunction (b3ddll, "bbSetBlitz3DDebugMode")
bbSetBlitz3DDebugCallback = GetFunction (b3ddll, "bbSetBlitz3DDebugCallback")
bbSetBlitz3DEventCallback = GetFunction (b3ddll, "bbSetBlitz3DEventCallback")
bbSetBlitz3DHWND = GetFunction (b3ddll, "bbSetBlitz3DHWND")
bbSetBlitz3DTitle = GetFunction (b3ddll, "bbSetBlitz3DTitle")
bbBeginBlitz3D = GetFunction (b3ddll, "bbBeginBlitz3D")
bbBeginBlitz3DEx = GetFunction (b3ddll, "bbBeginBlitz3DEx")
bbEndBlitz3D = GetFunction (b3ddll, "bbEndBlitz3D")
bbValidateGraphics = GetFunction (b3ddll, "bbValidateGraphics")
bbRuntimeError = GetFunction (b3ddll, "bbRuntimeError")
bbMilliSecs = GetFunction (b3ddll, "bbMilliSecs")
bbDelay = GetFunction (b3ddll, "bbDelay")
bbShowPointer = GetFunction (b3ddll, "bbShowPointer")
bbHidePointer = GetFunction (b3ddll, "bbHidePointer")
bbCreateTimer = GetFunction (b3ddll, "bbCreateTimer")
bbFreeTimer = GetFunction (b3ddll, "bbFreeTimer")
bbWaitTimer = GetFunction (b3ddll, "bbWaitTimer")
bbKeyDown = GetFunction (b3ddll, "bbKeyDown")
bbKeyHit = GetFunction (b3ddll, "bbKeyHit")
bbGetKey = GetFunction (b3ddll, "bbGetKey")
bbWaitKey = GetFunction (b3ddll, "bbWaitKey")
bbFlushKeys = GetFunction (b3ddll, "bbFlushKeys")
bbMouseDown = GetFunction (b3ddll, "bbMouseDown")
bbMouseHit = GetFunction (b3ddll, "bbMouseHit")
bbGetMouse = GetFunction (b3ddll, "bbGetMouse")
bbWaitMouse = GetFunction (b3ddll, "bbWaitMouse")
bbMouseX = GetFunction (b3ddll, "bbMouseX")
bbMouseY = GetFunction (b3ddll, "bbMouseY")
bbMouseZ = GetFunction (b3ddll, "bbMouseZ")
bbMouseXSpeed = GetFunction (b3ddll, "bbMouseXSpeed")
bbMouseYSpeed = GetFunction (b3ddll, "bbMouseYSpeed")
bbMouseZSpeed = GetFunction (b3ddll, "bbMouseZSpeed")
bbMoveMouse = GetFunction (b3ddll, "bbMoveMouse")
bbFlushMouse = GetFunction (b3ddll, "bbFlushMouse")
bbJoyType = GetFunction (b3ddll, "bbJoyType")
bbJoyDown = GetFunction (b3ddll, "bbJoyDown")
bbJoyHit = GetFunction (b3ddll, "bbJoyHit")
bbGetJoy = GetFunction (b3ddll, "bbGetJoy")
bbWaitJoy = GetFunction (b3ddll, "bbWaitJoy")
bbJoyX = GetFunction (b3ddll, "bbJoyX")
bbJoyY = GetFunction (b3ddll, "bbJoyY")
bbJoyZ = GetFunction (b3ddll, "bbJoyZ")
bbJoyU = GetFunction (b3ddll, "bbJoyU")
bbJoyV = GetFunction (b3ddll, "bbJoyV")
bbJoyPitch = GetFunction (b3ddll, "bbJoyPitch")
bbJoyYaw = GetFunction (b3ddll, "bbJoyYaw")
bbJoyRoll = GetFunction (b3ddll, "bbJoyRoll")
bbJoyHat = GetFunction (b3ddll, "bbJoyHat")
bbJoyXDir = GetFunction (b3ddll, "bbJoyXDir")
bbJoyYDir = GetFunction (b3ddll, "bbJoyYDir")
bbJoyZDir = GetFunction (b3ddll, "bbJoyZDir")
bbJoyUDir = GetFunction (b3ddll, "bbJoyUDir")
bbJoyVDir = GetFunction (b3ddll, "bbJoyVDir")
bbFlushJoy = GetFunction (b3ddll, "bbFlushJoy")
bbLoadSound = GetFunction (b3ddll, "bbLoadSound")
bbFreeSound = GetFunction (b3ddll, "bbFreeSound")
bbPlaySound = GetFunction (b3ddll, "bbPlaySound")
bbLoopSound = GetFunction (b3ddll, "bbLoopSound")
bbSoundPitch = GetFunction (b3ddll, "bbSoundPitch")
bbSoundVolume = GetFunction (b3ddll, "bbSoundVolume")
bbSoundPan = GetFunction (b3ddll, "bbSoundPan")
bbPlayMusic = GetFunction (b3ddll, "bbPlayMusic")
bbPlayCDTrack = GetFunction (b3ddll, "bbPlayCDTrack")
bbStopChannel = GetFunction (b3ddll, "bbStopChannel")
bbPauseChannel = GetFunction (b3ddll, "bbPauseChannel")
bbResumeChannel = GetFunction (b3ddll, "bbResumeChannel")
bbChannelPitch = GetFunction (b3ddll, "bbChannelPitch")
bbChannelVolume = GetFunction (b3ddll, "bbChannelVolume")
bbChannelPan = GetFunction (b3ddll, "bbChannelPan")
bbChannelPlaying = GetFunction (b3ddll, "bbChannelPlaying")
bbGraphics3D = GetFunction (b3ddll, "bbGraphics3D")
bbCountGfxDrivers = GetFunction (b3ddll, "bbCountGfxDrivers")
bbGfxDriverName = GetFunction (b3ddll, "bbGfxDriverName")
bbGfxDriver3D = GetFunction (b3ddll, "bbGfxDriver3D")
bbGfxDriverCaps3D = GetFunction (b3ddll, "bbGfxDriverCaps3D")
bbCountGfxModes3D = GetFunction (b3ddll, "bbCountGfxModes3D")
bbGfxMode3DExists = GetFunction (b3ddll, "bbGfxMode3DExists")
bbGfxMode3D = GetFunction (b3ddll, "bbGfxMode3D")
bbWindowed3D = GetFunction (b3ddll, "bbWindowed3D")
bbGfxDriverX = GetFunction (b3ddll, "bbGfxDriverX")
bbGfxDriverY = GetFunction (b3ddll, "bbGfxDriverY")
bbGfxDriverHz = GetFunction (b3ddll, "bbGfxDriverHz")
bbSetGfxDriver = GetFunction (b3ddll, "bbSetGfxDriver")
bbGfxModeExists = GetFunction (b3ddll, "bbGfxModeExists")
bbCountGfxModes = GetFunction (b3ddll, "bbCountGfxModes")
bbGfxModeWidth = GetFunction (b3ddll, "bbGfxModeWidth")
bbGfxModeHeight = GetFunction (b3ddll, "bbGfxModeHeight")
bbGfxModeDepth = GetFunction (b3ddll, "bbGfxModeDepth")
bbGraphicsWidth = GetFunction (b3ddll, "bbGraphicsWidth")
bbGraphicsHeight = GetFunction (b3ddll, "bbGraphicsHeight")
bbGraphicsDepth = GetFunction (b3ddll, "bbGraphicsDepth")
bbAvailVidMem = GetFunction (b3ddll, "bbAvailVidMem")
bbTotalVidMem = GetFunction (b3ddll, "bbTotalVidMem")
bbGraphics = GetFunction (b3ddll, "bbGraphics")
bbFrontBuffer = GetFunction (b3ddll, "bbFrontBuffer")
bbBackBuffer = GetFunction (b3ddll, "bbBackBuffer")
bbEndGraphics = GetFunction (b3ddll, "bbEndGraphics")
bbScanLine = GetFunction (b3ddll, "bbScanLine")
bbVWait = GetFunction (b3ddll, "bbVWait")
bbFlip = GetFunction (b3ddll, "bbFlip")
bbSetBuffer = GetFunction (b3ddll, "bbSetBuffer")
bbGraphicsBuffer = GetFunction (b3ddll, "bbGraphicsBuffer")
bbLoadBuffer = GetFunction (b3ddll, "bbLoadBuffer")
bbSaveBuffer = GetFunction (b3ddll, "bbSaveBuffer")
bbLockBuffer = GetFunction (b3ddll, "bbLockBuffer")
bbUnlockBuffer = GetFunction (b3ddll, "bbUnlockBuffer")
bbReadPixel = GetFunction (b3ddll, "bbReadPixel")
bbWritePixel = GetFunction (b3ddll, "bbWritePixel")
bbReadPixelFast = GetFunction (b3ddll, "bbReadPixelFast")
bbWritePixelFast = GetFunction (b3ddll, "bbWritePixelFast")
bbCopyPixel = GetFunction (b3ddll, "bbCopyPixel")
bbCopyPixelFast = GetFunction (b3ddll, "bbCopyPixelFast")
bbOrigin = GetFunction (b3ddll, "bbOrigin")
bbViewport = GetFunction (b3ddll, "bbViewport")
bbColor = GetFunction (b3ddll, "bbColor")
bbClsColor = GetFunction (b3ddll, "bbClsColor")
bbCls = GetFunction (b3ddll, "bbCls")
bbPlot = GetFunction (b3ddll, "bbPlot")
bbLine = GetFunction (b3ddll, "bbLine")
bbRect = GetFunction (b3ddll, "bbRect")
bbOval = GetFunction (b3ddll, "bbOval")
bbText = GetFunction (b3ddll, "bbText")
bbCopyRect = GetFunction (b3ddll, "bbCopyRect")
bbGetColor = GetFunction (b3ddll, "bbGetColor")
bbColorRed = GetFunction (b3ddll, "bbColorRed")
bbColorGreen = GetFunction (b3ddll, "bbColorGreen")
bbColorBlue = GetFunction (b3ddll, "bbColorBlue")
bbLoadFont = GetFunction (b3ddll, "bbLoadFont")
bbFreeFont = GetFunction (b3ddll, "bbFreeFont")
bbSetFont = GetFunction (b3ddll, "bbSetFont")
bbFontWidth = GetFunction (b3ddll, "bbFontWidth")
bbFontHeight = GetFunction (b3ddll, "bbFontHeight")
bbStringWidth = GetFunction (b3ddll, "bbStringWidth")
bbStringHeight = GetFunction (b3ddll, "bbStringHeight")
bbLoadImage = GetFunction (b3ddll, "bbLoadImage")
bbCopyImage = GetFunction (b3ddll, "bbCopyImage")
bbCreateImage = GetFunction (b3ddll, "bbCreateImage")
bbLoadAnimImage = GetFunction (b3ddll, "bbLoadAnimImage")
bbFreeImage = GetFunction (b3ddll, "bbFreeImage")
bbSaveImage = GetFunction (b3ddll, "bbSaveImage")
bbGrabImage = GetFunction (b3ddll, "bbGrabImage")
bbImageBuffer = GetFunction (b3ddll, "bbImageBuffer")
bbDrawImage = GetFunction (b3ddll, "bbDrawImage")
bbDrawBlock = GetFunction (b3ddll, "bbDrawBlock")
bbTileImage = GetFunction (b3ddll, "bbTileImage")
bbTileBlock = GetFunction (b3ddll, "bbTileBlock")
bbDrawImageRect = GetFunction (b3ddll, "bbDrawImageRect")
bbDrawBlockRect = GetFunction (b3ddll, "bbDrawBlockRect")
bbMaskImage = GetFunction (b3ddll, "bbMaskImage")
bbHandleImage = GetFunction (b3ddll, "bbHandleImage")
bbScaleImage = GetFunction (b3ddll, "bbScaleImage")
bbResizeImage = GetFunction (b3ddll, "bbResizeImage")
bbRotateImage = GetFunction (b3ddll, "bbRotateImage")
bbTFormImage = GetFunction (b3ddll, "bbTFormImage")
bbTFormFilter = GetFunction (b3ddll, "bbTFormFilter")
bbAutoMidHandle = GetFunction (b3ddll, "bbAutoMidHandle")
bbMidHandle = GetFunction (b3ddll, "bbMidHandle")
bbImageWidth = GetFunction (b3ddll, "bbImageWidth")
bbImageHeight = GetFunction (b3ddll, "bbImageHeight")
bbImageXHandle = GetFunction (b3ddll, "bbImageXHandle")
bbImageYHandle = GetFunction (b3ddll, "bbImageYHandle")
bbImagesOverlap = GetFunction (b3ddll, "bbImagesOverlap")
bbImagesCollide = GetFunction (b3ddll, "bbImagesCollide")
bbRectsOverlap = GetFunction (b3ddll, "bbRectsOverlap")
bbImageRectOverlap = GetFunction (b3ddll, "bbImageRectOverlap")
bbImageRectCollide = GetFunction (b3ddll, "bbImageRectCollide")
bbWrite = GetFunction (b3ddll, "bbWrite")
bbPrint = GetFunction (b3ddll, "bbPrint")
bbInput = GetFunction (b3ddll, "bbInput")
bbLocate = GetFunction (b3ddll, "bbLocate")
bbOpenMovie = GetFunction (b3ddll, "bbOpenMovie")
bbDrawMovie = GetFunction (b3ddll, "bbDrawMovie")
bbMovieWidth = GetFunction (b3ddll, "bbMovieWidth")
bbMovieHeight = GetFunction (b3ddll, "bbMovieHeight")
bbMoviePlaying = GetFunction (b3ddll, "bbMoviePlaying")
bbCloseMovie = GetFunction (b3ddll, "bbCloseMovie")
bbSetGamma = GetFunction (b3ddll, "bbSetGamma")
bbUpdateGamma = GetFunction (b3ddll, "bbUpdateGamma")
bbGammaRed = GetFunction (b3ddll, "bbGammaRed")
bbGammaGreen = GetFunction (b3ddll, "bbGammaGreen")
bbGammaBlue = GetFunction (b3ddll, "bbGammaBlue")
bbLoaderMatrix = GetFunction (b3ddll, "bbLoaderMatrix")
bbHWTexUnits = GetFunction (b3ddll, "bbHWTexUnits")
bbHWMultiTex = GetFunction (b3ddll, "bbHWMultiTex")
bbWBuffer = GetFunction (b3ddll, "bbWBuffer")
bbDither = GetFunction (b3ddll, "bbDither")
bbAntiAlias = GetFunction (b3ddll, "bbAntiAlias")
bbWireFrame = GetFunction (b3ddll, "bbWireFrame")
bbAmbientLight = GetFunction (b3ddll, "bbAmbientLight")
bbClearCollisions = GetFunction (b3ddll, "bbClearCollisions")
bbCollisions = GetFunction (b3ddll, "bbCollisions")
bbUpdateWorld = GetFunction (b3ddll, "bbUpdateWorld")
bbCaptureWorld = GetFunction (b3ddll, "bbCaptureWorld")
bbRenderWorld = GetFunction (b3ddll, "bbRenderWorld")
bbTrisRendered = GetFunction (b3ddll, "bbTrisRendered")
bbStats3D = GetFunction (b3ddll, "bbStats3D")
bbLoadTexture = GetFunction (b3ddll, "bbLoadTexture")
bbLoadAnimTexture = GetFunction (b3ddll, "bbLoadAnimTexture")
bbCreateTexture = GetFunction (b3ddll, "bbCreateTexture")
bbFreeTexture = GetFunction (b3ddll, "bbFreeTexture")
bbTextureBlend = GetFunction (b3ddll, "bbTextureBlend")
bbTextureCoords = GetFunction (b3ddll, "bbTextureCoords")
bbScaleTexture = GetFunction (b3ddll, "bbScaleTexture")
bbRotateTexture = GetFunction (b3ddll, "bbRotateTexture")
bbPositionTexture = GetFunction (b3ddll, "bbPositionTexture")
bbTextureWidth = GetFunction (b3ddll, "bbTextureWidth")
bbTextureHeight = GetFunction (b3ddll, "bbTextureHeight")
bbTextureName = GetFunction (b3ddll, "bbTextureName")
bbSetCubeFace = GetFunction (b3ddll, "bbSetCubeFace")
bbSetCubeMode = GetFunction (b3ddll, "bbSetCubeMode")
bbTextureBuffer = GetFunction (b3ddll, "bbTextureBuffer")
bbClearTextureFilters = GetFunction (b3ddll, "bbClearTextureFilters")
bbTextureFilter = GetFunction (b3ddll, "bbTextureFilter")
bbCreateBrush = GetFunction (b3ddll, "bbCreateBrush")
bbLoadBrush = GetFunction (b3ddll, "bbLoadBrush")
bbFreeBrush = GetFunction (b3ddll, "bbFreeBrush")
bbBrushColor = GetFunction (b3ddll, "bbBrushColor")
bbBrushAlpha = GetFunction (b3ddll, "bbBrushAlpha")
bbBrushShininess = GetFunction (b3ddll, "bbBrushShininess")
bbBrushTexture = GetFunction (b3ddll, "bbBrushTexture")
bbGetBrushTexture = GetFunction (b3ddll, "bbGetBrushTexture")
bbBrushBlend = GetFunction (b3ddll, "bbBrushBlend")
bbBrushFX = GetFunction (b3ddll, "bbBrushFX")
bbCreateMesh = GetFunction (b3ddll, "bbCreateMesh")
bbLoadMesh = GetFunction (b3ddll, "bbLoadMesh")
bbLoadAnimMesh = GetFunction (b3ddll, "bbLoadAnimMesh")
bbCreateCube = GetFunction (b3ddll, "bbCreateCube")
bbCreateSphere = GetFunction (b3ddll, "bbCreateSphere")
bbCreateCylinder = GetFunction (b3ddll, "bbCreateCylinder")
bbCreateCone = GetFunction (b3ddll, "bbCreateCone")
bbCopyMesh = GetFunction (b3ddll, "bbCopyMesh")
bbScaleMesh = GetFunction (b3ddll, "bbScaleMesh")
bbRotateMesh = GetFunction (b3ddll, "bbRotateMesh")
bbPositionMesh = GetFunction (b3ddll, "bbPositionMesh")
bbFitMesh = GetFunction (b3ddll, "bbFitMesh")
bbFlipMesh = GetFunction (b3ddll, "bbFlipMesh")
bbPaintMesh = GetFunction (b3ddll, "bbPaintMesh")
bbAddMesh = GetFunction (b3ddll, "bbAddMesh")
bbUpdateNormals = GetFunction (b3ddll, "bbUpdateNormals")
bbLightMesh = GetFunction (b3ddll, "bbLightMesh")
bbMeshWidth = GetFunction (b3ddll, "bbMeshWidth")
bbMeshHeight = GetFunction (b3ddll, "bbMeshHeight")
bbMeshDepth = GetFunction (b3ddll, "bbMeshDepth")
bbMeshesIntersect = GetFunction (b3ddll, "bbMeshesIntersect")
bbCountSurfaces = GetFunction (b3ddll, "bbCountSurfaces")
bbGetSurface = GetFunction (b3ddll, "bbGetSurface")
bbMeshCullBox = GetFunction (b3ddll, "bbMeshCullBox")
bbFindSurface = GetFunction (b3ddll, "bbFindSurface")
bbCreateSurface = GetFunction (b3ddll, "bbCreateSurface")
bbGetSurfaceBrush = GetFunction (b3ddll, "bbGetSurfaceBrush")
bbGetEntityBrush = GetFunction (b3ddll, "bbGetEntityBrush")
bbClearSurface = GetFunction (b3ddll, "bbClearSurface")
bbPaintSurface = GetFunction (b3ddll, "bbPaintSurface")
bbAddVertex = GetFunction (b3ddll, "bbAddVertex")
bbAddTriangle = GetFunction (b3ddll, "bbAddTriangle")
bbVertexCoords = GetFunction (b3ddll, "bbVertexCoords")
bbVertexNormal = GetFunction (b3ddll, "bbVertexNormal")
bbVertexColor = GetFunction (b3ddll, "bbVertexColor")
bbVertexTexCoords = GetFunction (b3ddll, "bbVertexTexCoords")
bbCountVertices = GetFunction (b3ddll, "bbCountVertices")
bbCountTriangles = GetFunction (b3ddll, "bbCountTriangles")
bbVertexX = GetFunction (b3ddll, "bbVertexX")
bbVertexY = GetFunction (b3ddll, "bbVertexY")
bbVertexZ = GetFunction (b3ddll, "bbVertexZ")
bbVertexNX = GetFunction (b3ddll, "bbVertexNX")
bbVertexNY = GetFunction (b3ddll, "bbVertexNY")
bbVertexNZ = GetFunction (b3ddll, "bbVertexNZ")
bbVertexRed = GetFunction (b3ddll, "bbVertexRed")
bbVertexGreen = GetFunction (b3ddll, "bbVertexGreen")
bbVertexBlue = GetFunction (b3ddll, "bbVertexBlue")
bbVertexAlpha = GetFunction (b3ddll, "bbVertexAlpha")
bbVertexU = GetFunction (b3ddll, "bbVertexU")
bbVertexV = GetFunction (b3ddll, "bbVertexV")
bbVertexW = GetFunction (b3ddll, "bbVertexW")
bbTriangleVertex = GetFunction (b3ddll, "bbTriangleVertex")
bbCreateCamera = GetFunction (b3ddll, "bbCreateCamera")
bbCameraZoom = GetFunction (b3ddll, "bbCameraZoom")
bbCameraRange = GetFunction (b3ddll, "bbCameraRange")
bbCameraClsColor = GetFunction (b3ddll, "bbCameraClsColor")
bbCameraClsMode = GetFunction (b3ddll, "bbCameraClsMode")
bbCameraProjMode = GetFunction (b3ddll, "bbCameraProjMode")
bbCameraViewport = GetFunction (b3ddll, "bbCameraViewport")
bbCameraFogRange = GetFunction (b3ddll, "bbCameraFogRange")
bbCameraFogColor = GetFunction (b3ddll, "bbCameraFogColor")
bbCameraFogMode = GetFunction (b3ddll, "bbCameraFogMode")
bbCameraProject = GetFunction (b3ddll, "bbCameraProject")
bbProjectedX = GetFunction (b3ddll, "bbProjectedX")
bbProjectedY = GetFunction (b3ddll, "bbProjectedY")
bbProjectedZ = GetFunction (b3ddll, "bbProjectedZ")
bbCameraPick = GetFunction (b3ddll, "bbCameraPick")
bbLinePick = GetFunction (b3ddll, "bbLinePick")
bbEntityPick = GetFunction (b3ddll, "bbEntityPick")
bbEntityVisible = GetFunction (b3ddll, "bbEntityVisible")
bbEntityInView = GetFunction (b3ddll, "bbEntityInView")
bbPickedX = GetFunction (b3ddll, "bbPickedX")
bbPickedY = GetFunction (b3ddll, "bbPickedY")
bbPickedZ = GetFunction (b3ddll, "bbPickedZ")
bbPickedNX = GetFunction (b3ddll, "bbPickedNX")
bbPickedNY = GetFunction (b3ddll, "bbPickedNY")
bbPickedNZ = GetFunction (b3ddll, "bbPickedNZ")
bbPickedTime = GetFunction (b3ddll, "bbPickedTime")
bbPickedEntity = GetFunction (b3ddll, "bbPickedEntity")
bbPickedSurface = GetFunction (b3ddll, "bbPickedSurface")
bbPickedTriangle = GetFunction (b3ddll, "bbPickedTriangle")
bbCreateLight = GetFunction (b3ddll, "bbCreateLight")
bbLightColor = GetFunction (b3ddll, "bbLightColor")
bbLightRange = GetFunction (b3ddll, "bbLightRange")
bbLightConeAngles = GetFunction (b3ddll, "bbLightConeAngles")
bbCreatePivot = GetFunction (b3ddll, "bbCreatePivot")
bbCreateSprite = GetFunction (b3ddll, "bbCreateSprite")
bbLoadSprite = GetFunction (b3ddll, "bbLoadSprite")
bbRotateSprite = GetFunction (b3ddll, "bbRotateSprite")
bbScaleSprite = GetFunction (b3ddll, "bbScaleSprite")
bbHandleSprite = GetFunction (b3ddll, "bbHandleSprite")
bbSpriteViewMode = GetFunction (b3ddll, "bbSpriteViewMode")
bbCreateMirror = GetFunction (b3ddll, "bbCreateMirror")
bbCreatePlane = GetFunction (b3ddll, "bbCreatePlane")
bbLoadMD2 = GetFunction (b3ddll, "bbLoadMD2")
bbAnimateMD2 = GetFunction (b3ddll, "bbAnimateMD2")
bbMD2AnimTime = GetFunction (b3ddll, "bbMD2AnimTime")
bbMD2AnimLength = GetFunction (b3ddll, "bbMD2AnimLength")
bbMD2Animating = GetFunction (b3ddll, "bbMD2Animating")
bbLoadBSP = GetFunction (b3ddll, "bbLoadBSP")
bbBSPAmbientLight = GetFunction (b3ddll, "bbBSPAmbientLight")
bbBSPLighting = GetFunction (b3ddll, "bbBSPLighting")
bbCreateTerrain = GetFunction (b3ddll, "bbCreateTerrain")
bbLoadTerrain = GetFunction (b3ddll, "bbLoadTerrain")
bbTerrainDetail = GetFunction (b3ddll, "bbTerrainDetail")
bbTerrainShading = GetFunction (b3ddll, "bbTerrainShading")
bbTerrainX = GetFunction (b3ddll, "bbTerrainX")
bbTerrainY = GetFunction (b3ddll, "bbTerrainY")
bbTerrainZ = GetFunction (b3ddll, "bbTerrainZ")
bbTerrainSize = GetFunction (b3ddll, "bbTerrainSize")
bbTerrainHeight = GetFunction (b3ddll, "bbTerrainHeight")
bbModifyTerrain = GetFunction (b3ddll, "bbModifyTerrain")
bbCreateListener = GetFunction (b3ddll, "bbCreateListener")
bbEmitSound = GetFunction (b3ddll, "bbEmitSound")
bbCopyEntity = GetFunction (b3ddll, "bbCopyEntity")
bbFreeEntity = GetFunction (b3ddll, "bbFreeEntity")
bbHideEntity = GetFunction (b3ddll, "bbHideEntity")
bbShowEntity = GetFunction (b3ddll, "bbShowEntity")
bbEntityParent = GetFunction (b3ddll, "bbEntityParent")
bbCountChildren = GetFunction (b3ddll, "bbCountChildren")
bbGetChild = GetFunction (b3ddll, "bbGetChild")
bbFindChild = GetFunction (b3ddll, "bbFindChild")
bbLoadAnimSeq = GetFunction (b3ddll, "bbLoadAnimSeq")
bbSetAnimTime = GetFunction (b3ddll, "bbSetAnimTime")
bbAnimate = GetFunction (b3ddll, "bbAnimate")
bbSetAnimKey = GetFunction (b3ddll, "bbSetAnimKey")
bbExtractAnimSeq = GetFunction (b3ddll, "bbExtractAnimSeq")
bbAddAnimSeq = GetFunction (b3ddll, "bbAddAnimSeq")
bbAnimSeq = GetFunction (b3ddll, "bbAnimSeq")
bbAnimTime = GetFunction (b3ddll, "bbAnimTime")
bbAnimLength = GetFunction (b3ddll, "bbAnimLength")
bbAnimating = GetFunction (b3ddll, "bbAnimating")
bbPaintEntity = GetFunction (b3ddll, "bbPaintEntity")
bbEntityColor = GetFunction (b3ddll, "bbEntityColor")
bbEntityAlpha = GetFunction (b3ddll, "bbEntityAlpha")
bbEntityShininess = GetFunction (b3ddll, "bbEntityShininess")
bbEntityTexture = GetFunction (b3ddll, "bbEntityTexture")
bbEntityBlend = GetFunction (b3ddll, "bbEntityBlend")
bbEntityFX = GetFunction (b3ddll, "bbEntityFX")
bbEntityAutoFade = GetFunction (b3ddll, "bbEntityAutoFade")
bbEntityOrder = GetFunction (b3ddll, "bbEntityOrder")
bbEntityX = GetFunction (b3ddll, "bbEntityX")
bbEntityY = GetFunction (b3ddll, "bbEntityY")
bbEntityZ = GetFunction (b3ddll, "bbEntityZ")
bbEntityPitch = GetFunction (b3ddll, "bbEntityPitch")
bbEntityYaw = GetFunction (b3ddll, "bbEntityYaw")
bbEntityRoll = GetFunction (b3ddll, "bbEntityRoll")
bbGetMatElement = GetFunction (b3ddll, "bbGetMatElement")
bbTFormPoint = GetFunction (b3ddll, "bbTFormPoint")
bbTFormVector = GetFunction (b3ddll, "bbTFormVector")
bbTFormNormal = GetFunction (b3ddll, "bbTFormNormal")
bbTFormedX = GetFunction (b3ddll, "bbTFormedX")
bbTFormedY = GetFunction (b3ddll, "bbTFormedY")
bbTFormedZ = GetFunction (b3ddll, "bbTFormedZ")
bbVectorYaw = GetFunction (b3ddll, "bbVectorYaw")
bbVectorPitch = GetFunction (b3ddll, "bbVectorPitch")
bbDeltaYaw = GetFunction (b3ddll, "bbDeltaYaw")
bbDeltaPitch = GetFunction (b3ddll, "bbDeltaPitch")
bbResetEntity = GetFunction (b3ddll, "bbResetEntity")
bbCaptureEntity = GetFunction (b3ddll, "bbCaptureEntity")
bbEntityType = GetFunction (b3ddll, "bbEntityType")
bbEntityPickMode = GetFunction (b3ddll, "bbEntityPickMode")
bbGetParent = GetFunction (b3ddll, "bbGetParent")
bbGetEntityType = GetFunction (b3ddll, "bbGetEntityType")
bbEntityRadius = GetFunction (b3ddll, "bbEntityRadius")
bbEntityBox = GetFunction (b3ddll, "bbEntityBox")
bbEntityCollided = GetFunction (b3ddll, "bbEntityCollided")
bbCountCollisions = GetFunction (b3ddll, "bbCountCollisions")
bbCollisionX = GetFunction (b3ddll, "bbCollisionX")
bbCollisionY = GetFunction (b3ddll, "bbCollisionY")
bbCollisionZ = GetFunction (b3ddll, "bbCollisionZ")
bbCollisionNX = GetFunction (b3ddll, "bbCollisionNX")
bbCollisionNY = GetFunction (b3ddll, "bbCollisionNY")
bbCollisionNZ = GetFunction (b3ddll, "bbCollisionNZ")
bbCollisionTime = GetFunction (b3ddll, "bbCollisionTime")
bbCollisionEntity = GetFunction (b3ddll, "bbCollisionEntity")
bbCollisionSurface = GetFunction (b3ddll, "bbCollisionSurface")
bbCollisionTriangle = GetFunction (b3ddll, "bbCollisionTriangle")
bbEntityDistance = GetFunction (b3ddll, "bbEntityDistance")
bbMoveEntity = GetFunction (b3ddll, "bbMoveEntity")
bbTurnEntity = GetFunction (b3ddll, "bbTurnEntity")
bbTranslateEntity = GetFunction (b3ddll, "bbTranslateEntity")
bbPositionEntity = GetFunction (b3ddll, "bbPositionEntity")
bbScaleEntity = GetFunction (b3ddll, "bbScaleEntity")
bbRotateEntity = GetFunction (b3ddll, "bbRotateEntity")
bbPointEntity = GetFunction (b3ddll, "bbPointEntity")
bbAlignToVector = GetFunction (b3ddll, "bbAlignToVector")
bbNameEntity = GetFunction (b3ddll, "bbNameEntity")
bbEntityName = GetFunction (b3ddll, "bbEntityName")
bbEntityClass = GetFunction (b3ddll, "bbEntityClass")
bbClearWorld = GetFunction (b3ddll, "bbClearWorld")
bbSetEntityID = GetFunction (b3ddll, "bbSetEntityID")
bbEntityID = GetFunction (b3ddll, "bbEntityID")
bbActiveTextures = GetFunction (b3ddll, "bbActiveTextures")

; IDE Options = PureBasic v4.02 (Windows - x86)
; CursorPosition = 1254
; FirstLine = 1252
; Folding = -----