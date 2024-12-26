
#ifndef DXRUNTIME_H
#define DXRUNTIME_H

#include <windows.h>
#include <string>
#include <vector>

#include "../gxruntime/gxruntime.h"

#include "dxgraphics.h"
#include "dxaudio.h"

class dxRuntime:public gxRuntime{
	/***** INTERNAL INTERFACE *****/
public:

	HWND hwnd;
	HINSTANCE hinst;

	class dxInput *dxinput;

	dxGraphics *graphics;
	dxAudio *audio;

	void flip( bool vwait );
	void paint( int hwnd );
	void moveMouse( int x,int y );

	LRESULT wndProc( HWND hwnd,UINT msg,WPARAM w,LPARAM l );

	struct GfxMode;
	struct GfxDriver;

	dxRuntime( HINSTANCE hinst,const std::string &cmdline,HWND hwnd );
	~dxRuntime();

private:

	void paint();
	void suspend();
	void forceSuspend();
	void resume();
	void forceResume();
	void backupWindowState();
	void restoreWindowState();

	RECT t_rect;
	int t_style;
	std::string cmd_line;
	bool pointer_visible;
	std::string app_title;
	std::string app_close;

	bool setDisplayMode( int w,int h,int d,bool d3d,IDirectDraw7 *dd );
	dxGraphics *openWindowedGraphics( int w,int h,int d,bool d3d );
	dxGraphics *openExclusiveGraphics( int w,int h,int d,bool d3d );

	bool enum_all;
	std::vector<GfxDriver*> drivers;
	GfxDriver *curr_driver;
	int use_di;

	void enumGfx();
	void denumGfx();

	void backupGraphics();
	void restoreGraphics();

	void acquireInput();
	void unacquireInput();

	/***** APP INTERFACE *****/
public:
	static gxRuntime *openRuntime( int parenthwnd,int (_cdecl *event_handler)(int,int,int,int));
	static void closeRuntime( gxRuntime *runtime );

	/***** GX INTERFACE *****/
public:
	enum{
		GFXMODECAPS_3D=1
	};

//return true if program should continue, or false for quit.

	bool idle();
	bool delay( int ms );

	void setTitle( const char *title,const char *close );
	int  getMilliSecs();
	void setPointerVisible( bool vis );

	int numGraphicsDrivers();
	void graphicsDriverInfo( int driver,const char **name,int *caps,int *x,int *y,int *hz );

	int numGraphicsModes( int driver );
	void graphicsModeInfo( int driver,int mode,int *w,int *h,int *d,int *caps );

	void windowedModeInfo( int *caps );

	gxGraphics *openGraphics( int w,int h,int d,int driver,int flags );
	void closeGraphics( gxGraphics *graphics );
	bool graphicsLost();

	gxAudio *openAudio( int flags );
	void closeAudio( gxAudio *audio );

	gxInput *openInput( int flags );
	void closeInput( gxInput *input );

	gxTimer *createTimer( int hertz );
	void freeTimer( gxTimer *timer );

	const char *systemProperty( const char *name );
};

#endif

//	gxFileSystem *openFileSystem( int flags );
//	void closeFileSystem( gxFileSystem *filesys );
//	void enableDirectInput( bool use );
//	int  directInputEnabled(){ return use_di; }

//	int callDll( const std::string &dll,const std::string &func,const void *in,int in_sz,void *out,int out_sz );

//	std::string systemProperty( const std::string &t );
/*
	void debugStop();
	void debugProfile( int per );
	void debugStmt( int pos,const char *file );
	void debugEnter( void *frame,void *env,const char *func );
	void debugLeave();
	void debugInfo( const char *t );
	void debugError( const char *t );
	void debugLog( const char *t );
*/


//#include "dxfilesystem.h"
//#include "dxinput.h"
//#include "dxtimer.h"

//#include "../debugger/debugger.h"
/*
class Debugger{
public:
	virtual void debugRun()=0;
	virtual void debugStop()=0;
	virtual void debugStmt( int srcpos,const char *file )=0;
	virtual void debugEnter( void *frame,void *env,const char *func )=0;
	virtual void debugLeave()=0;
	virtual void debugLog( const char *msg )=0;
	virtual void debugMsg( const char *msg,bool serious )=0;
	virtual void debugSys( void *msg )=0;
};
*/

//	dxAudio *audio;
//	gxFileSystem *fileSystem;

//	std::string commandLine();
// simon come here!!!
//	void debugInfo(char *mess){}
//	bool execute( const std::string &cmd );
//	void debugError( const char *t );
//	void debugLog( const char *t );
//	const char *error();
	// HINSTANCE hinst,const std::string &cmd_line );//,Debugger *debugger );
/*
	void asyncStop();
	void asyncRun();
	void asyncEnd();
*/
/*
	void resetInput();
	void pauseAudio();
	void resumeAudio();
*/
