// jconfig.h

#ifndef jconfig_h
#define jconfig_h

#define HAVE_PROTOTYPES
#define HAVE_UNSIGNED_CHAR
#define HAVE_UNSIGNED_SHORT
#define CHAR_IS_UNSIGNED
#define USE_MSDOS_MEMMGR
#define NULL 0
#define NO_GETENV

//extern unsigned int nitroread(struct _iobuf *f,void *buf,unsigned int size);
//extern unsigned int nitrowrite(struct _iobuf *f,void *buf,unsigned int size);
//extern void nitroflush(struct _iobuf *f);

//#define JFREAD(file,buf,sizeofbuf) nitroread(file,buf,sizeofbuf)
//#define JFWRITE(file,buf,sizeofbuf) nitrowrite(file,buf,sizeofbuf)
//#define JFFLUSH(file) nitroflush(file)

//((input*)file)->read(buf,sizeofbuf)

//((size_t) fread((void *) (buf), (size_t) 1, (size_t) (sizeofbuf), (file)))

//typedef unsigned int size_t;
//typedef void FILE;
//void *malloc(size_t size);
//void free(void *memblock);
//int printf(char *s);
//void *myfindmethod(void *ac,char *c);	//void = struct aclass
//int mydebug(char *s,int v0,int v1,int v2);
//int XSWAPXCPT(int x);
//void plot(int x,int y,int c);
//void exit();

#endif
