
#ifndef DXMESH_H
#define DXMESH_H

#include <d3d.h>

#include "../gxruntime/gxmesh.h"

class dxGraphics;

class dxMesh:public gxMesh{
public:

	dxMesh( dxGraphics *graphics,int max_verts,int max_tris );	//IDirect3DVertexBuffer7 *vertsWORD *indicies,
	~dxMesh();

	void render( int first_vert,int vert_cnt,int first_tri,int tri_cnt );
	void backup();
	void restore();
	bool dirty(){ return mesh_dirty; }

private:
	struct dxVertex{
		float coords[3];
		float normal[3];
		unsigned argb;
		float tex_coords[4];
	};

	static dxVertex *errVerts();

	dxGraphics *graphics;

	IDirect3DVertexBuffer7 *vertex_buff;
	
	IDirect3DVertexBuffer7 *vertex_buffers[2];
	int buffercount;	//double buffered buffers solves ati discardable vertex performance issue

	WORD *tri_indices;

//	int max_verts,max_tris;

	int vert_count;
	int tri_count;
	bool mesh_dirty;
	dxVertex *locked_verts;

	/***** GX INTERFACE *****/
public:
	void free();

	int lock(int locktype);
	void unlock();

	//VERY NAUGHTY!!!!!
	void setVertex( int n,const void *v ){
		if (n<0||n>=vert_count) throw L"chunks";
		memcpy( locked_verts+n,v,sizeof(dxVertex) );
	}
	void setVertex( int n,const float coords[3],const float normal[3],const float tex_coords[2][2] ){
		if (n<0||n>=vert_count) throw L"chunks";
		dxVertex *t=locked_verts+n;
		memcpy( t->coords,coords,12 );
		memcpy( t->normal,normal,12 );
		t->argb=0xffffffff;
		memcpy( t->tex_coords,tex_coords,16 );
	}
	void setVertex( int n,const float coords[3],const float normal[3],unsigned argb,const float tex_coords[2][2] ){
		if (n<0||n>=vert_count) throw L"chunks";
		dxVertex *t=locked_verts+n;
		memcpy( t->coords,coords,12 );
		memcpy( t->normal,normal,12 );
		t->argb=argb;
		memcpy( t->tex_coords,tex_coords,16 );
	}
	void setTriangle( int n,int v0,int v1,int v2 ){
		if (n<0||n>=tri_count) throw L"chunks";
		tri_indices[n*3]=v0;
		tri_indices[n*3+1]=v1;
		tri_indices[n*3+2]=v2;
	}
};

#endif
