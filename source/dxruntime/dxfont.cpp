
#include "dxstd.h"
#include "dxfont.h"
#include "dxcanvas.h"
#include "dxgraphics.h"

dxFont::dxFont( dxGraphics *g,dxCanvas *c,int w,int h,int b,int e,int d,int *os,int *ws ):
graphics(g),canvas(c),
width(w),height(h),begin_char(b),end_char(e),def_char(d),
offs(os),widths(ws){
	canvas->setMask( 0xffffff );
	t_canvas=(dxCanvas*)graphics->createCanvas( graphics->getWidth(),height,0 );	//simon was here
}

dxFont::~dxFont(){
	delete[] offs;
	delete[] widths;
	graphics->freeCanvas( t_canvas );
	graphics->freeCanvas( canvas );
}

int dxFont::charWidth( int c )const{
	if( c<begin_char || c>=end_char ) c=def_char;
	return widths[c-begin_char];
}

void dxFont::render( dxCanvas *dest,unsigned color_argb,int x,int y,const string &t ){
	int width=getWidth( t.c_str() );
	if( width>t_canvas->getWidth() ){
		graphics->freeCanvas( t_canvas );
		t_canvas=(dxCanvas*)graphics->createCanvas( width,height,0 );	//simon was here
	}

	t_canvas->setColor( color_argb );
	if( !(t_canvas->getColor()&0xffffff) ) t_canvas->setColor( 0x10 );
	t_canvas->rect( 0,0,width,height,true );

	int t_x=0;
	for( int k=0;k<t.size();++k ){
		int c=t[k]&0xff;
		if( c<begin_char || c>=end_char ) c=def_char;
		c-=begin_char;
		int sx=(offs[c]>>16)&0xffff,sy=offs[c]&0xffff;
		t_canvas->blit( t_x,0,canvas,sx,sy,widths[c],height,false );
		t_x+=widths[c];
	}

	dest->blit( x,y,t_canvas,0,0,width,height,false );
}

int dxFont::getWidth()const{
	return width;
}

int dxFont::getHeight()const{
	return height;
}

int dxFont::getWidth( const char *text )const{	//string &
	int w=0;
	string t=text;
	for( int k=0;k<t.size();++k ){
		int c=t[k]&0xff;
		if( c<begin_char || c>=end_char ) c=def_char;
		w+=widths[c-begin_char];
	}
	return w;
}

bool dxFont::isPrintable( int chr )const{
	return chr>=begin_char && chr<end_char;
}
