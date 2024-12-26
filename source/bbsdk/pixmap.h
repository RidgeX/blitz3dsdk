
#ifndef PIXMAP_H
#define PIXMAP_H

//#define PF_I8 1
//#define PF_A8 2
#define PF_BGR888 3
//#define PF_RGB888 4
#define PF_BGRA8888 5
//#define PF_RGBA8888 6

struct pixmap{
	char	*pixels;
	int		width,height,pitch,format,capacity;
};

pixmap *CreatePixmap(int w,int h,int format);
void WritePixmap( pixmap *dest,int x,int y,int a,int r,int g,int b);
pixmap *LoadPixmap(const char *path);
pixmap *ConvertPixmap( pixmap *src,int format );

//extern "C" pixmap *brl_pixmap_LoadPixmap( BBString *url );
//extern "C" pixmap *brl_pixmap_ConvertPixmap( pixmap *src,int format );

//extern BBObject bbNullObject;
//const chaBBString *bbStringFromCString(const char*cstr);
///const char* bbStringToCString( BBString *t );

//extern "C" pixmap *brl_pixmap_LoadPixmap( BBString *url );
//extern "C" pixmap *brl_pixmap_ConvertPixmap( pixmap *src,int format );

#endif
