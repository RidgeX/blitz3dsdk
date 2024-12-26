// bbsdk.cpp : Defines the entry point for the DLL application.
//

#include "stdafx.h"
#include "bbsdk.h"

#include "../gxruntime/gxruntime.h"

#ifdef _WIN32
#include "../dxruntime/dxruntime.h"
#endif

#ifdef _MANAGED
#pragma managed(push, off)
#endif

BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
					 )
{
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
	case DLL_PROCESS_DETACH:
		break;
	}
    return TRUE;
}

#ifdef _MANAGED
#pragma managed(pop)
#endif

// BLITZ3DSDK PUBLIC DEFINITIONS


BBSDK_API int bbVersion(){
	return 24;  //bumped by simon 29/9/2007
}

//extern "C" void blitz3d_close();
//extern "C" void blitz3d_open();


/*
// This is an example of an exported variable
BBSDK_API int nbbsdk=0;

// This is an example of an exported function.
BBSDK_API int fnbbsdk(void)
{
	return 42;
}

// This is the constructor of a class that has been exported.
// see bbsdk.h for the class definition
Cbbsdk::Cbbsdk()
{
	return;
}
*/
