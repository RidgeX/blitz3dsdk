
#ifndef DXSCENE_H
#define DXSCENE_H

#include "../gxruntime/gxscene.h"

#include <map>
#include <d3d.h>

#include "dxlight.h"

class dxCanvas;

class dxMesh;
class dxLight;
class dxGraphics;
class gxTexture;

class dxScene:public gxScene{
public:
	dxGraphics *graphics;
	IDirect3DDevice7 *dir3dDev;

	dxScene( dxGraphics *graphics,dxCanvas *target );
	~dxScene();

	void setEnabled( dxLight *light,bool enabled );

	/***** GX INTERFACE *****/
public:
	//state
	int  hwTexUnits();
	int  gfxDriverCaps3D();

	virtual int  gfxDriverX();
	int  gfxDriverY();
	int  gfxDriverHz();

	void setWBuffer( bool enable );
	void setHWMultiTex( bool enable );
	void setDither( bool enable );
	void setAntialias( int level );
	void setWireframe( bool enable );
	void setFlippedTris( bool enable );
	void setAmbient( const float rgb[3] );
	void setAmbient2( const float rgb[3] );
	void setFogColor( const float rgb[3] );
	void setFogRange( float nr,float fr );
	void setFogMode( int mode );
	void setZMode( int mode );
	void setViewport( int x,int y,int w,int h );
	void setOrthoProj( float nr,float fr,float nr_w,float nr_h );
	void setPerspProj( float nr,float fr,float nr_w,float nr_h );
	void setViewMatrix( const Matrix *matrix );
	void setWorldMatrix( const Matrix *matrix );
	void setRenderState( const RenderState &state );

	//rendering
	void begin( int lightcount,gxLight **listlist);	//const std::vector<gxLight*> &lights );
	void clear( const float rgb[3],float alpha,float z,bool clear_argb,bool clear_z );
	void render( gxMesh *mesh,int first_vert,int vert_cnt,int first_tri,int tri_cnt );
	void end();

	//lighting
	gxLight *createLight( int flags );
	void freeLight( gxLight *l );

	//info
	int getTrianglesDrawn()const;

private:
	dxCanvas *target;
	bool wbuffer,dither,wireframe,flipped;
	int antialias;
	unsigned ambient,ambient2,fogcolor;
	int caps_level,fogmode,zmode;
	int display_x,display_y,display_hz;
	float fogrange_nr,fogrange_fr;
	D3DVIEWPORT7 viewport;
	bool ortho_proj;
	float frustum_nr,frustum_fr,frustum_w,frustum_h;
	D3DMATRIX projmatrix,viewmatrix,worldmatrix;
	D3DMATRIX inv_viewmatrix;
	D3DMATERIAL7 material;
	float shininess;
	int blend,fx;
	struct TexState{
		dxCanvas *canvas;
		int blend,flags;
		D3DMATRIX matrix;
		bool mat_valid;
	};
	TexState texstate[MAX_TEXTURES];
	int n_texs,tris_drawn;

	std::set<dxLight*> _allLights;
	std::vector<dxLight*> _curLights;

	int d3d_rs[160];
	int d3d_tss[8][32];

	void setRS( int n,int t );
	void setTSS( int n,int s,int t );

	void setLights();
	void setZMode();
	void setAmbient();
	void setFogMode();
	void setTriCull();
	void setTexState( int index,const TexState &state,bool set_blend );
};

#endif
