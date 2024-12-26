
#ifndef DXFONT_H
#define DXFONT_H

#include "../gxruntime/gxfont.h"

class dxCanvas;
class dxGraphics;

typedef IDirectDrawSurface7 ddSurf;

class dxFont:public gxFont{
public:
	dxFont(
		dxGraphics *graphics,dxCanvas *canvas,
		int width,int height,int begin_char,int end_char,int def_char,
		int *offs,int *widths );
	~dxFont();

	int charWidth( int c )const;
	void render( dxCanvas *dest,unsigned color_argb,int x,int y,const std::string &t );

private:
	dxGraphics *graphics;
	dxCanvas *canvas,*t_canvas;
	int width,height,begin_char,end_char,def_char;
	int *offs,*widths;

	/***** GX INTERFACE *****/
public:
	enum{
		FONT_BOLD=1,
		FONT_ITALIC=2,
		FONT_UNDERLINE=4
	};

	//ACCESSORS
	int getWidth()const;							//width of widest char
	int getHeight()const;							//height of font
	int getWidth( const char *text )const;			//std::string & width of string
	bool isPrintable( int chr )const;				//printable char?
};

#endif
