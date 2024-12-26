// blitz3dsdk applicationdemo.cpp

// needs platform sdk installed for visual studio express usage
// see consoledemo for project with no such restrictions

// select the example by uncommenting from the tests below
#include <windows.h>

#include "../../include/blitz3dsdk.h"
#include "blitz3dsdkexamples.h"

extern int WINAPI WinMain(HINSTANCE hThisInst,HINSTANCE hPrevInst,LPSTR lpszArgs,int nWinMode){
	bbBeginBlitz3D();
//	playtron();
//	animtest();
//	insaner();
//	xfighter();
//	audiotest();
//	teapottest();
	flagtest();
//	dragontest();
//	collidetest();
//	movietest();
//	firepaint();
	bbEndBlitz3D();
	return 0;
}
