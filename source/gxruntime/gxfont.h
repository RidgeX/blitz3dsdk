
#ifndef GXFONT_H
#define GXFONT_H

class gxCanvas;
class gxGraphics;

class gxFont{
public:
	enum{
		FONT_BOLD=1,
		FONT_ITALIC=2,
		FONT_UNDERLINE=4
	};

	virtual int getWidth()const=0;	//width of widest char
	virtual int getHeight()const=0;	//height of font
	virtual int getWidth( const char *text ) const=0;	//const std::string &text )const=0;	//width of string
	virtual bool isPrintable( int chr )const=0;	//printable char?
};

#endif
