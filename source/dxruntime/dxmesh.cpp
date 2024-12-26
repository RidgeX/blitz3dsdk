
#include "dxstd.h"
#include "dxmesh.h"
#include "dxgraphics.h"
#include "dxruntime.h"

static const int VTXFMT=
D3DFVF_XYZ|D3DFVF_NORMAL|D3DFVF_DIFFUSE|D3DFVF_TEX2|
D3DFVF_TEXCOORDSIZE2(0)|D3DFVF_TEXCOORDSIZE2(1);

dxMesh::dxMesh( dxGraphics *g,int max_vs,int max_ts ):
	graphics(g),
	locked_verts(0),
	vert_count(max_vs),
	tri_count(max_ts),
	mesh_dirty(false),
	vertex_buff(0),
	buffercount(0)
{
	D3DVERTEXBUFFERDESC desc={ sizeof(desc),D3DVBCAPS_WRITEONLY,VTXFMT,vert_count};

	if( graphics->dir3d->CreateVertexBuffer( &desc,&vertex_buffers[0],0 )<0 ){
		vertex_buffers[0]=0;
	}
	vertex_buffers[1]=0;

	tri_indices=d_new WORD[tri_count*3];
}

dxMesh::~dxMesh(){
}

void dxMesh::free(){	//~dxMesh
	unlock();

	for (int i=0;i<2;i++){
		if (vertex_buffers[i]) vertex_buffers[i]->Release();
	}

	if (tri_indices) delete[] tri_indices;
}

dxMesh::dxVertex *dxMesh::errVerts(){
	static dxVertex *verts=new dxVertex[32768];
	return verts;
}

int dxMesh::lock(int locktype){
	if( locked_verts ) return 0;	//should throw error

	switch (locktype){
		case LOCK_REUSE:
			vertex_buff=vertex_buffers[0];
			if (vertex_buff->Lock( DDLOCK_WAIT|DDLOCK_WRITEONLY,(void**)&locked_verts,0 )<0){
				locked_verts=errVerts();
				return 0;
			}
			break;
		case LOCK_DISCARD:
			if( !vertex_buffers[buffercount] ){
				D3DVERTEXBUFFERDESC desc={ sizeof(desc),D3DVBCAPS_WRITEONLY,VTXFMT,vert_count };
				if( graphics->dir3d->CreateVertexBuffer( &desc,&vertex_buffers[buffercount],0 )<0 ){
					vertex_buffers[buffercount]=0;
					locked_verts=errVerts();
					return 0;
				}
			}
			vertex_buff=vertex_buffers[buffercount];buffercount^=1;
			if (vertex_buff->Lock( DDLOCK_WAIT|DDLOCK_WRITEONLY|DDLOCK_DISCARDCONTENTS,(void**)&locked_verts,0 )<0){
				locked_verts=errVerts();
				return 0;
			}
			break;
	}
	//Not strictly correct for DISCARD surfaces - really need 2 dirty flags.
	//But discard surfaces are currently always updated, so it's OK for now...
	mesh_dirty=false;
	return 0;
}

void dxMesh::unlock(){
	if( locked_verts ){
		vertex_buff->Unlock();
		locked_verts=0;
	}
}

void dxMesh::backup(){
	unlock();
}

void dxMesh::restore(){
	mesh_dirty=true;
}

void dxMesh::render( int first_vert,int vert_cnt,int first_tri,int tri_cnt ){
	if (vert_cnt==0||tri_cnt==0) 
			return;		//throw L"chunks";

	if (first_vert<0||(first_vert+vert_cnt)>vert_count||first_tri<0||(first_tri+tri_cnt)>tri_count) throw L"chunks";

	unlock();
	graphics->dir3dDev->DrawIndexedPrimitiveVB(
		D3DPT_TRIANGLELIST,
		vertex_buff,first_vert,vert_cnt,
		tri_indices+first_tri*3,tri_cnt*3,0 );
}
