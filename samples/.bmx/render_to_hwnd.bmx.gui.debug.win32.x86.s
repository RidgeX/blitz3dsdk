	format	MS COFF
	extrn	_CreateWindowExA@48
	extrn	_DefWindowProcA@16
	extrn	_DispatchMessageA@4
	extrn	_GetClientRect@8
	extrn	_GetMessageA@16
	extrn	_GetModuleHandleA@4
	extrn	_GetStockObject@4
	extrn	_LoadCursorA@8
	extrn	_PeekMessageA@20
	extrn	_RegisterClassA@4
	extrn	_TranslateMessage@4
	extrn	___bb_appstub_appstub
	extrn	___bb_audio_audio
	extrn	___bb_bank_bank
	extrn	___bb_bankstream_bankstream
	extrn	___bb_basic_basic
	extrn	___bb_blitz3dsdk_blitz3dsdk
	extrn	___bb_blitz_blitz
	extrn	___bb_bmploader_bmploader
	extrn	___bb_d3d7max2d_d3d7max2d
	extrn	___bb_d3d9max2d_d3d9max2d
	extrn	___bb_data_data
	extrn	___bb_directsoundaudio_directsoundaudio
	extrn	___bb_eventqueue_eventqueue
	extrn	___bb_freeaudioaudio_freeaudioaudio
	extrn	___bb_freejoy_freejoy
	extrn	___bb_freeprocess_freeprocess
	extrn	___bb_freetypefont_freetypefont
	extrn	___bb_glew_glew
	extrn	___bb_gnet_gnet
	extrn	___bb_jpgloader_jpgloader
	extrn	___bb_macos_macos
	extrn	___bb_map_map
	extrn	___bb_maxlua_maxlua
	extrn	___bb_maxutil_maxutil
	extrn	___bb_oggloader_oggloader
	extrn	___bb_openalaudio_openalaudio
	extrn	___bb_pngloader_pngloader
	extrn	___bb_retro_retro
	extrn	___bb_tgaloader_tgaloader
	extrn	___bb_threads_threads
	extrn	___bb_timer_timer
	extrn	___bb_wavloader_wavloader
	extrn	_bbArrayNew1D
	extrn	_bbBackBuffer
	extrn	_bbBeginBlitz3DEx
	extrn	_bbBrushTexture
	extrn	_bbCameraClsColor
	extrn	_bbColor
	extrn	_bbCreateBrush
	extrn	_bbCreateCamera
	extrn	_bbCreateCube
	extrn	_bbCreateLight
	extrn	_bbCreateTexture
	extrn	_bbEmptyArray
	extrn	_bbEnd
	extrn	_bbFlip
	extrn	_bbGraphics3D
	extrn	_bbMilliSecs
	extrn	_bbNullObject
	extrn	_bbObjectNew
	extrn	_bbOnDebugEnterScope
	extrn	_bbOnDebugEnterStm
	extrn	_bbOnDebugLeaveScope
	extrn	_bbPaintEntity
	extrn	_bbPositionEntity
	extrn	_bbRect
	extrn	_bbRenderWorld
	extrn	_bbScaleTexture
	extrn	_bbSetBuffer
	extrn	_bbStringClass
	extrn	_bbStringConcat
	extrn	_bbStringFromFloat
	extrn	_bbStringFromInt
	extrn	_bbStringToCString
	extrn	_bbTextureBuffer
	extrn	_bbTurnEntity
	extrn	_bbUpdateWorld
	extrn	_bbValidateGraphics
	extrn	_brl_blitz_ArrayBoundsError
	extrn	_brl_blitz_NullObjectError
	extrn	_brl_standardio_Print
	extrn	_pub_win32_MSG
	extrn	_pub_win32_WNDCLASS
	public	__bb_main
	public	_bb_WindowProc
	public	_bb_suspended
	section	"code" code
__bb_main:
	push	ebp
	mov	ebp,esp
	sub	esp,40
	push	ebx
	push	esi
	cmp	dword [_151],0
	je	_152
	mov	eax,0
	pop	esi
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_152:
	mov	dword [_151],1
	mov	dword [ebp-4],_bbNullObject
	mov	dword [ebp-8],0
	mov	dword [ebp-12],0
	mov	dword [ebp-16],_bbEmptyArray
	mov	dword [ebp-20],0
	mov	dword [ebp-24],0
	mov	dword [ebp-28],0
	mov	dword [ebp-32],0
	mov	dword [ebp-36],0
	mov	dword [ebp-40],_bbNullObject
	push	ebp
	push	_136
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	call	___bb_blitz_blitz
	call	___bb_blitz3dsdk_blitz3dsdk
	call	___bb_appstub_appstub
	call	___bb_audio_audio
	call	___bb_bank_bank
	call	___bb_bankstream_bankstream
	call	___bb_basic_basic
	call	___bb_bmploader_bmploader
	call	___bb_d3d7max2d_d3d7max2d
	call	___bb_d3d9max2d_d3d9max2d
	call	___bb_data_data
	call	___bb_directsoundaudio_directsoundaudio
	call	___bb_eventqueue_eventqueue
	call	___bb_freeaudioaudio_freeaudioaudio
	call	___bb_freetypefont_freetypefont
	call	___bb_gnet_gnet
	call	___bb_jpgloader_jpgloader
	call	___bb_map_map
	call	___bb_maxlua_maxlua
	call	___bb_maxutil_maxutil
	call	___bb_oggloader_oggloader
	call	___bb_openalaudio_openalaudio
	call	___bb_pngloader_pngloader
	call	___bb_retro_retro
	call	___bb_tgaloader_tgaloader
	call	___bb_threads_threads
	call	___bb_timer_timer
	call	___bb_wavloader_wavloader
	call	___bb_freejoy_freejoy
	call	___bb_freeprocess_freeprocess
	call	___bb_glew_glew
	call	___bb_macos_macos
	push	_47
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	_49
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	_pub_win32_WNDCLASS
	call	_bbObjectNew
	add	esp,4
	mov	dword [ebp-4],eax
	push	_51
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_53
	call	_brl_blitz_NullObjectError
_53:
	mov	dword [ebx+8],35
	push	_55
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_57
	call	_brl_blitz_NullObjectError
_57:
	mov	dword [ebx+12],_bb_WindowProc
	push	_59
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_61
	call	_brl_blitz_NullObjectError
_61:
	push	0
	call	_GetModuleHandleA@4
	mov	dword [ebx+24],eax
	push	_63
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_65
	call	_brl_blitz_NullObjectError
_65:
	push	_25
	call	_bbStringToCString
	add	esp,4
	mov	dword [ebx+44],eax
	push	_67
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_69
	call	_brl_blitz_NullObjectError
_69:
	mov	eax,32512
	push	eax
	push	0
	call	_LoadCursorA@8
	mov	dword [ebx+32],eax
	push	_71
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,dword [ebp-4]
	cmp	ebx,_bbNullObject
	jne	_73
	call	_brl_blitz_NullObjectError
_73:
	push	4
	call	_GetStockObject@4
	mov	dword [ebx+36],eax
	push	_75
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [ebp-4]
	lea	eax,dword [eax+8]
	push	eax
	call	_RegisterClassA@4
	push	_76
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	dword [ebp-8],281542656
	push	_78
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	0
	push	0
	push	0
	push	0
	push	666
	push	777
	push	0
	push	0
	push	dword [ebp-8]
	push	_26
	call	_bbStringToCString
	add	esp,4
	push	eax
	push	_25
	call	_bbStringToCString
	add	esp,4
	push	eax
	push	0
	call	_CreateWindowExA@48
	mov	dword [ebp-12],eax
	push	_80
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	0
	push	dword [ebp-12]
	call	_bbBeginBlitz3DEx
	add	esp,8
	push	_81
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	4
	push	_82
	call	_bbArrayNew1D
	add	esp,8
	mov	dword [ebp-16],eax
	push	_84
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [ebp-16]
	lea	eax,dword [eax+24]
	push	eax
	push	dword [ebp-12]
	call	_GetClientRect@8
	push	_85
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,2
	mov	eax,dword [ebp-16]
	cmp	ebx,dword [eax+20]
	jb	_87
	call	_brl_blitz_ArrayBoundsError
_87:
	mov	esi,3
	mov	eax,dword [ebp-16]
	cmp	esi,dword [eax+20]
	jb	_89
	call	_brl_blitz_ArrayBoundsError
_89:
	push	2
	push	0
	mov	eax,dword [ebp-16]
	push	dword [eax+esi*4+24]
	mov	eax,dword [ebp-16]
	push	dword [eax+ebx*4+24]
	call	_bbGraphics3D
	add	esp,16
	push	_90
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1
	push	0
	push	64
	push	64
	call	_bbCreateTexture
	add	esp,16
	mov	dword [ebp-20],eax
	push	_92
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1040187392
	push	1040187392
	push	dword [ebp-20]
	call	_bbScaleTexture
	add	esp,12
	push	_93
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	0
	push	dword [ebp-20]
	call	_bbTextureBuffer
	add	esp,8
	push	eax
	call	_bbSetBuffer
	add	esp,4
	push	_94
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	255
	push	192
	push	64
	call	_bbColor
	add	esp,12
	push	_95
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1
	push	32
	push	32
	push	0
	push	32
	call	_bbRect
	add	esp,20
	push	_96
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1
	push	32
	push	32
	push	32
	push	0
	call	_bbRect
	add	esp,20
	push	_97
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	255
	push	255
	push	255
	call	_bbColor
	add	esp,12
	push	_98
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1
	push	32
	push	32
	push	0
	push	0
	call	_bbRect
	add	esp,20
	push	_99
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1
	push	32
	push	32
	push	32
	push	32
	call	_bbRect
	add	esp,20
	push	_100
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	_bbBackBuffer
	push	eax
	call	_bbSetBuffer
	add	esp,4
	push	_101
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	255
	push	255
	push	255
	call	_bbColor
	add	esp,12
	push	_102
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1132396544
	push	1132396544
	push	1132396544
	call	_bbCreateBrush
	add	esp,12
	mov	dword [ebp-24],eax
	push	_104
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	0
	push	0
	push	dword [ebp-20]
	push	dword [ebp-24]
	call	_bbBrushTexture
	add	esp,16
	push	_105
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	0
	call	_bbCreateCamera
	add	esp,4
	mov	dword [ebp-28],eax
	push	_107
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1132396544
	push	0
	push	1124073472
	push	dword [ebp-28]
	call	_bbCameraClsColor
	add	esp,16
	push	_108
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	0
	push	-1061158912
	push	0
	push	0
	push	dword [ebp-28]
	call	_bbPositionEntity
	add	esp,20
	push	_109
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	0
	push	0
	call	_bbCreateLight
	add	esp,8
	mov	dword [ebp-32],eax
	push	_111
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	0
	push	0
	push	1110704128
	push	1110704128
	push	dword [ebp-32]
	call	_bbTurnEntity
	add	esp,20
	push	_112
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	0
	call	_bbCreateCube
	add	esp,4
	mov	dword [ebp-36],eax
	push	_114
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	dword [ebp-24]
	push	dword [ebp-36]
	call	_bbPaintEntity
	add	esp,8
	push	_115
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
_29:
_27:
	push	ebp
	push	_133
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_116
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	_pub_win32_MSG
	call	_bbObjectNew
	add	esp,4
	mov	dword [ebp-40],eax
	push	_118
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
_32:
	push	ebp
	push	_128
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_119
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	jmp	_33
_35:
	push	ebp
	push	_123
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_120
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	0
	push	0
	push	0
	mov	eax,dword [ebp-40]
	lea	eax,dword [eax+8]
	push	eax
	call	_GetMessageA@16
	push	_121
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [ebp-40]
	lea	eax,dword [eax+8]
	push	eax
	call	_TranslateMessage@4
	push	_122
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [ebp-40]
	lea	eax,dword [eax+8]
	push	eax
	call	_DispatchMessageA@4
	call	dword [_bbOnDebugLeaveScope]
_33:
	cmp	dword [_bb_suspended],0
	jne	_35
_34:
	push	_124
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	jmp	_36
_38:
	push	ebp
	push	_127
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_125
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [ebp-40]
	lea	eax,dword [eax+8]
	push	eax
	call	_TranslateMessage@4
	push	_126
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [ebp-40]
	lea	eax,dword [eax+8]
	push	eax
	call	_DispatchMessageA@4
	call	dword [_bbOnDebugLeaveScope]
_36:
	push	1
	push	0
	push	0
	push	0
	mov	eax,dword [ebp-40]
	lea	eax,dword [eax+8]
	push	eax
	call	_PeekMessageA@20
	cmp	eax,0
	jne	_38
_37:
	call	dword [_bbOnDebugLeaveScope]
_30:
	cmp	dword [_bb_suspended],0
	jne	_32
_31:
	push	_129
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	0
	push	0
	push	1077936128
	push	0
	push	dword [ebp-36]
	call	_bbTurnEntity
	add	esp,20
	push	_130
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1065353216
	call	_bbUpdateWorld
	add	esp,4
	push	_131
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1065353216
	call	_bbRenderWorld
	add	esp,4
	push	_132
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	1
	call	_bbFlip
	add	esp,4
	call	dword [_bbOnDebugLeaveScope]
	jmp	_29
_bb_WindowProc:
	push	ebp
	mov	ebp,esp
	sub	esp,24
	push	ebx
	mov	eax,dword [ebp+8]
	mov	dword [ebp-4],eax
	mov	eax,dword [ebp+12]
	mov	dword [ebp-8],eax
	mov	eax,dword [ebp+16]
	mov	dword [ebp-12],eax
	mov	eax,dword [ebp+20]
	mov	dword [ebp-16],eax
	mov	dword [ebp-20],0
	push	ebp
	push	_200
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_153
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [ebp-8]
	cmp	eax,15
	je	_156
	cmp	eax,20
	je	_157
	cmp	eax,28
	je	_158
	cmp	eax,256
	je	_159
	cmp	eax,512
	je	_160
	cmp	eax,16
	je	_161
	jmp	_155
_156:
	push	ebp
	push	_184
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_162
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	_bbValidateGraphics
	mov	dword [ebp-20],eax
	push	_164
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [_166]
	and	eax,1
	cmp	eax,0
	jne	_167
	call	_bbMilliSecs
	mov	dword [_165],eax
	or	dword [_166],1
_167:
	push	_168
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	_bbMilliSecs
	sub	eax,dword [_165]
	mov	dword [ebp+-24],eax
	fild	dword [ebp+-24]
	fdiv	dword [_216]
	sub	esp,4
	fstp	dword [esp]
	call	_bbStringFromFloat
	add	esp,4
	push	eax
	push	_23
	push	dword [ebp-20]
	call	_bbStringFromInt
	add	esp,4
	push	eax
	push	_22
	call	_bbStringConcat
	add	esp,8
	push	eax
	call	_bbStringConcat
	add	esp,8
	push	eax
	call	_bbStringConcat
	add	esp,8
	push	eax
	call	_brl_standardio_Print
	add	esp,4
	push	_169
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [ebp-20]
	cmp	eax,0
	je	_172
	cmp	eax,-1
	je	_173
	push	ebp
	push	_178
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_174
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	cmp	dword [_bb_suspended],0
	je	_175
	push	ebp
	push	_177
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_176
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	0
	call	_bbFlip
	add	esp,4
	call	dword [_bbOnDebugLeaveScope]
_175:
	call	dword [_bbOnDebugLeaveScope]
	jmp	_171
_172:
	push	ebp
	push	_180
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_179
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	dword [_bb_suspended],1
	call	dword [_bbOnDebugLeaveScope]
	jmp	_171
_173:
	push	ebp
	push	_183
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_181
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	_24
	call	_brl_standardio_Print
	add	esp,4
	push	_182
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	_bbEnd
	call	dword [_bbOnDebugLeaveScope]
	jmp	_171
_171:
	call	dword [_bbOnDebugLeaveScope]
	jmp	_155
_157:
	push	ebp
	push	_188
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_187
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	ebx,1
	call	dword [_bbOnDebugLeaveScope]
	jmp	_45
_158:
	push	ebp
	push	_190
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_189
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	mov	eax,dword [ebp-12]
	cmp	eax,0
	sete	al
	movzx	eax,al
	mov	dword [_bb_suspended],eax
	call	dword [_bbOnDebugLeaveScope]
	jmp	_155
_159:
	push	ebp
	push	_195
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_191
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	cmp	dword [ebp-12],27
	jne	_192
	push	ebp
	push	_194
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_193
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	_bbEnd
	call	dword [_bbOnDebugLeaveScope]
_192:
	call	dword [_bbOnDebugLeaveScope]
	jmp	_155
_160:
	push	ebp
	push	_196
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	call	dword [_bbOnDebugLeaveScope]
	jmp	_155
_161:
	push	ebp
	push	_198
	call	dword [_bbOnDebugEnterScope]
	add	esp,8
	push	_197
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	call	_bbEnd
	call	dword [_bbOnDebugLeaveScope]
	jmp	_155
_155:
	push	_199
	call	dword [_bbOnDebugEnterStm]
	add	esp,4
	push	dword [ebp-16]
	push	dword [ebp-12]
	push	dword [ebp-8]
	push	dword [ebp-4]
	call	_DefWindowProcA@16
	mov	ebx,eax
	jmp	_45
_45:
	call	dword [_bbOnDebugLeaveScope]
	mov	eax,ebx
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
	section	"data" data writeable align 8
	align	4
_151:
	dd	0
_137:
	db	"render_to_hwnd",0
_138:
	db	"suspended",0
_139:
	db	"i",0
	align	4
_bb_suspended:
	dd	0
_140:
	db	"wndclass",0
_141:
	db	":pub.win32.WNDCLASS",0
_142:
	db	"ws",0
_143:
	db	"window",0
_144:
	db	"rect",0
_145:
	db	"[]i",0
_146:
	db	"tex",0
_147:
	db	"brush",0
_148:
	db	"camera",0
_149:
	db	"light",0
_150:
	db	"cube",0
	align	4
_136:
	dd	1
	dd	_137
	dd	4
	dd	_138
	dd	_139
	dd	_bb_suspended
	dd	2
	dd	_140
	dd	_141
	dd	-4
	dd	2
	dd	_142
	dd	_139
	dd	-8
	dd	2
	dd	_143
	dd	_139
	dd	-12
	dd	2
	dd	_144
	dd	_145
	dd	-16
	dd	2
	dd	_146
	dd	_139
	dd	-20
	dd	2
	dd	_147
	dd	_139
	dd	-24
	dd	2
	dd	_148
	dd	_139
	dd	-28
	dd	2
	dd	_149
	dd	_139
	dd	-32
	dd	2
	dd	_150
	dd	_139
	dd	-36
	dd	0
_48:
	db	"C:/b3dsdk/samples/render_to_hwnd.bmx",0
	align	4
_47:
	dd	_48
	dd	28
	dd	1
	align	4
_49:
	dd	_48
	dd	74
	dd	1
	align	4
_51:
	dd	_48
	dd	75
	dd	1
	align	4
_55:
	dd	_48
	dd	76
	dd	1
	align	4
_59:
	dd	_48
	dd	77
	dd	1
	align	4
_63:
	dd	_48
	dd	78
	dd	1
	align	4
_25:
	dd	_bbStringClass
	dd	2147483647
	dd	9
	dw	77,121,32,67,108,97,115,115,33
	align	4
_67:
	dd	_48
	dd	79
	dd	1
	align	4
_71:
	dd	_48
	dd	80
	dd	1
	align	4
_75:
	dd	_48
	dd	81
	dd	1
	align	4
_76:
	dd	_48
	dd	84
	dd	1
	align	4
_78:
	dd	_48
	dd	85
	dd	1
	align	4
_26:
	dd	_bbStringClass
	dd	2147483647
	dd	10
	dw	77,121,32,87,105,110,100,111,119,33
	align	4
_80:
	dd	_48
	dd	88
	dd	1
	align	4
_81:
	dd	_48
	dd	94
	dd	1
_82:
	db	"i",0
	align	4
_84:
	dd	_48
	dd	95
	dd	1
	align	4
_85:
	dd	_48
	dd	96
	dd	1
	align	4
_90:
	dd	_48
	dd	99
	dd	1
	align	4
_92:
	dd	_48
	dd	100
	dd	1
	align	4
_93:
	dd	_48
	dd	101
	dd	1
	align	4
_94:
	dd	_48
	dd	102
	dd	1
	align	4
_95:
	dd	_48
	dd	102
	dd	20
	align	4
_96:
	dd	_48
	dd	102
	dd	38
	align	4
_97:
	dd	_48
	dd	103
	dd	1
	align	4
_98:
	dd	_48
	dd	103
	dd	21
	align	4
_99:
	dd	_48
	dd	103
	dd	38
	align	4
_100:
	dd	_48
	dd	104
	dd	1
	align	4
_101:
	dd	_48
	dd	105
	dd	1
	align	4
_102:
	dd	_48
	dd	106
	dd	1
	align	4
_104:
	dd	_48
	dd	107
	dd	1
	align	4
_105:
	dd	_48
	dd	110
	dd	1
	align	4
_107:
	dd	_48
	dd	111
	dd	1
	align	4
_108:
	dd	_48
	dd	112
	dd	1
	align	4
_109:
	dd	_48
	dd	115
	dd	1
	align	4
_111:
	dd	_48
	dd	116
	dd	1
	align	4
_112:
	dd	_48
	dd	119
	dd	1
	align	4
_114:
	dd	_48
	dd	120
	dd	1
	align	4
_115:
	dd	_48
	dd	143
	dd	1
_134:
	db	"msg",0
_135:
	db	":pub.win32.MSG",0
	align	4
_133:
	dd	3
	dd	0
	dd	2
	dd	_134
	dd	_135
	dd	-40
	dd	0
	align	4
_116:
	dd	_48
	dd	123
	dd	2
	align	4
_118:
	dd	_48
	dd	134
	dd	2
	align	4
_128:
	dd	3
	dd	0
	dd	0
	align	4
_119:
	dd	_48
	dd	125
	dd	3
	align	4
_123:
	dd	3
	dd	0
	dd	0
	align	4
_120:
	dd	_48
	dd	126
	dd	4
	align	4
_121:
	dd	_48
	dd	127
	dd	4
	align	4
_122:
	dd	_48
	dd	128
	dd	4
	align	4
_124:
	dd	_48
	dd	130
	dd	3
	align	4
_127:
	dd	3
	dd	0
	dd	0
	align	4
_125:
	dd	_48
	dd	131
	dd	4
	align	4
_126:
	dd	_48
	dd	132
	dd	4
	align	4
_129:
	dd	_48
	dd	138
	dd	2
	align	4
_130:
	dd	_48
	dd	139
	dd	2
	align	4
_131:
	dd	_48
	dd	140
	dd	2
	align	4
_132:
	dd	_48
	dd	141
	dd	2
_201:
	db	"WindowProc",0
_202:
	db	"hwnd",0
_203:
	db	"wparam",0
_204:
	db	"lparam",0
	align	4
_200:
	dd	1
	dd	_201
	dd	2
	dd	_202
	dd	_139
	dd	-4
	dd	2
	dd	_134
	dd	_139
	dd	-8
	dd	2
	dd	_203
	dd	_139
	dd	-12
	dd	2
	dd	_204
	dd	_139
	dd	-16
	dd	0
	align	4
_153:
	dd	_48
	dd	31
	dd	2
_185:
	db	"n",0
_186:
	db	"base_ms",0
	align	4
_165:
	dd	0
	align	4
_184:
	dd	3
	dd	0
	dd	2
	dd	_185
	dd	_139
	dd	-20
	dd	4
	dd	_186
	dd	_139
	dd	_165
	dd	0
	align	4
_162:
	dd	_48
	dd	33
	dd	3
	align	4
_164:
	dd	_48
	dd	36
	dd	3
	align	4
_166:
	dd	0
	align	4
_168:
	dd	_48
	dd	37
	dd	3
	align	4
_216:
	dd	0x447a0000
	align	4
_23:
	dd	_bbStringClass
	dd	2147483647
	dd	6
	dw	32,116,105,109,101,61
	align	4
_22:
	dd	_bbStringClass
	dd	2147483647
	dd	18
	dw	87,77,95,80,65,73,78,84,58,86,97,108,105,100,97,116
	dw	101,61
	align	4
_169:
	dd	_48
	dd	39
	dd	3
	align	4
_178:
	dd	3
	dd	0
	dd	0
	align	4
_174:
	dd	_48
	dd	52
	dd	4
	align	4
_177:
	dd	3
	dd	0
	dd	0
	align	4
_176:
	dd	_48
	dd	55
	dd	5
	align	4
_180:
	dd	3
	dd	0
	dd	0
	align	4
_179:
	dd	_48
	dd	43
	dd	4
	align	4
_183:
	dd	3
	dd	0
	dd	0
	align	4
_181:
	dd	_48
	dd	47
	dd	4
	align	4
_24:
	dd	_bbStringClass
	dd	2147483647
	dd	22
	dw	70,65,84,65,76,32,71,82,65,80,72,73,67,83,32,80
	dw	82,79,66,76,69,77
	align	4
_182:
	dd	_48
	dd	48
	dd	4
	align	4
_188:
	dd	3
	dd	0
	dd	0
	align	4
_187:
	dd	_48
	dd	59
	dd	3
	align	4
_190:
	dd	3
	dd	0
	dd	0
	align	4
_189:
	dd	_48
	dd	61
	dd	3
	align	4
_195:
	dd	3
	dd	0
	dd	0
	align	4
_191:
	dd	_48
	dd	64
	dd	3
	align	4
_194:
	dd	3
	dd	0
	dd	0
	align	4
_193:
	dd	_48
	dd	64
	dd	16
	align	4
_196:
	dd	3
	dd	0
	dd	0
	align	4
_198:
	dd	3
	dd	0
	dd	0
	align	4
_197:
	dd	_48
	dd	68
	dd	3
	align	4
_199:
	dd	_48
	dd	70
	dd	2
