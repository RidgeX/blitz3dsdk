
#ifndef GXMESH_H
#define GXMESH_H

class gxGraphics;

class gxMesh{
public:
	enum locktypes{LOCK_REUSE,LOCK_DISCARD};
	virtual bool dirty()=0;
	virtual void free()=0;
	virtual int lock(int locktype)=0;
	virtual void unlock()=0;
	virtual void setVertex( int n,const void *v )=0;
	virtual void setVertex( int n,const float coords[3],const float normal[3],const float tex_coords[2][2] )=0;
	virtual void setVertex( int n,const float coords[3],const float normal[3],unsigned argb,const float tex_coords[2][2] )=0;
	virtual void setTriangle( int n,int v0,int v1,int v2 )=0;
};

#endif
