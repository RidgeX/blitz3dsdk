
; RUN IN DEBUG MODE TO SEE OUTPUT!

IncludeFile "../../include/blitz3dsdk.pbi"

; This function receives an error string from the Blitz3D SDK, passed
; via the bbSetBlitz3DDebugCallback function below...

ProcedureC ErrorHandler (*err)

    ; -------------------------------------
    ; Required!
    ; -------------------------------------

	If *err
	    error$ = PeekS (PeekL (@*err)) ; The error message from Blitz3D SDK
	EndIf

    ; -------------------------------------
    ; Do what you want with error$ here:
    ; -------------------------------------
    
	custom$ = "Espèce d'idiot!!! Blitz3D says:" + Chr (10) + Chr (10) + Chr (34) + error$ + "!" + Chr (34)
	MessageRequester ("Custom PureBasic error message!", custom$, #MB_ICONWARNING)

    ; -------------------------------------
    ; Required!
    ; -------------------------------------
    
	End ; You MUST call this here!

EndProcedure

; Set the debug callback function to receive the error string from Blitz3D SDK...

bbSetBlitz3DDebugCallback (@ErrorHandler ())

bbBeginBlitz3D ()

; Deliberate error!

gfx$ = PeekS (bbGfxDriverName (-99)) ; This is stupid...

Debug gfx$

bbEndBlitz3D ()

; IDE Options = PureBasic 4.20 (Windows - x86)
; CursorPosition = 3
; Folding = -
; EnableXP