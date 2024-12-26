
#include "dxstd.h"
#include "dxruntime.h"
#include "dxinput.h"
#include "dxtimer.h"
#include "dxaudio.h"

#include "zmouse.h"

//#include <dxfile.h>
#include <windows.h>

//#define SPI_SETMOUSESPEED	113

//#include <brl.mod/blitz.mod/blitz.h>

extern "C" void bbEndBlitz3D();

static void CALLBACK timerCallback( UINT id,UINT msg,DWORD user,DWORD dw1,DWORD dw2 );

int (_cdecl *eventCallback)(int,int,int,int);

class dxAudio;

class gxAudio *gx_audio;

struct dxRuntime::GfxMode{
	DDSURFACEDESC2 desc;
};
struct dxRuntime::GfxDriver{
	GUID *guid;
	std::string name;
	std::vector<GfxMode*> modes;
#ifdef PRO
	D3DDEVICEDESC7 d3d_desc;
#endif
	DWORD hertz;
//	DWORD deviceid;
	HMONITOR hmonitor;
	int xpos,ypos;
};

#ifndef _LIB

const IID IID_IDirectDraw={0x6C14DB80,0xA733,0x11CE,{0xA5,0x21,0x00,0x20,0xAF,0x0B,0xE5,0x60}};
const IID IID_IDirectDraw7={0x15e65ec0,0x3b9c,0x11d2,{0xb9,0x2f,0x00,0x60,0x97,0x97,0xea,0x5b}};
const IID IID_IDirectDrawGammaControl={0x69C11C3E,0xB46B,0x11D1,{0xAD,0x7A,0x00,0xC0,0x4F,0xC2,0x9B,0x4E}};

const IID IID_IDirect3D={0x3BBA0080,0x2421,0x11CF,{0xA3,0x1A,0x00,0xAA,0x00,0xB9,0x33,0x56}};
const IID IID_IDirect3D7={0xf5049e77,0x4861,0x11d2,{0xa4,0x7,0x0,0xa0,0xc9,0x6,0x29,0xa8}};
const IID IID_IDirect3DRGBDevice={0xA4665C60,0x2673,0x11CF,{0xA3,0x1A,0x00,0xAA,0x00,0xB9,0x33,0x56}};
const IID IID_IDirect3DHALDevice={0x84E63dE0,0x46AA,0x11CF,{0x81,0x6F,0x00,0x00,0xC0,0x20,0x15,0x6E}};
const IID IID_IDirect3DTnLHalDevice={0xf5049e78,0x4861,0x11d2,{0xa4,0x07,0x00,0xa0,0xc9,0x6,0x29,0xa8}};

GUID_EXT const GUID MSPID_PrimaryVideo GUID_SECT =         {0xa35ff56a,0x9fda,0x11d0,{0x8f,0xdf,0x00,0xc0,0x4f,0xd9,0x18,0x9d}};
GUID_EXT const GUID IID_IDirectDrawSurface GUID_SECT =     {0x6C14DB81,0xA733,0x11CE,{0xA5,0x21,0x00,0x20,0xAF,0x0B,0xE5,0x60}};
GUID_EXT const GUID IID_IDirectDrawMediaStream GUID_SECT = {0xF4104FCE,0x9A70,0x11d0,{0x8F,0xDE,0x00,0xC0,0x4F,0xD9,0x18,0x9D}};

GUID_EXT const GUID IID_IDirectXFileData GUID_SECT       =    {0x3d82ab44,0x62da,0x11cf,{0xab,0x39,0x0,0x20,0xaf,0x71,0xe4,0x33}};
GUID_EXT const GUID IID_IDirectXFileDataReference GUID_SECT       =    {0x3d82ab45,0x62da,0x11cf,{0xab,0x39,0x0,0x20,0xaf,0x71,0xe4,0x33}};

GUID_EXT const GUID TID_D3DRMFrame GUID_SECT=       {0x3d82ab46,0x62da,0x11cf,{0xab,0x39,0x0,0x20,0xaf,0x71,0xe4,0x33}};
GUID_EXT const GUID TID_D3DRMAnimation GUID_SECT=   {0x3d82ab4f,0x62da,0x11cf,{0xab,0x39,0x0,0x20,0xaf,0x71,0xe4,0x33}};
GUID_EXT const GUID TID_D3DRMAnimationKey GUID_SECT={0x10dd46a8,0x775b,0x11cf,{0x8f,0x52,0x0,0x40,0x33,0x35,0x94,0xA3}};
GUID_EXT const GUID TID_D3DRMMesh GUID_SECT=        {0x3d82ab44,0x62da,0x11cf,{0xab,0x39,0x0,0x20,0xaf,0x71,0xe4,0x33}};

GUID_EXT const GUID TID_D3DRMMaterial GUID_SECT=        {0x3d82ab4d,0x62da,0x11cf,{0xab,0x39,0x0,0x20,0xaf,0x71,0xe4,0x33}};
GUID_EXT const GUID TID_D3DRMMeshMaterialList GUID_SECT={0xf6f23f42,0x7686,0x11cf,{0x8f, 0x52, 0x0, 0x40, 0x33, 0x35, 0x94, 0xa3}};

GUID_EXT const GUID TID_D3DRMTextureFilename GUID_SECT={0xa42790e1, 0x7810, 0x11cf,{ 0x8f, 0x52, 0x0, 0x40, 0x33, 0x35, 0x94, 0xa3}};

GUID_EXT const GUID TID_D3DRMMeshTextureCoords GUID_SECT={0xf6f23f40, 0x7686, 0x11cf,{ 0x8f, 0x52, 0x0, 0x40, 0x33, 0x35, 0x94, 0xa3}};
GUID_EXT const GUID TID_D3DRMMeshVertexColors GUID_SECT={0x1630b821, 0x7842, 0x11cf,{ 0x8f, 0x52, 0x0, 0x40, 0x33, 0x35, 0x94, 0xa3}};
GUID_EXT const GUID TID_D3DRMMeshNormals GUID_SECT={0xf6f23f43, 0x7686, 0x11cf,{ 0x8f, 0x52, 0x0, 0x40, 0x33, 0x35, 0x94, 0xa3}};
GUID_EXT const GUID TID_D3DRMFrameTransformMatrix GUID_SECT={0xf6f23f41, 0x7686, 0x11cf,{ 0x8f, 0x52, 0x0, 0x40, 0x33, 0x35, 0x94, 0xa3}};
GUID_EXT const GUID TID_D3DRMAnimationSet GUID_SECT={0x3d82ab50, 0x62da, 0x11cf,{ 0xab, 0x39, 0x0, 0x20, 0xaf, 0x71, 0xe4, 0x33}};

#endif

int (__stdcall *directdrawcreateex) (GUID FAR * lpGuid, LPVOID  *lplpDD, REFIID  iid,IUnknown FAR *pUnkOuter);
int (__stdcall *directdrawenumerateex) (LPDDENUMCALLBACKEXA lpCallback, LPVOID lpContext, DWORD dwFlags);

static const int static_ws=WS_VISIBLE|WS_CAPTION|WS_SYSMENU|WS_MINIMIZEBOX;
static const int scaled_ws=WS_VISIBLE|WS_CAPTION|WS_SYSMENU|WS_SIZEBOX|WS_MINIMIZEBOX|WS_MAXIMIZEBOX;
static const int child_ws=WS_VISIBLE|WS_CHILD;
static const int reused_ws=0;

static string app_title;
static string app_close;
static dxRuntime *runtime;
static bool busy,suspended;
static volatile bool run_flag;
static DDSURFACEDESC2 desktop_desc;

typedef int (_stdcall *LibFunc)( const void *in,int in_sz,void *out,int out_sz );

struct gxDll{
	HINSTANCE hinst;
	map<string,LibFunc> funcs;
};

static map<string,gxDll*> libs;

static LRESULT CALLBACK windowProc( HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam );

//current gfx mode
//
//0=NONE
//1=SCALED WINDOW
//2=FIXED SIZE WINDOW
//3=EXCLUSIVE
//4=REUSE WINDOW   -   new for MAXGUI
//
static int gfx_mode;
static bool gfx_lost;
static bool auto_suspend;

//for modes 1 and 2 and 4
static int mod_cnt;
static MMRESULT timerID;
static IDirectDrawClipper *clipper;
static IDirectDrawSurface7 *primSurf;
//static Debugger *debugger;

static set<dxTimer*> timers;

enum{
	WM_STOP=WM_USER+10,WM_RUN,WM_END
};

////////////////////
// STATIC STARTUP //
////////////////////

gxRuntime *dxRuntime::openRuntime( int parenthwnd,int (_cdecl *event_handler)(int,int,int,int) ){	//,Debugger *d ){
	if( runtime ) return 0;

	CoInitialize( 0 );
/*
	TIMECAPS tc;
	timeGetDevCaps( &tc,sizeof(tc) );
	timeBeginPeriod( tc.wPeriodMin );
*/
	string cmdline("");
//	while( params.size() && params[0]==' ' ) params=params.substr( 1 );
//	while( params.size() && params[params.size()-1]==' ' ) params=params.substr( 0,params.size()-1 );

	HINSTANCE hinst=GetModuleHandle(0);

	HMODULE ddrawlib=LoadLibrary("ddraw");
	if (ddrawlib==0) return 0;
	directdrawcreateex=(int(__stdcall *)(GUID FAR * lpGuid, LPVOID  *lplpDD, REFIID  iid,IUnknown FAR *pUnkOuter))GetProcAddress(ddrawlib,"DirectDrawCreateEx");
	directdrawenumerateex=(int(__stdcall *)(LPDDENUMCALLBACKEXA lpCallback, LPVOID lpContext, DWORD dwFlags))GetProcAddress(ddrawlib,"DirectDrawEnumerateExA");
	if (directdrawcreateex==0) return 0;
	if (directdrawenumerateex==0) return 0;

//create debugger
//	debugger=d;

	//create WNDCLASS

	WNDCLASS wndclass;
	memset(&wndclass,0,sizeof(wndclass));
	wndclass.style=CS_HREDRAW|CS_VREDRAW|CS_OWNDC;
	wndclass.lpfnWndProc=::windowProc;
	wndclass.hInstance=hinst;
	wndclass.lpszClassName="Blitz Runtime Class";
	wndclass.hCursor=(HCURSOR)LoadCursor( 0,IDC_ARROW );
	wndclass.hbrBackground=(HBRUSH)GetStockObject( BLACK_BRUSH );
	RegisterClass( &wndclass );

	gfx_mode=0;
	clipper=0;
	primSurf=0;
	busy=true;
	suspended=false;
	run_flag=true;

	const char *app_t=" ";
	int ws=WS_CAPTION|WS_VISIBLE,ws_ex=0;

	HWND hwnd_parent=(HWND)parenthwnd;
	eventCallback=event_handler;

	if (parenthwnd){
		ws=ws|WS_CHILD;
	}

//	HWND hwnd=CreateWindowEx( ws_ex,"Blitz Runtime Class",app_t,ws,CW_USEDEFAULT,CW_USEDEFAULT,400,200,hwnd_parent,0,0,0 );	//CW_USEDEFAULT,CW_USEDEFAULT,300,200 -32768,-32768
	HWND hwnd=CreateWindowEx( ws_ex,"Blitz Runtime Class",app_t,ws,-32768,-32768,400,200,hwnd_parent,0,0,0 );	//CW_USEDEFAULT,CW_USEDEFAULT,300,200 -32768,-32768

	UpdateWindow( hwnd );

	runtime=d_new dxRuntime( hinst,cmdline,hwnd );

	busy=false;
	return runtime;
}



/*

HRESULT WINAPI DirectInputCreateEx(
  HINSTANCE hinst,DWORD dwVersion,REFIID riidltf,LPVOID * ppvOut,LPUNKNOWN punkOuter  
);

int (__stdcall *directinputcreateex) (HINSTANCE hinst,DWORD dwVersion,REFIID riidltf,LPVOID * ppvOut,LPUNKNOWN punkOuter)=0;
*/

gxInput *dxRuntime::openInput( int flags ){
	if( dxinput ) return 0;
	IDirectInput7 *di;

/*
	if (directinputcreateex==0){
		HMODULE dinputlib=LoadLibraryA("dinput");
		if (dinputlib==0) return 0;
		directinputcreateex=(int(__stdcall *)(HINSTANCE hinst,DWORD dwVersion,REFIID riidltf,LPVOID * ppvOut,LPUNKNOWN punkOuter))
			GetProcAddress(dinputlib,"DirectInputCreateEx");
		if (directinputcreateex==0) return 0;
	}
*/
	//_DirectInputCreateEx@20 referenced in function "public: virtual class gxInput * __thiscall dxRuntime::openInput(int)" (?openInput@dxRuntime@@UAEPAVgxInput@@H@Z)
//dxruntime.lib(dxinput.obj) : error LNK2001: unresolved external symbol _c_dfDIKeyboard
//dxruntime.lib(dxinput.obj) : error LNK2001: unresolved external symbol _c_dfDIMouse
//dxruntime.lib(dxinput.obj) : error LNK2001: unresolved external symbol _c_dfDIJoystick

//	if( directinputcreateex( hinst,DIRECTINPUT_VERSION,IID_IDirectInput7,(void**)&di,0 )>=0 ){	//DirectInputCreateEx
	if( DirectInputCreateEx( hinst,DIRECTINPUT_VERSION,IID_IDirectInput7,(void**)&di,0 )>=0 ){	//DirectInputCreateEx
		dxinput=d_new dxInput( this,di );
		acquireInput();
	}else{
//		debugInfo( "Create DirectInput failed" );
	}
	return dxinput;
}

void dxRuntime::closeInput( gxInput *i ){
	if( !dxinput || dxinput!=i ) return;
	unacquireInput();
	delete dxinput;
	dxinput=0;
}

void dxRuntime::closeRuntime( gxRuntime *r ){
	if( !runtime || runtime!=(dxRuntime*)r ) return;

	map<string,gxDll*>::const_iterator it;
	for( it=libs.begin();it!=libs.end();++it ){
		FreeLibrary( it->second->hinst );
	}
	libs.clear();

	delete runtime;
	runtime=0;
/*
	TIMECAPS tc;
	timeGetDevCaps( &tc,sizeof(tc) );
	timeEndPeriod( tc.wPeriodMin );
*/
	CoUninitialize();
}

void dxRuntime::acquireInput(){
	if( !dxinput ) return;
	if( gfx_mode==3 ){
		if( use_di ){
			use_di=dxinput->acquire();
		}else{
		}
	}
	dxinput->reset();
}

void dxRuntime::unacquireInput(){
	if( !dxinput ) return;
	if( gfx_mode==3 && use_di ) dxinput->unacquire();
	dxinput->reset();
}

//////////////////////////
// RUNTIME CONSTRUCTION //
//////////////////////////
dxRuntime::dxRuntime( HINSTANCE hi,const string &cl,HWND hw ):
hinst(hi),cmd_line(cl),hwnd(hw),curr_driver(0),enum_all(false),
pointer_visible(true),graphics(0),use_di(false),dxinput(0),audio(0){		//fileSystem(0),audio(0),input(0),

//	CoInitialize( 0 );

//	use_di=true;

	enumGfx();

	audio=(dxAudio*)openAudio(0);
}

dxRuntime::~dxRuntime(){
	while( timers.size() ) freeTimer( *timers.begin() );
	if( audio ) closeAudio( audio );
	if( graphics ) closeGraphics( graphics );
//	if( input ) closeInput( input );
/*
	TIMECAPS tc;
	timeGetDevCaps( &tc,sizeof(tc) );
	timeEndPeriod( tc.wPeriodMin );
*/
	denumGfx();
	DestroyWindow( hwnd );
	UnregisterClass( "Blitz Runtime Class",hinst );
//	CoUninitialize();
}

/*

void dxRuntime::pauseAudio(){
	if( audio ) audio->pause();
}

void dxRuntime::resumeAudio(){
	if( audio ) audio->resume();
}

void dxRuntime::resetInput(){
	if( input ) input->reset();
}


*/

void dxRuntime::backupGraphics(){
	if( auto_suspend ){
		graphics->backup();
	}
}

void dxRuntime::restoreGraphics(){
	if( auto_suspend ){
		if( !graphics->restore() ) gfx_lost=true;
	}
}

/////////////
// SUSPEND //
/////////////
void dxRuntime::suspend(){
	busy=true;
//	pauseAudio();
	backupGraphics();
//	unacquireInput();
	suspended=true;
	busy=false;

	if( gfx_mode==3 ) ShowCursor(1);

//	if( debugger ) debugger->debugStop();
}

////////////
// RESUME //
////////////
void dxRuntime::resume(){

	if( gfx_mode==3 ) ShowCursor(pointer_visible);

	busy=true;
//	acquireInput();
	restoreGraphics();
//	resumeAudio();
	suspended=false;
	busy=false;

//	if( debugger ) debugger->debugRun();
}

///////////////////
// FORCE SUSPEND //
///////////////////
void dxRuntime::forceSuspend(){
	if( gfx_mode==3 ){
		SetForegroundWindow( GetDesktopWindow() );
		ShowWindow( GetDesktopWindow(),SW_SHOW );
	}else{
		suspend();
	}
}

//////////////////
// FORCE RESUME //
//////////////////
void dxRuntime::forceResume(){
	if( gfx_mode==3 ){
		SetForegroundWindow( hwnd );
		ShowWindow( hwnd,SW_SHOWMAXIMIZED );
	}else{
		resume();
	}
}

//static dxGraphics *dxgraphics;
//static IDirectDraw7 *ddraw7;
static HWND hwnd2;

void dxRuntime::paint( int painthwnd ){

	LPDIRECTDRAWCLIPPER FAR *cp;
	RECT src,dest;

	if (painthwnd)
	{
		if (clipper) clipper->SetHWnd( 0,(HWND)painthwnd );
		hwnd2=(HWND)painthwnd;
	}
	else
	{
		src.left=src.top=0;
		GetClientRect( hwnd2,&dest );
		src.right=dest.right;
		src.bottom=dest.bottom;		
		POINT p;
		p.x=p.y=0;
		ClientToScreen( hwnd2,&p );
		dest.left+=p.x;
		dest.right+=p.x;
		dest.top+=p.y;
		dest.bottom+=p.y;
		dxCanvas *b=(dxCanvas *)graphics->getBackCanvas();	//simon was here
//		dxCanvas *f=(dxCanvas *)(graphics->getFrontCanvas());	//simon was here
//		int n=f->getSurface()->Flip( 0,DDFLIP_NOVSYNC|DDFLIP_WAIT );
//		printf("surf->blt src=%d,%d,%d,%d dest=%d,%d,%d,%d\n",src.left,src.top,src.right,src.bottom,dest.left,dest.top,dest.right,dest.bottom);
		primSurf->Blt( &dest,b->getSurface(),&src,0,0 );
	}
}

///////////
// PAINT //
///////////
void dxRuntime::paint(){
	switch( gfx_mode ){
	case 0:
		{
		}
		break;
	case 1:case 2:	//scaled windowed mode.
		{
			RECT src,dest;
			src.left=src.top=0;
			GetClientRect( hwnd,&dest );
			if (dest.top>=dest.bottom||dest.left>=dest.right) break;
			src.right=gfx_mode==1 ? graphics->getWidth() : dest.right;
			src.bottom=gfx_mode==1 ? graphics->getHeight() : dest.bottom;
			POINT p;p.x=p.y=0;ClientToScreen( hwnd,&p );
			dest.left+=p.x;dest.right+=p.x;
			dest.top+=p.y;dest.bottom+=p.y;
			dxCanvas *f=(dxCanvas *)(graphics->getFrontCanvas());	//simon was here
			int res=primSurf->Blt( &dest,f->getSurface(),&src,0,0 );
			if (res){
				res=res;
			}
		}
		break;
	case 3:
		{
			//exclusive mode
		}
		break;
	}
}

//////////
// FLIP //
//////////
void dxRuntime::flip( bool vwait ){
	dxCanvas *b=(dxCanvas *)graphics->getBackCanvas();	//simon was here
	dxCanvas *f=(dxCanvas *)graphics->getFrontCanvas();
	int n;
	switch( gfx_mode ){
	case 1:case 2:
		if( vwait ) graphics->vwait();
		f->setModify( b->getModify() );
		if( f->getModify()!=mod_cnt ){
			mod_cnt=f->getModify();
			paint();
		}
		break;
	case 3:
		if( vwait ){
			BOOL vb;
			while( graphics->dirDraw->GetVerticalBlankStatus( &vb )>=0 && vb ) {}
			n=f->getSurface()->Flip( 0,DDFLIP_WAIT );
		}else{
			n=f->getSurface()->Flip( 0,DDFLIP_NOVSYNC|DDFLIP_WAIT );
		}
		if( n>=0 ) return;
		string t="Flip Failed! Return code:"+itoa(n&0x7fff);
//		debugLog( t.c_str() );
		break;
	}
//  Sleep(500); //simon was here - sorry folks, polite to let system breath before busy waiting on vblank
}

////////////////
// MOVE MOUSE //
////////////////
void dxRuntime::moveMouse( int x,int y ){
	POINT p;
	RECT rect;
	switch( gfx_mode ){
	case 1:
		GetClientRect( hwnd,&rect );
		x=x*(rect.right-rect.left)/graphics->getWidth();
		y=y*(rect.bottom-rect.top)/graphics->getHeight();
	case 2:
		p.x=x;p.y=y;ClientToScreen( hwnd,&p );x=p.x;y=p.y;
		break;
	case 3:
		p.x=x;p.y=y;ClientToScreen( hwnd,&p );x=p.x;y=p.y;
//		if( use_di ) return;
		break;
//	default:
//		return;
	}
	SetCursorPos( x,y );
}

// patch in brl.system.win32

//extern "C" void bbSystemEmitOSEvent( HWND hwnd,UINT msg,WPARAM wp,LPARAM lp,BBObject *source );


/////////////////
// WINDOW PROC //
/////////////////
LRESULT dxRuntime::wndProc( HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam ){

	if( busy ){
		return DefWindowProc( hwnd,msg,wparam,lparam );
	}

	PAINTSTRUCT ps;

	switch( msg ){
		case WM_PAINT:
			if( gfx_mode && !auto_suspend ){
				if( !graphics->restore() ) gfx_lost=true;
			}
			BeginPaint( hwnd,&ps );
			paint();
			EndPaint( hwnd,&ps );
			return DefWindowProc( hwnd,msg,wparam,lparam );
		case WM_ERASEBKGND:
			return gfx_mode ? 1 : DefWindowProc( hwnd,msg,wparam,lparam );
		case WM_ACTIVATEAPP:
			if( auto_suspend ){
				if( wparam ){
					if( suspended ) resume();
				}else{
					if( !suspended ) suspend();
				}
			}
			return 0;
	}

	if (eventCallback) {
		if (eventCallback((int)hwnd,msg,wparam,lparam)==0) return 0;
		return DefWindowProc( hwnd,msg,wparam,lparam );
	}

	static const int MK_ALLBUTTONS=MK_LBUTTON|MK_RBUTTON|MK_MBUTTON;

	switch( msg ){
	case WM_CLOSE:
		if( app_close.size() ){
			int n=MessageBox( hwnd,app_close.c_str(),app_title.c_str(),MB_OKCANCEL|MB_ICONWARNING|MB_SETFOREGROUND|MB_TOPMOST );
			if( n!=IDOK ) return 0;
		}
		PostMessage( hwnd,WM_END,0,0 );
		return 0;
	case WM_SETCURSOR:
		if( !pointer_visible ){
			if( gfx_mode==3 ){
				SetCursor( 0 );return 1; 
			}

			POINT p;GetCursorPos( &p );
			ScreenToClient( hwnd,&p );
			RECT r;GetClientRect( hwnd,&r );
			if( p.x>=0 && p.y>=0 && p.x<r.right && p.y<r.bottom ){
				SetCursor( 0 );return 1;
			}
		}
		return DefWindowProc( hwnd,msg,wparam,lparam );
	case WM_LBUTTONDOWN:
		dxinput->wm_mousedown(1);
		SetCapture(hwnd);
		break;
	case WM_LBUTTONUP:
		dxinput->wm_mouseup(1);
		if( !(wparam&MK_ALLBUTTONS) ) ReleaseCapture();
		break;
	case WM_RBUTTONDOWN:
		dxinput->wm_mousedown(2);
		SetCapture( hwnd );
		break;
	case WM_RBUTTONUP:
		dxinput->wm_mouseup(2);
		if( !(wparam&MK_ALLBUTTONS) ) ReleaseCapture();
		break;
	case WM_MBUTTONDOWN:
		dxinput->wm_mousedown(3);
		SetCapture( hwnd );
		break;
	case WM_MBUTTONUP:
		dxinput->wm_mouseup(3);
		if( !(wparam&MK_ALLBUTTONS) ) ReleaseCapture();
		break;
	case WM_MOUSEMOVE:
		if( !graphics ) break;
		if( gfx_mode==3 && !use_di ){
			POINT p;GetCursorPos( &p );
			dxinput->wm_mousemove( p.x,p.y );
		}else{
			int x=(short)(lparam&0xffff),y=lparam>>16;
			if( gfx_mode==1 ){
				RECT rect;GetClientRect( hwnd,&rect );
				x=x*graphics->getWidth()/(rect.right-rect.left);
				y=y*graphics->getHeight()/(rect.bottom-rect.top);
			}
			if( x<0 ) x=0;
			else if( x>=graphics->getWidth() ) x=graphics->getWidth()-1;
			if( y<0 ) y=0;
			else if( y>=graphics->getHeight() ) y=graphics->getHeight()-1;
			dxinput->wm_mousemove( x,y );
		}
		break;
	case WM_MOUSEWHEEL:
		dxinput->wm_mousewheel( (short)HIWORD( wparam ) );
		break;
	case WM_KEYDOWN:case WM_SYSKEYDOWN:
		if( lparam & 0x40000000 ) break;
		if( int n=((lparam>>17)&0x80)|((lparam>>16)&0x7f) ) dxinput->wm_keydown( n );
		break;
	case WM_KEYUP://case WM_SYSKEYUP:
		if( int n=((lparam>>17)&0x80)|((lparam>>16)&0x7f) ) dxinput->wm_keyup( n );
		break;

	default:
		return DefWindowProc( hwnd,msg,wparam,lparam );
	}
	return 0;
}


/*		
	case WM_KEYDOWN:
	case WM_SYSKEYDOWN:
	case WM_KEYUP:
//	case WM_SYSKEYUP:
//		printf("key wp=%d lp=%d\n",wparam,lparam);fflush(stdout);
		break;
		
	default:
		return DefWindowProc( hwnd,msg,wparam,lparam );	
	}
	return 0;

	switch( msg ){
*/

//	if( !input || suspended ) return DefWindowProc( hwnd,msg,wparam,lparam );
/*
simon was here
	if( gfx_mode==3 && use_di ){
		use_di=input->acquire();
		return DefWindowProc( hwnd,msg,wparam,lparam );
	}

	//handle input messages
	switch( msg ){
	case WM_LBUTTONDOWN:
		input->wm_mousedown(1);
		SetCapture(hwnd);
		break;
	case WM_LBUTTONUP:
		input->wm_mouseup(1);
		if( !(wparam&MK_ALLBUTTONS) ) ReleaseCapture();
		break;
	case WM_RBUTTONDOWN:
		input->wm_mousedown(2);
		SetCapture( hwnd );
		break;
	case WM_RBUTTONUP:
		input->wm_mouseup(2);
		if( !(wparam&MK_ALLBUTTONS) ) ReleaseCapture();
		break;
	case WM_MBUTTONDOWN:
		input->wm_mousedown(3);
		SetCapture( hwnd );
		break;
	case WM_MBUTTONUP:
		input->wm_mouseup(3);
		if( !(wparam&MK_ALLBUTTONS) ) ReleaseCapture();
		break;
	case WM_MOUSEMOVE:
		if( !graphics ) break;
		if( gfx_mode==3 && !use_di ){
			POINT p;GetCursorPos( &p );
			input->wm_mousemove( p.x,p.y );
		}else{
			int x=(short)(lparam&0xffff),y=lparam>>16;
			if( gfx_mode==1 ){
				RECT rect;GetClientRect( hwnd,&rect );
				x=x*graphics->getWidth()/(rect.right-rect.left);
				y=y*graphics->getHeight()/(rect.bottom-rect.top);
			}
			if( x<0 ) x=0;
			else if( x>=graphics->getWidth() ) x=graphics->getWidth()-1;
			if( y<0 ) y=0;
			else if( y>=graphics->getHeight() ) y=graphics->getHeight()-1;
			input->wm_mousemove( x,y );
		}
		break;
	case WM_MOUSEWHEEL:
		input->wm_mousewheel( (short)HIWORD( wparam ) );
		break;
	case WM_KEYDOWN:case WM_SYSKEYDOWN:
		if( lparam & 0x40000000 ) break;
		if( int n=((lparam>>17)&0x80)|((lparam>>16)&0x7f) ) input->wm_keydown( n );
		break;
	case WM_KEYUP:case WM_SYSKEYUP:
		if( int n=((lparam>>17)&0x80)|((lparam>>16)&0x7f) ) input->wm_keyup( n );
		break;
	default:
		return DefWindowProc( hwnd,msg,wparam,lparam );
	}
	return 0;
}
*/


static LRESULT CALLBACK windowProc( HWND hwnd,UINT msg,WPARAM wparam,LPARAM lparam ){
	if( runtime ) return runtime->wndProc( hwnd,msg,wparam,lparam );
	return DefWindowProc( hwnd,msg,wparam,lparam );
}

/*
//////////////////////////////
//STOP FROM EXTERNAL SOURCE //
//////////////////////////////
void dxRuntime::asyncStop(){
	PostMessage( hwnd,WM_STOP,0,0 );
}

//////////////////////////////
//RUN  FROM EXTERNAL SOURCE //
//////////////////////////////
void dxRuntime::asyncRun(){
	PostMessage( hwnd,WM_RUN,0,0 );
}

//////////////////////////////
// END FROM EXTERNAL SOURCE //
//////////////////////////////
void dxRuntime::asyncEnd(){
//	debugger=0;
//	run_flag=false;
	PostMessage( hwnd,WM_END,0,0 );
}
*/

//////////
// IDLE //
//////////
bool dxRuntime::idle(){

  for(;;){
		MSG msg;
		if( suspended && run_flag ){
			GetMessage( &msg,0,0,0 );
		}else{
			if( !PeekMessage( &msg,hwnd,0,0,PM_REMOVE ) ) return run_flag;
		}
		switch( msg.message ){
		case WM_STOP:
			if( !suspended ) forceSuspend();
			break;
		case WM_RUN:
			if( suspended ) forceResume();
			break;
		case WM_END:
//			debugger=0;
			run_flag=false;
			bbEndBlitz3D();
			exit(0);
			break;
		default:
			DispatchMessage( &msg );
		}
	}
	return run_flag;
}

///////////
// DELAY //
///////////
bool dxRuntime::delay( int ms ){
	int t=timeGetTime()+ms;
	for(;;){
		if( !idle() ) return false;
		int d=t-timeGetTime();	//how long left to wait
		if( d<=0 ) return true;
		if( d>100 ) d=100;
		Sleep( d );
	}
}

/*
const char *lasterror=0;

void dxRuntime::debugError( const char *err ){
	lasterror=err;
	if (err){
		MessageBoxA(0,err,"Blitz3D Runtime Error",MB_SYSTEMMODAL);
//		DebugBreak();
	}
	return;
}

const char *dxRuntime::error(){
	return lasterror;
}

void dxRuntime::debugLog( const char *t ){
	return;
}
*/
/*
///////////////
// DEBUGSTMT //
///////////////
void dxRuntime::debugStmt( int pos,const char *file ){
	if( debugger ) debugger->debugStmt( pos,file );
}

///////////////
// DEBUGSTOP //
///////////////
void dxRuntime::debugStop(){
	if( !suspended ) forceSuspend();
}

////////////////
// DEBUGENTER //
////////////////
void dxRuntime::debugEnter( void *frame,void *env,const char *func ){
	if( debugger ) debugger->debugEnter( frame,env,func );
}

////////////////
// DEBUGLEAVE //
////////////////
void dxRuntime::debugLeave(){
	if( debugger ) debugger->debugLeave();
}

////////////////
// DEBUGERROR //
////////////////
void dxRuntime::debugError( const char *t ){
	if( !debugger ) return;
	Debugger *d=debugger;
	asyncEnd();
	if( !suspended ){
		forceSuspend();
	}
	d->debugMsg( t,true );
}

///////////////
// DEBUGINFO //
///////////////
void dxRuntime::debugInfo( const char *t ){
	if( !debugger ) return;
	Debugger *d=debugger;
	asyncEnd();
	if( !suspended ){
		forceSuspend();
	}
	d->debugMsg( t,false );
}

//////////////
// DEBUGLOG //
//////////////
void dxRuntime::debugLog( const char *t ){
	if( debugger ) debugger->debugLog( t );
}

/////////////////////////
// RETURN COMMAND LINE //
/////////////////////////
string dxRuntime::commandLine(){
	return cmd_line;
}

/////////////
// EXECUTE //
/////////////
bool dxRuntime::execute( const string &cmd_line ){

	if( !cmd_line.size() ) return false;

	//convert cmd_line to cmd and params
	string cmd=cmd_line,params;
	while( cmd.size() && cmd[0]==' ' ) cmd=cmd.substr( 1 );
	if( cmd.find( '\"' )==0 ){
		int n=cmd.find( '\"',1 );
		if( n!=string::npos ){
			params=cmd.substr( n+1 );
			cmd=cmd.substr( 1,n-1 );
		}
	}else{
		int n=cmd.find( ' ' );
		if( n!=string::npos ){
			params=cmd.substr( n+1 );
			cmd=cmd.substr( 0,n );
		}
	}
	while( params.size() && params[0]==' ' ) params=params.substr( 1 );
	while( params.size() && params[params.size()-1]==' ' ) params=params.substr( 0,params.size()-1 );

	SetForegroundWindow( GetDesktopWindow() );

	return (int)ShellExecute( GetDesktopWindow(),0,cmd.c_str(),params.size() ? params.c_str() : 0,0,SW_SHOW )>32;
}
*/

///////////////
// APP TITLE //
///////////////
//void dxRuntime::setTitle( const string &t,const string &e ){
void dxRuntime::setTitle( const char *t,const char *e ){
	app_title=t;
	if (e) app_close=e;
	SetWindowText( hwnd,app_title.c_str() );
}

//////////////////
// GETMILLISECS //
//////////////////
int dxRuntime::getMilliSecs(){
	return timeGetTime();
}


/////////////////////
// POINTER VISIBLE //
/////////////////////
void dxRuntime::setPointerVisible( bool vis ){
	if( pointer_visible==vis ) return;

	pointer_visible=vis;
	if( gfx_mode==3 ) return;

	//force a WM_SETCURSOR
	POINT pt;
	GetCursorPos( &pt );
	SetCursorPos( pt.x,pt.y );
}

/////////////////
// AUDIO SETUP //
/////////////////
gxAudio *dxRuntime::openAudio( int flags ){
	if( audio ) return 0;
	audio=d_new dxAudio( this );
	if (audio->reset(hwnd)==0){
		gx_audio=audio;
		return audio;
	}else{
		delete audio;
		return 0;
	}
}

/*
	
simon was here
	int f_flags=
		FSOUND_INIT_GLOBALFOCUS|
		FSOUND_INIT_USEDEFAULTMIDISYNTH;

	FSOUND_SetHWND( hwnd );
	if( !FSOUND_Init( 44100,1024,f_flags ) ){
		return 0;
	}
*/

void dxRuntime::closeAudio( gxAudio *a ){
	if( !audio || audio!=a ) return;
	delete audio;
	audio=0;
}

/////////////////////////////////////////////////////
// TIMER CALLBACK FOR AUTOREFRESH OF WINDOWED MODE //
/////////////////////////////////////////////////////
static void CALLBACK timerCallback( UINT id,UINT msg,DWORD user,DWORD dw1,DWORD dw2 ){
	if( gfx_mode ){
//		InvalidateRect( runtime->hwnd,0,false );

		dxCanvas *f=(dxCanvas *)runtime->graphics->getFrontCanvas();
		if( f->getModify()!=mod_cnt ){
			mod_cnt=f->getModify();
			InvalidateRect( runtime->hwnd,0,false );
		}

	}
}

////////////////////
// GRAPHICS SETUP //
////////////////////
void dxRuntime::backupWindowState(){
	GetWindowRect( hwnd,&t_rect );
	t_style=GetWindowLong( hwnd,GWL_STYLE );
}

void dxRuntime::restoreWindowState(){
	SetWindowLong( hwnd,GWL_STYLE,t_style );
	SetWindowPos( 
		hwnd,0,t_rect.left,t_rect.top,
		t_rect.right-t_rect.left,t_rect.bottom-t_rect.top,
		SWP_NOZORDER|SWP_FRAMECHANGED );
}

dxGraphics *dxRuntime::openWindowedGraphics( int w,int h,int d,bool d3d ){

	IDirectDraw7 *dd;

	if( directdrawcreateex( curr_driver->guid,(void**)&dd,IID_IDirectDraw7,0 )<0 ) return 0;


//	ddraw7=dd;

//	if( DirectDrawCreateEx( curr_driver->guid,(void**)&dd,IID_IDirectDraw7,0 )<0 ) return 0;

	while( dd->SetCooperativeLevel( hwnd,DDSCL_NORMAL|DDSCL_FPUSETUP)){//simon was here DDSCL_FPUPRESERVE ) ){//DDSCL_FPUSETUP ) ) {		//
		Sleep(20);
	}


	//set coop level
//	if( dd->SetCooperativeLevel( 0,DDSCL_NORMAL|DDSCL_FPUPRESERVE )>=0 ){	//0 // hwnd, simon was here
		//create primary surface
		IDirectDrawSurface7 *ps;
		DDSURFACEDESC2 desc={sizeof(desc)};
		desc.dwFlags=DDSD_CAPS;
		desc.ddsCaps.dwCaps=DDSCAPS_PRIMARYSURFACE;
		if( dd->CreateSurface( &desc,&ps,0 )>=0 ){
			//create clipper
			IDirectDrawClipper *cp;
			if( dd->CreateClipper( 0,&cp,0 )>=0 ){
				//attach clipper 
				if( ps->SetClipper( cp )>=0 ){
					//set clipper HWND
					if( cp->SetHWnd( 0,hwnd )>=0 ){
						//create front buffer
						IDirectDrawSurface7 *fs;
						DDSURFACEDESC2 desc={sizeof(desc)};
						desc.dwFlags=DDSD_WIDTH|DDSD_HEIGHT|DDSD_CAPS;
						desc.dwWidth=w;desc.dwHeight=h;
						desc.ddsCaps.dwCaps=DDSCAPS_OFFSCREENPLAIN;
						if( d3d ) {
							desc.ddsCaps.dwCaps|=DDSCAPS_3DDEVICE;
							desc.ddsCaps.dwCaps2|=DDSCAPS2_HINTANTIALIASING;
						}
						if( dd->CreateSurface( &desc,&fs,0 )>=0 ){
//							timerID=timeSetEvent( 100,10,timerCallback,0,TIME_PERIODIC ) ;
//							if (!timerID)
								//Success!
								clipper=cp;
								primSurf=ps;
								mod_cnt=0;
								fs->AddRef();
								dxGraphics *gfx=d_new dxGraphics( this,dd,fs,fs,d3d );
								timerID=timeSetEvent( 100,100,timerCallback,0,TIME_PERIODIC|TIME_CALLBACK_FUNCTION|TIME_KILL_SYNCHRONOUS ) ;
//								return d_new dxGraphics( this,dd,fs,fs,d3d );
								return gfx;
//							}
//							fs->Release();
						}
					}
				}
				cp->Release();
			}
			ps->Release();
		}
//	}
	dd->Release();
	return 0;
}

bool dxRuntime::setDisplayMode( int w,int h,int d,bool d3d,IDirectDraw7 *dirDraw ){

	if( d ) return dirDraw->SetDisplayMode( w,h,d,0,0 )>=0;

	int best_d=0;

	if( d3d ){
#ifdef PRO
		int bd=curr_driver->d3d_desc.dwDeviceRenderBitDepth;
		if( bd & DDBD_32 ) best_d=32;
		else if( bd & DDBD_24 ) best_d=24;
		else if( bd & DDBD_16 ) best_d=16;
#endif
	}else{
		int best_n=0;
		for( d=16;d<=32;d+=8 ){
			if( dirDraw->SetDisplayMode( w,h,d,0,0 )<0 ) continue;
			DDCAPS caps={ sizeof(caps)  };
			dirDraw->GetCaps( &caps,0 );
			int n=0;
			if( caps.dwCaps & DDCAPS_BLT ) ++n;
			if( caps.dwCaps & DDCAPS_BLTCOLORFILL ) ++n;
			if( caps.dwCKeyCaps & DDCKEYCAPS_SRCBLT ) ++n;
			if( caps.dwCaps2 & DDCAPS2_WIDESURFACES ) ++n;
			if( n==4 ) return true;
			if( n>best_n ){
				best_d=d;
				best_n=n;
			}
			dirDraw->RestoreDisplayMode();
		}
	}
	return best_d ? dirDraw->SetDisplayMode( w,h,best_d,0,0 )>=0 : false;
}

dxGraphics *dxRuntime::openExclusiveGraphics( int w,int h,int d,bool d3d ){

	IDirectDraw7 *dd;
	if( directdrawcreateex( curr_driver->guid,(void**)&dd,IID_IDirectDraw7,0 )<0 ) return 0;

	//Set coop level

	int coopflags=DDSCL_EXCLUSIVE|DDSCL_FULLSCREEN|DDSCL_ALLOWREBOOT|DDSCL_FPUSETUP;//DDSCL_FPUPRESERVE;

//	if( dd->SetCooperativeLevel( hwnd,DDSCL_EXCLUSIVE|DDSCL_FULLSCREEN|DDSCL_ALLOWREBOOT|DDSCL_FPUPRESERVE )>=0 ){
//	if( dd->SetCooperativeLevel( hwnd,DDSCL_FULLSCREEN|DDSCL_ALLOWREBOOT|DDSCL_FPUPRESERVE )>=0 ){
		//Set display mode
	if( dd->SetCooperativeLevel( hwnd,coopflags )>=0 ){
		if( setDisplayMode( w,h,d,d3d,dd ) ){
			//create primary surface
			IDirectDrawSurface7 *ps;
			DDSURFACEDESC2 desc={sizeof(desc)};
			desc.dwFlags=DDSD_CAPS|DDSD_BACKBUFFERCOUNT;
			desc.ddsCaps.dwCaps=DDSCAPS_PRIMARYSURFACE|DDSCAPS_COMPLEX|DDSCAPS_FLIP;
			desc.dwBackBufferCount=1;
			if( d3d ) desc.ddsCaps.dwCaps|=DDSCAPS_3DDEVICE;

			if( dd->CreateSurface( &desc,&ps,0 )>=0 ){
				//find back surface
				IDirectDrawSurface7 *bs;
				DDSCAPS2 caps={sizeof caps};
				caps.dwCaps=DDSCAPS_BACKBUFFER;
				if( ps->GetAttachedSurface( &caps,&bs )>=0 ){
					return d_new dxGraphics( this,dd,ps,bs,d3d );
				}
				ps->Release();
			}
			dd->RestoreDisplayMode();
		}
	}
	dd->Release();
	return 0;
}

gxGraphics *dxRuntime::openGraphics( int w,int h,int d,int driver,int flags ){
	if( graphics ) return 0;

	busy=true;

	bool d3d=flags & dxGraphics::GRAPHICS_3D ? true : false;
	bool windowed=flags & dxGraphics::GRAPHICS_WINDOWED ? true : false;

	if( windowed ) driver=0;

	curr_driver=drivers[driver];

	if( windowed ){
		graphics=openWindowedGraphics( w,h,d,d3d );
		if (!graphics){
			throw L"chunks";
		}
			gfx_mode=(flags & dxGraphics::GRAPHICS_SCALED) ? 1 : 2;
			gfx_mode=(flags & dxGraphics::GRAPHICS_REUSED) ? 4 : gfx_mode ;
			auto_suspend=(flags & gxGraphics::GRAPHICS_AUTOSUSPEND) ? true : false;
			int ws,ww,hh;
			if( gfx_mode==1 ){
				ws=scaled_ws;
//				RECT c_r;
//				GetClientRect( hwnd,&c_r );
//				ww=c_r.right-c_r.left;
//				hh=c_r.bottom-c_r.top;
				ww=w;
				hh=h;
			}else{
				ws=static_ws;
				ww=w;
				hh=h;
			}
			if( gfx_mode==4 ){ws=reused_ws;}

			HWND hwnd_parent=GetParent(hwnd);
			if (hwnd_parent){
				RECT p_r;
				ws=child_ws;
				GetClientRect( hwnd_parent,&p_r );
				SetWindowLong( hwnd,GWL_STYLE,ws );
//				SetWindowPos( hwnd,0,0,0,p_r.right,p_r.bottom,SWP_NOZORDER|SWP_FRAMECHANGED|SWP_NOSIZE );
				SetWindowPos( hwnd,0,0,0,w,h,SWP_NOZORDER|SWP_FRAMECHANGED );
			}else{
				SetWindowLong( hwnd,GWL_STYLE,ws );
				SetWindowPos( hwnd,0,0,0,0,0,SWP_NOMOVE|SWP_NOSIZE|SWP_NOZORDER|SWP_FRAMECHANGED );
				RECT w_r,c_r;
				GetWindowRect( hwnd,&w_r );
				GetClientRect( hwnd,&c_r );
				int tw=(w_r.right-w_r.left)-(c_r.right-c_r.left);
				int th=(w_r.bottom-w_r.top)-(c_r.bottom-c_r.top );
				int cx=( GetSystemMetrics( SM_CXSCREEN )-ww )/2;
				int cy=( GetSystemMetrics( SM_CYSCREEN )-hh )/2;
				POINT zz={0,0};
				ClientToScreen( hwnd,&zz );
				int bw=zz.x-w_r.left,bh=zz.y-w_r.top;
				int wx=cx-bw,wy=cy-bh;if( wy<0 ) wy=0;		//not above top!
				MoveWindow( hwnd,wx,wy,ww+tw,hh+th,true );
			}
//		}
	}else{
		backupWindowState();

		SetWindowLong( hwnd,GWL_STYLE,WS_VISIBLE|WS_POPUP );
		SetWindowPos( hwnd,0,0,0,0,0,SWP_NOMOVE|SWP_NOSIZE|SWP_NOZORDER|SWP_FRAMECHANGED );

		ShowCursor( pointer_visible );
		if( graphics=openExclusiveGraphics( w,h,d,d3d ) ){
			gfx_mode=3;
			auto_suspend=true;
			SetCursorPos(0,0);
//			acquireInput();
		}else{
			ShowCursor( 1 );
			restoreWindowState();
		}
	}

	if( !graphics ) curr_driver=0;

	gfx_lost=false;

	busy=false;

	return graphics;
}

void dxRuntime::closeGraphics( gxGraphics *g ){
	if( !graphics || graphics!=(dxGraphics*)g ) return;

	busy=true;

	int mode=gfx_mode;
	gfx_mode=0;

//	unacquireInput();
	if( timerID ){ timeKillEvent( timerID );timerID=0; }
	if( clipper ){ clipper->Release();clipper=0; }
	if( primSurf ){ primSurf->Release();primSurf=0; }
	delete graphics;graphics=0;

	if( mode==3 ){
		ShowCursor( 1 );
		restoreWindowState();
	}

	gfx_lost=false;

	busy=false;
}

bool dxRuntime::graphicsLost(){
	return gfx_lost;
}

/*
gxFileSystem *dxRuntime::openFileSystem( int flags ){
	if( fileSystem ) return 0;

	fileSystem=d_new gxFileSystem();
	return fileSystem;
}

void dxRuntime::closeFileSystem( gxFileSystem *f ){
	if( !fileSystem || fileSystem!=f ) return;

	delete fileSystem;
	fileSystem=0;
}
*/

////////////////////
// GFX ENUM STUFF //
////////////////////

static HRESULT WINAPI enumMode( DDSURFACEDESC2 *desc,void *context ){
	int dp=desc->ddpfPixelFormat.dwRGBBitCount;
	if( dp==16 || dp==24 || dp==32 ){
		dxRuntime::GfxMode *m=d_new dxRuntime::GfxMode;
		m->desc=*desc;
		dxRuntime::GfxDriver *d=(dxRuntime::GfxDriver*)context;
		d->modes.push_back( m );
	}
	return DDENUMRET_OK;
}

#ifdef PRO
static int maxDevType;
static HRESULT CALLBACK enumDevice( char *desc,char *name,D3DDEVICEDESC7 *devDesc,void *context ){
	int t=0;
	GUID guid=devDesc->deviceGUID;
	if( guid==IID_IDirect3DRGBDevice ) t=1;
	else if( guid==IID_IDirect3DHALDevice ) t=2;
	else if( guid==IID_IDirect3DTnLHalDevice ) t=3;
	if( t>1 && t>maxDevType ){
		maxDevType=t;
		dxRuntime::GfxDriver *d=(dxRuntime::GfxDriver*)context;
		d->d3d_desc=*devDesc;
	}
	return D3DENUMRET_OK;
}
#endif

BOOL CALLBACK MonitorFunc(HMONITOR hMonitor,HDC hdcMonitor,LPRECT lprcMonitor,LPARAM dwData){
	dxRuntime::GfxDriver *d;
	d=(dxRuntime::GfxDriver*)dwData;
	if (hMonitor==d->hmonitor){
		d->xpos=lprcMonitor->left;
		d->ypos=lprcMonitor->top;
		return 0;
	}
	return 1;
}
/*
//	screen			*s;
	RECT			*r;
	MONITORINFOEX	info;
	DEVMODE			mode;

	d=(dxRuntime::GfxDriver*)dwData;
	info.cbSize=sizeof(MONITORINFOEX);
	GetMonitorInfo(hMonitor,&info);
	mode.dmSize=sizeof(mode);
	mode.dmDriverExtra=0;
	mode.dmSpecVersion=DM_SPECVERSION;
	return true;
}
*/
/*
	s=nitro->screenlist;
	while (s)
	{
		if (s->path->equalsIgnoreCase(info.szDevice))
		{
			r=&info.rcMonitor;	//rcWork to exclude start bar
			s->setarea(r->left,r->top,r->right-r->left,r->bottom-r->top);
			s->sethandle((int)hMonitor);
			EnumDisplaySettings(info.szDevice,ENUM_CURRENT_SETTINGS,&mode);
			s->setdepth(mode.dmBitsPerPel);
			s->setfrequency(mode.dmDisplayFrequency);
			break;
		}
		s=s->link;
	}
*/


static BOOL WINAPI enumDriver( GUID FAR *guid,LPSTR desc,LPSTR name,LPVOID context,HMONITOR hm ){
	IDirectDraw7 *dd;

	if( directdrawcreateex( guid,(void**)&dd,IID_IDirectDraw7,0 )<0 ) return 0;

	if( !guid && !desktop_desc.ddpfPixelFormat.dwRGBBitCount ){
		desktop_desc.dwSize=sizeof(desktop_desc);
		dd->GetDisplayMode( &desktop_desc );
	}

	dxRuntime::GfxDriver *d=d_new dxRuntime::GfxDriver;

	d->guid=guid ? d_new GUID( *guid ) : 0;
	d->name=desc;//string( name )+" "+string( desc );
	dd->GetMonitorFrequency(&d->hertz);

	DDDEVICEIDENTIFIER2 ddid;//={sizeof(ddid);};
	dd->GetDeviceIdentifier(&ddid,0);
	d->xpos=0;
	d->ypos=0;
	d->hmonitor=hm;
	if (hm){
		EnumDisplayMonitors(0,0,MonitorFunc,(LPARAM)d);
	}
//	MONITORINFOEX	info;
//	info.cbSize=sizeof(info);
//	GetMonitorInfo(hm,&info);

//	DEVMODE			mode;
//	d=(dxRuntime::GfxDriver*)dwData;
//	info.cbSize=sizeof(MONITORINFOEX);


#ifdef PRO
	memset( &d->d3d_desc,0,sizeof(d->d3d_desc) );
	IDirect3D7 *dir3d;
	if( dd->QueryInterface( IID_IDirect3D7,(void**)&dir3d )>=0 ){
		maxDevType=0;
		dir3d->EnumDevices( enumDevice,d );
		dir3d->Release();
	}
#endif
	vector<dxRuntime::GfxDriver*> *drivers=(vector<dxRuntime::GfxDriver*>*)context;
	drivers->push_back( d );

	DDSURFACEDESC2	desc2={sizeof(desc2)};
	dd->GetDisplayMode(&desc2);
	enumMode(&desc2,d);

	dd->EnumDisplayModes( 0,0,d,enumMode );
	dd->Release();
	return 1;
}

void dxRuntime::enumGfx(){
	denumGfx();
	if( enum_all ){
		directdrawenumerateex( enumDriver,&drivers,DDENUM_ATTACHEDSECONDARYDEVICES|DDENUM_NONDISPLAYDEVICES );
	}else{
		directdrawenumerateex( enumDriver,&drivers,0 );
	}
}

void dxRuntime::denumGfx(){
	for( int k=0;k<drivers.size();++k ){
		dxRuntime::GfxDriver *d=drivers[k];
		for( int j=0;j<d->modes.size();++j ) delete d->modes[j];
		delete d->guid;
		delete d;
	}
	drivers.clear();
}

int dxRuntime::numGraphicsDrivers(){
	if( !enum_all ){
		enum_all=true;
		enumGfx();
	}
	return drivers.size();
}

void dxRuntime::graphicsDriverInfo( int driver,const char **name,int *c,int *x,int *y,int *hz ){
	GfxDriver *g=drivers[driver];
	int caps=0;
#ifdef PRO
	if( g->d3d_desc.dwDeviceRenderBitDepth ) caps|=GFXMODECAPS_3D;
#endif
	*name=g->name.c_str();
	*c=caps;
	*hz=g->hertz;
	*x=g->xpos;
	*y=g->ypos;
}

int dxRuntime::numGraphicsModes( int driver ){
	return drivers[driver]->modes.size();
}

void dxRuntime::graphicsModeInfo( int driver,int mode,int *w,int *h,int *d,int *c ){
	GfxDriver *g=drivers[driver];
	GfxMode *m=g->modes[mode];
	int caps=0;
#ifdef PRO
	int bd=0;
	switch( m->desc.ddpfPixelFormat.dwRGBBitCount ){
	case 16:bd=DDBD_16;break;
	case 24:bd=DDBD_24;break;
	case 32:bd=DDBD_32;break;
	}
	if( g->d3d_desc.dwDeviceRenderBitDepth & bd ) caps|=GFXMODECAPS_3D;
#endif
	*w=m->desc.dwWidth;
	*h=m->desc.dwHeight;
	*d=m->desc.ddpfPixelFormat.dwRGBBitCount;
	*c=caps;
}

void dxRuntime::windowedModeInfo( int *c ){
	int caps=0;
#ifdef PRO
	int bd=0;
	switch( desktop_desc.ddpfPixelFormat.dwRGBBitCount ){
	case 16:bd=DDBD_16;break;
	case 24:bd=DDBD_24;break;
	case 32:bd=DDBD_32;break;
	}
	if( drivers[0]->d3d_desc.dwDeviceRenderBitDepth & bd ) caps|=GFXMODECAPS_3D;
#endif
	*c=caps;
}

gxTimer *dxRuntime::createTimer( int hertz ){
	dxTimer *t=d_new dxTimer( this,hertz );
	timers.insert( t );
	return t;
}

void dxRuntime::freeTimer( gxTimer *t ){
	dxTimer *tt=(dxTimer*)t;
	if( !timers.count( tt ) ) return;
	timers.erase( tt );
	delete tt;
}

//static string toDir( string t ){
//	if( t.size() && t[t.size()-1]!='\\' ) t+='\\';
//	return t;
//}
const char *toDir( string t ){
	if( t.size() && t[t.size()-1]!='\\' ) t+='\\';
	return t.c_str();
}

/*
Platform  OSDetails OSName  OSVersion OSArch
Win95   Microsoft Win95   4.0  x86
Win98   Microsoft Win98   4.10  x86
WinME  Microsoft WinME   4.90  x86
Win200  Microsoft Win2000  5.0  x86
WinXP  Microsoft WinCE   5.0 build 0 x86
WinXP  Microsoft WinXP   5.1  x86
Windows Server 2003  Microsoft Windows Server 2003  5.2  x86
Windows Vista  Microsoft Windows Vista  6.0  x86
*/
const char *dxRuntime::systemProperty( const char *name ){
	char buff[MAX_PATH+1];
	string t=tolower(name);
	if( t=="cpu" ){
		return "Intel";
	}else if( t=="os" ){
		OSVERSIONINFO os={sizeof(os)};
		if( GetVersionEx( &os ) ){
			switch( os.dwMajorVersion ){
			case 3:
				switch( os.dwMinorVersion ){
					case 51:return "Windows NT 3.1";
				}
				break;
			case 4:
				switch( os.dwMinorVersion ){
					case 10:return "Windows 98";
					case 90:return "Windows ME";
					default:return "Windows 95";
				}
				break;
			case 5:
				switch( os.dwMinorVersion ){
					case 0:return "Windows 2000";
					case 1:return "Windows XP";
				}
				break;
			case 6:
				return "Windows Vista";
			}
		}
	}else if( t=="appdir" ){
		if( GetModuleFileName( 0,buff,MAX_PATH ) ){
			string t=buff;
			int n=t.find_last_of( '\\' );
			if( n!=string::npos ) t=t.substr( 0,n );
			return toDir( t.c_str() );
		}
	}else if( t=="windowsdir" ){
		if( GetWindowsDirectory( buff,MAX_PATH ) ) return toDir( buff );
	}else if( t=="systemdir" ){
		if( GetSystemDirectory( buff,MAX_PATH ) ) return toDir( buff );
	}else if( t=="tempdir" ){
		if( GetTempPath( MAX_PATH,buff ) ) return toDir( buff );
	}
	return "";
}

/*
string dxRuntime::systemProperty( const std::string &p ){
	char buff[MAX_PATH+1];
	string t=tolower(p);
	if( t=="cpu" ){
		return "Intel";
	}else if( t=="os" ){
		OSVERSIONINFO os={sizeof(os)};
		if( GetVersionEx( &os ) ){
			switch( os.dwMajorVersion ){
			case 3:
				switch( os.dwMinorVersion ){
				case 51:return "Windows NT 3.1";
				}
				break;
			case 4:
				switch( os.dwMinorVersion ){
				case 0:return "Windows 95";
				case 10:return "Windows 98";
				case 90:return "Windows ME";
				}
				break;
			case 5:
				switch( os.dwMinorVersion ){
				case 0:return "Windows 2000";
				case 1:return "Windows XP";
				}
				break;
			}
		}
	}else if( t=="appdir" ){
		if( GetModuleFileName( 0,buff,MAX_PATH ) ){
			string t=buff;
			int n=t.find_last_of( '\\' );
			if( n!=string::npos ) t=t.substr( 0,n );
			return toDir( t );
		}
	}else if( t=="windowsdir" ){
		if( GetWindowsDirectory( buff,MAX_PATH ) ) return toDir( buff );
	}else if( t=="systemdir" ){
		if( GetSystemDirectory( buff,MAX_PATH ) ) return toDir( buff );
	}else if( t=="tempdir" ){
		if( GetTempPath( MAX_PATH,buff ) ) return toDir( buff );
	}
	return "";
}


/*
void dxRuntime::enableDirectInput( bool enable ){
	if( use_di=enable ){
		acquireInput();
	}else{
		unacquireInput();
	}
}

int dxRuntime::callDll( const std::string &dll,const std::string &func,const void *in,int in_sz,void *out,int out_sz ){

	return 0;

	simon was here
	map<string,gxDll*>::const_iterator lib_it=libs.find( dll );

	if( lib_it==libs.end() ){
		HINSTANCE h=LoadLibrary( dll.c_str() );
		if( !h ) return 0;
		gxDll *t=d_new gxDll;
		t->hinst=h;
		lib_it=libs.insert( make_pair( dll,t ) ).first;
	}

	gxDll *t=lib_it->second;
	map<string,LibFunc>::const_iterator fun_it=t->funcs.find( func );

	if( fun_it==t->funcs.end() ){
		LibFunc f=(LibFunc)GetProcAddress( t->hinst,func.c_str() );
		if( !f ) return 0;
		fun_it=t->funcs.insert( make_pair( func,f ) ).first;
	}

	static void *save_esp;

	_asm{
		mov	[save_esp],esp
	};

	int n=fun_it->second( in,in_sz,out,out_sz );

	_asm{
		mov esp,[save_esp]
	};

	return n;
}
*/

/*
DEFINE_GUID(IID_IDirectXFile,               0x3d82ab40, 0x62da, 0x11cf, 0xab, 0x39, 0x0, 0x20, 0xaf, 0x71, 0xe4, 0x33);
DEFINE_GUID(IID_IDirectXFileEnumObject,     0x3d82ab41, 0x62da, 0x11cf, 0xab, 0x39, 0x0, 0x20, 0xaf, 0x71, 0xe4, 0x33);
DEFINE_GUID(IID_IDirectXFileSaveObject,     0x3d82ab42, 0x62da, 0x11cf, 0xab, 0x39, 0x0, 0x20, 0xaf, 0x71, 0xe4, 0x33);
DEFINE_GUID(IID_IDirectXFileObject,         0x3d82ab43, 0x62da, 0x11cf, 0xab, 0x39, 0x0, 0x20, 0xaf, 0x71, 0xe4, 0x33);
DEFINE_GUID(IID_IDirectXFileData,           0x3d82ab44, 0x62da, 0x11cf, 0xab, 0x39, 0x0, 0x20, 0xaf, 0x71, 0xe4, 0x33);
DEFINE_GUID(IID_IDirectXFileDataReference,  0x3d82ab45, 0x62da, 0x11cf, 0xab, 0x39, 0x0, 0x20, 0xaf, 0x71, 0xe4, 0x33);
DEFINE_GUID(IID_IDirectXFileBinary,         0x3d82ab46, 0x62da, 0x11cf, 0xab, 0x39, 0x0, 0x20, 0xaf, 0x71, 0xe4, 0x33);
*/


/*
/////////////////
// INPUT SETUP //
/////////////////
gxInput *dxRuntime::openInput( int flags ){
	return 0;
	if( input ) return 0;
	IDirectInput7 *di;
	if( DirectInputCreateEx( hinst,DIRECTINPUT_VERSION,IID_IDirectInput7,(void**)&di,0 )>=0 ){
		input=d_new gxInput( this,di );
		acquireInput();
	}else{
		debugInfo( "Create DirectInput failed" );
	}
	return input;
}

void dxRuntime::closeInput( gxInput *i ){
	if( !input || input!=i ) return;
	unacquireInput();
	delete input;
	input=0;
}
*/
