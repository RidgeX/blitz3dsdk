#include "stdafx.h"

#include "pixmap.h"
#include "..\png\png.h"
#include <stdio.h>
#include <malloc.h>

extern "C" 
{
#include "..\jpeg\jpeglib.h"
}

pixmap *readpng(FILE *file,int flags);
pixmap *readjpeg(FILE *file,int flags);
pixmap *readbmp(FILE *file,int flags);
pixmap *readtga(FILE *file,int flags);

#define ALPHAFLAG 1 
#define ALPHAONLYFLAG 2 
#define MASKFLAG 4 

pixmap *CreatePixmap(int w,int h,int format){
	pixmap *pix;
	pix=new pixmap;
	pix->width=w;
	pix->height=h;
	pix->capacity=w*h*4;
	pix->format=format;
	pix->pitch=w*4;
	pix->pixels=(char*)calloc(w*h,4);
	return pix;
}
void WritePixmap(pixmap *pix,int x,int y,int a,int r,int g,int b){
	if (x>=0&&x<pix->width&&y>=0&&y<pix->height){
		int argb=a<<24|r<<16|g<<8|b;
		*(int*)&pix->pixels[x*4+y*pix->pitch]=argb;
	}
}
/*
	switch (pix->format){
		case PF_BGR888:
			char *p=	pix->pixels+x*3+y*pix->pitch
			p[0]=(char)b;
			p[1]=(char)g;
			p[2]=(char)r;
			break;
		case PF_BGRA8888:
			int argb=a<<24|r<<16|g<<8|b;
			*(int*)&pix->pixels[x*4+y*pix->pitch]=argb;
			break;
	}
*/
pixmap *LoadPixmap(const char *path){
	FILE *file;
	pixmap *pix=0;
	file=fopen(path,"rb");
	if (file) {
		pix=readpng(file,0);
		if (!pix){
			fseek(file,0,SEEK_SET);
			pix=readbmp(file,0);
		}
		if (!pix){
			fseek(file,0,SEEK_SET);
			pix=readjpeg(file,0);
		}
		if (!pix){
			fseek(file,0,SEEK_SET);
			pix=readtga(file,0);
		}
		fclose(file);
	}
	return pix;
}

pixmap *ConvertPixmap( pixmap *src,int format ){
	return src;
}

pixmap *readpng(FILE *file,int flags){
	png_structp		png_ptr;
	png_infop		info_ptr;
	png_infop		end_info;
	png_bytep		row_pointer;

	unsigned char	header[8];
	unsigned long	x,y,xx,yy,xs,ys,width,height;//,flags;
	int				a,i,depth,type,lace,passes,chan;
	unsigned char	*buffer,*b;

	pixmap *pix;

	buffer=0;
	size_t res=fread(header,8,1,file);
	if (res==0) return 0;

	if (png_sig_cmp(header,0,8)) return 0;							//{fclose(file);return 0;}
	png_ptr=png_create_read_struct(PNG_LIBPNG_VER_STRING,0,0,0);	//(png_voidp)user_error_ptr,user_error_fn,user_warning_fn);
	if(!png_ptr) return(0);
	info_ptr=png_create_info_struct(png_ptr);
	if(!info_ptr) {
		png_destroy_read_struct(&png_ptr,(png_infopp)NULL,(png_infopp)NULL);
		return(0);
	}
	if (setjmp(png_jmpbuf(png_ptr)))	{
		png_destroy_read_struct(&png_ptr,&info_ptr,png_infopp_NULL);
		if (buffer) delete buffer;
		return 0;
	}
	end_info=png_create_info_struct(png_ptr);
	if(!end_info) {
		png_destroy_read_struct(&png_ptr,&info_ptr,(png_infopp)NULL);
		return(0);
	}

	png_init_io(png_ptr,file);
	png_set_sig_bytes(png_ptr, 8);
// read header
    png_read_info(png_ptr,info_ptr);
    png_get_IHDR(png_ptr,info_ptr,&width,&height,&depth,&type,&lace,0,0);

	if (type&PNG_COLOR_MASK_ALPHA) flags|=ALPHAFLAG;
	if (type==PNG_COLOR_TYPE_PALETTE) png_set_palette_to_rgb(png_ptr);
	if (type==PNG_COLOR_TYPE_GRAY&&depth<8) png_set_gray_1_2_4_to_8(png_ptr);
	if (png_get_valid(png_ptr,info_ptr,PNG_INFO_tRNS)) {png_set_tRNS_to_alpha(png_ptr);flags|=ALPHAFLAG;}	
	if (depth==16) png_set_strip_16(png_ptr);
    if (depth<8) png_set_packing(png_ptr);
	png_read_update_info(png_ptr,info_ptr);
    png_get_IHDR(png_ptr,info_ptr,&width,&height,&depth,&type,&lace,0,0);
// read image

	if (flags&ALPHAFLAG){
		pix=CreatePixmap(width,height,PF_BGRA8888);
	}else{
		pix=CreatePixmap(width,height,PF_BGR888);
	}
	chan=png_get_channels(png_ptr,info_ptr);
	buffer=new unsigned char[width*chan];
	row_pointer=buffer;
	a=255;
	if (lace==PNG_INTERLACE_NONE){
		for (y=0;y<height;y++){
			png_read_row(png_ptr,row_pointer,NULL);
			b=buffer;
			for (x=0;x<width;x++){
				if (chan==4) a=b[3];
				WritePixmap(pix,x,y,a,b[0],b[1],b[2]);
				b+=chan;
			}
		}
	}else{
		passes=7;//png_set_interlace_handling(png_ptr);
		for (i=0;i<passes;i++){
			switch (i){
				case 0:xx=0;yy=0;xs=8;ys=8;break;
				case 1:xx=4;yy=0;xs=8;ys=8;break;
				case 2:xx=0;yy=4;xs=4;ys=8;break;
				case 3:xx=2;yy=0;xs=4;ys=4;break;
				case 4:xx=0;yy=2;xs=2;ys=4;break;
				case 5:xx=1;yy=0;xs=2;ys=2;break;
				case 6:xx=0;yy=1;xs=1;ys=2;break;
			}
			for (y=yy;y<height;y+=ys){
				png_read_row(png_ptr,row_pointer,NULL);
				b=buffer;
				for (x=xx;x<width;x+=xs){
					if (chan==4) a=b[3];
					WritePixmap(pix,x,y,a,b[0],b[1],b[2]);
					b+=chan;
				}
			}

		}
	}
	delete buffer;
	png_read_end(png_ptr,0);//end_info);
	png_destroy_read_struct(&png_ptr,&info_ptr,&end_info);
	return	pix;
}

static void format_message (j_common_ptr cinfo, char * buffer) {}
static void output_message (j_common_ptr cinfo) {}//printf("jpeg error\n");}
static void emit_message (j_common_ptr cinfo, int msg_level) {}

static void reset_error_mgr (j_common_ptr cinfo){
	cinfo->err->num_warnings=0;
	cinfo->err->msg_code = 0;	/* may be useful as a flag for "no error" */
}

static void error_exit (j_common_ptr cinfo){
	(*cinfo->err->output_message) (cinfo);
	jpeg_destroy(cinfo);
}


void initjpg(jpeg_error_mgr * err){	
}

void initjerr(jpeg_error_mgr *jerr){
	jerr->error_exit = error_exit;
	jerr->emit_message = emit_message;
	jerr->output_message = output_message;
	jerr->format_message = format_message;
	jerr->reset_error_mgr = reset_error_mgr;
	jerr->trace_level = 0;		// default = no tracing 
	jerr->num_warnings = 0;	// no warnings emitted yet 
	jerr->msg_code = 0;		// may be useful as a flag for "no error" 
// Initialize message table pointers 
	jerr->jpeg_message_table = NULL;		//jpeg_std_message_table;
	jerr->last_jpeg_message = 0;		//(int) JMSG_LASTMSGCODE - 1;
//  jerr->jpeg_message_table = jpeg_std_message_table;
//  jerr->last_jpeg_message = (int) JMSG_LASTMSGCODE - 1;
	jerr->addon_message_table = NULL;
	jerr->first_addon_message = 0;	// for safety 
	jerr->last_addon_message = 0;
}

jpeg_decompress_struct cinfo;
jpeg_error_mgr jerr;

pixmap *readjpeg(FILE *file,int flags){
	unsigned char *buffer,*b;
	int span,chan,x,y,isjpg;
	char hdr[10];
	pixmap *pix;
	size_t n=fread(hdr,1,10,file);
	if (n!=10) return 0;
	isjpg=false;
	if (hdr[6]=='J'&&hdr[7]=='F'&&hdr[8]=='I'&&hdr[9]=='F') isjpg=true;
	if (hdr[6]=='E'&&hdr[7]=='x'&&hdr[8]=='i'&&hdr[9]=='f') isjpg=true;
	if (!isjpg) return 0;
	fseek(file,0,SEEK_SET);
// init jpeg lib
	initjerr(&jerr);
	cinfo.err=&jerr;	
	jpeg_create_decompress(&cinfo);
	jpeg_stdio_src(&cinfo,file);
	jpeg_read_header(&cinfo,TRUE);
	jpeg_start_decompress(&cinfo);
// init rmap
	chan=cinfo.output_components;
//	if (chan==1) flags|=ALPHAONLYFLAG;
	if (chan==4) flags|=ALPHAFLAG;

	int w,h;
	w=cinfo.output_width;
	h=cinfo.output_height;

	if (flags&(ALPHAFLAG||ALPHAONLYFLAG)){
		pix=CreatePixmap(w,h,PF_BGRA8888);
	}else{
		pix=CreatePixmap(w,h,PF_BGR888);
	}
	span=w*chan;
	buffer=new unsigned char[span];
// read
	for (y=0;y<h;y++){
		jpeg_read_scanlines(&cinfo,(JSAMPARRAY)&buffer,1);
		b=buffer;
		switch (chan){
		case 1:
			for (x=0;x<w;x++){
				int c=b[0];
				WritePixmap(pix,x,y,255,c,c,c);//b[0],255,255,255);
				b++;
			}
			break;
		case 3:
			if (flags&ALPHAONLYFLAG){
				for (x=0;x<w;x++){
					WritePixmap(pix,x,y,b[0],255,255,255);
					b+=3;
				}
			}else{
				for (x=0;x<w;x++){
					WritePixmap(pix,x,y,255,b[0],b[1],b[2]);
					b+=3;
				}
			}
			break;
		case 4:
			for (x=0;x<w;x++){
				WritePixmap(pix,x,y,b[3],b[0],b[1],b[2]);
				b+=4;
			}
			break;
		}
	}
// close
	jpeg_finish_decompress(&cinfo);	
	delete buffer;
	jpeg_destroy_decompress(&cinfo);
	return pix;
}


pixmap *readjpeg(FILE *file,int flags);

#define BI_RLE8 1

struct BMHDR{
	int     biSize;
	int     biWidth;
	int     biHeight;
	short   biPlanes;
	short   biBitCount;
	int     biCompression;
	int     biSizeImage;
	int     biXPelsPerMeter;
	int     biYPelsPerMeter;
	int     biClrUsed;
	int     biClrImportant;
};

pixmap *readbmp(FILE *file,int flags){
	BMHDR *bm;
	int x,y,w,h,colors,mod;
	unsigned char *b,bb,rlen,rcol;
	unsigned int *c;
	void *dib;
	int sz,res;
	pixmap *pix;

	if (fgetc(file)!='B') return 0;
	if (fgetc(file)!='M') return 0;
	sz=0;
	fread(&sz,4,1,file);	//sz=in->readint();
	fseek(file,8,SEEK_CUR);
	sz-=14;
	if(sz<0||sz>65536*64) return 0;
	res=0;
	dib=malloc(sz);
	if (dib==0) return 0;
	fread(dib,sz,1,file);		//in->read(dib,sz);		

	bm=(BMHDR*)dib;
	if (bm->biSize!=40) return 0;
	w=bm->biWidth;
	h=bm->biHeight;

	pix=CreatePixmap(w,h,PF_BGR888);	//A8888);
	b=(unsigned char*)dib+40;
	if (bm->biCompression==3) b+=12;	//BI_BITFIELDS=3
	x=0;
	switch (bm->biBitCount){
	case 4:
		c=(unsigned int*)b;
		colors=bm->biClrUsed;
		if (colors==0) colors=16;
		b+=colors*4;
		mod=(w+3)&0xfffc;
		for (y=h-1;y>=0;y--){
			for (x=0;x<w;x+=2){
				bb=b[x>>1];
				WritePixmap(pix,x,y,255,0,0,c[bb&15]);
				WritePixmap(pix,x+1,y,255,0,0,c[bb>>4]);
			}
			b+=mod/2;
		}
		break;
	case 8:
		c=(unsigned int*)b;
		colors=bm->biClrUsed;
		if (colors==0) colors=256;
		b+=colors*4;
		mod=(w+3)&0xfffc;
		if (bm->biCompression==BI_RLE8){
			for (y=h-1;y>=0;y--){
				for (x=0;x<w;){
					rlen=*b++;
					rcol=*b++;
					while (rlen--){
						WritePixmap(pix,x++,y,255,0,0,c[rcol]);
					}
				}
			}
		}else{
			for (y=h-1;y>=0;y--){
				for (x=0;x<w;x++){
					WritePixmap(pix,x,y,255,0,0,c[b[x]]);
				}
				b+=mod;
			}
		}
		break;
	case 16:
		break;
	case 24:
		mod=(w*3+3)&0xfffc;
		for (y=h-1;y>=0;y--){
			for(x=0;x<w;x++){
				WritePixmap(pix,x,y,255,b[2],b[1],b[0]);
				b+=3;
			}
			b+=mod-w*3;
		}
		break;
	case 32:
		mod=(w*4+3)&0xfffc;
		for (y=h-1;y>=0;y--){
			for(x=0;x<w;x++){
				WritePixmap(pix,x,y,255,b[0],b[1],b[2]);
				b+=4;
			}
			b+=mod-w*4;
		}
		break;
	}
	free(dib);
	return pix;
}


#define TGA_NULL 0
#define TGA_MAP 1
#define TGA_RGB 2
#define TGA_MONO 3
#define TGA_RLEMAP 9
#define TGA_RLERGB 10
#define TGA_RLEMONO 11
#define TGA_COMPMAP 32
#define TGA_COMPMAP4 33

struct tgahdr{
	unsigned char idlen,colourmaptype,imgtype,indexlo,indexhi,lenlo,lenhi,cosize;
	short x0,y0,width,height;
	char psize,attbits;
};

pixmap *readtga(FILE *file,int flags){
	tgahdr hdr;
	int x,y,w,h,n,t,bits,clen,cbits;
	int *buffer,*cmap;
	unsigned char *p,*c;
	unsigned short *s;
	pixmap *pix;

	fread(&hdr,18,1,file);
	bits=hdr.psize;
	w=hdr.width;
	h=hdr.height;
	t=hdr.imgtype;

	if (hdr.colourmaptype) return 0;
	if (!(t==TGA_MAP||t==TGA_RGB||t==TGA_RLERGB)) return 0;
	if (!(bits==15||bits==16||bits==24||bits==32)) return 0;	
	if (w<16||w>4096) return 0;
	if (h<16||h>4096) return 0;
	if (bits==16) flags|=MASKFLAG;
	if (bits==32) flags|=ALPHAFLAG;

	fseek(file,hdr.idlen,SEEK_CUR);
	buffer=new int[w];

	if (flags&ALPHAFLAG){
		pix=CreatePixmap(w,h,PF_BGRA8888);
	}else{
		pix=CreatePixmap(w,h,PF_BGR888);
	}

	switch (hdr.imgtype){
	case TGA_MAP:
		clen=(hdr.lenhi<<8)|hdr.lenlo;
		cbits=hdr.cosize;
		cmap=new int[clen];
		fread(cmap,clen*((cbits+7)/8),1,file);
		for (y=h-1;y>=0;y--){
			fread(buffer,w,1,file);
			c=(unsigned char *)buffer;
			s=(unsigned short *)cmap;
			switch (cbits){
			case 15:for (x=0;x<w;x++) {t=s[*c++*2];WritePixmap(pix,x,y,255,(t>>7)&0xf8,(t>>2)&0xf8,(t<<3)&0xf8);}break;
			case 16:for (x=0;x<w;x++) {t=s[*c++*2];WritePixmap(pix,x,y,(t&0x8000)?0:255,(t>>7)&0xf8,(t>>2)&0xf8,(t<<3)&0xf8);}break;
			case 24:for (x=0;x<w;x++) {p=(unsigned char *)cmap+*c++*3;WritePixmap(pix,x,y,255,p[2],p[1],p[0]);p+=3;}break;
			case 32:for (x=0;x<w;x++) {p=(unsigned char *)cmap+*c++*4;WritePixmap(pix,x,y,p[3],p[2],p[1],p[0]);p+=4;}break;
			}
		}
		delete cmap;
		break;

	case TGA_RGB:
		for (y=h-1;y>=0;y--){
			fread(buffer,w*(bits/8),1,file);
			switch (bits){
			case 15:s=(unsigned short *)buffer;for (x=0;x<w;x++) {t=*s++;WritePixmap(pix,x,y,255,(t>>7)&0xf8,(t>>2)&0xf8,(t<<3)&0xf8);}break;
			case 16:s=(unsigned short *)buffer;for (x=0;x<w;x++) {t=*s++;WritePixmap(pix,x,y,(t&0x8000)?0:255,(t>>7)&0xf8,(t>>2)&0xf8,(t<<3)&0xf8);}break;
			case 24:p=(unsigned char *)buffer;for (x=0;x<w;x++) {WritePixmap(pix,x,y,255,p[2],p[1],p[0]);p+=3;}break;
			case 32:p=(unsigned char *)buffer;for (x=0;x<w;x++) {WritePixmap(pix,x,y,p[3],p[2],p[1],p[0]);p+=4;}break;
			}
		}
		break;
	
	case TGA_RLERGB:
		for (y=h-1;y>=0;y--){
			x=0;
			while (x<w){
				n=fgetc(file)&255;
				if (n&128){
					n-=127;
					fread(&t,4,1,file);
//					t=in->readint();
					while (n-->0) {
						buffer[x++]=t;
					}
				}else{
					n++;
					fread(buffer+x,4*n,1,file);
					x+=n;
				}
			}
			p=(unsigned char *)buffer;
			for (x=0;x<w;x++){
				WritePixmap(pix,x,y,p[3],p[2],p[1],p[0]);
				p+=4;
			}
		}
		break;
	}
	delete buffer;
	return pix;
}
