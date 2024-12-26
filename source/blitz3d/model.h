
#ifndef MODEL_H
#define MODEL_H

// 28.4.07 added QUEUE_ALPHA

#include "brush.h"
#include "object.h"
#include "rendercontext.h"

class Sprite;
class Terrain;
class PlaneModel;
class Q3BSPModel;

class Model : public Object{
public:
	enum{
		RENDER_SPACE_LOCAL=0,
		RENDER_SPACE_WORLD=1
	};
	enum{
		COLLISION_GEOMETRY_DEFAULT=0,
		COLLISION_GEOMETRY_TRIS=1,
		COLLISION_GEOMETRY_BOX=2,
		COLLISION_GEOMETRY_SPHERE=3
	};
	enum{
		QUEUE_OPAQUE=0,
		QUEUE_ALPHA=1,
		QUEUE_TRANSPARENT=2,
	};

	Model();
	Model( const Model &m );

	//Entity interface
	Model *getModel(){ return this; }

	//Object interface
	void capture();
	bool beginRender( float tween );

	//Model interface
	virtual void setRenderBrush( const Brush &b ){}
	virtual void render( const RenderContext &rc ){}

	virtual Sprite *getSprite(){ return 0; }
	virtual Terrain *getTerrain(){ return 0; }
	virtual PlaneModel *getPlaneModel(){ return 0; }
	virtual MeshModel *getMeshModel(){ return 0; }
	virtual MD2Model *getMD2Model(){ return 0; }
	virtual Q3BSPModel *getBSPModel(){ return 0; }

	virtual void setBrush( const Brush &b ){ brush=b;w_brush=true; }
	virtual void setColor( const Vector &c ){ brush.setColor(c);w_brush=true; }
	virtual void setAlpha( float a ){ brush.setAlpha(a);w_brush=true; }
	virtual void setShininess( float t ){ brush.setShininess(t);w_brush=true; }
	virtual void setTexture( int i,const Texture &t,int f ){ brush.setTexture(i,t,f);w_brush=true; }
	virtual void setBlend( int n ){ brush.setBlend(n);w_brush=true; }
	virtual void setFX( int n ){ brush.setFX(n);w_brush=true; }

	//Brush *writeBrush(){ w_brush=true;return &brush; }

	const Brush &getBrush()const{ return brush; }

	bool doAutoFade( const Vector &eye );

	void setRenderSpace( int n ){ space=n; }
	void setAutoFade( float nr,float fr ){ auto_fade_nr=nr;auto_fade_fr=fr;auto_fade=true; }

	void enqueue( gxMesh *mesh,int first_vert,int vert_cnt,int first_tri,int tri_cnt );
	void enqueue( gxMesh *mesh,int first_vert,int vert_cnt,int first_tri,int tri_cnt,const Brush &b );

	void renderQueue( int type );
	void preRenderQueue( int type );

	int getRenderSpace()const{ return space; }
	int queueSize( int type )const{ return (int)queues[type].size(); }

private:
	class MeshQueue;

	int space;
	Brush brush,render_brush;

	mutable bool w_brush;
	float captured_alpha,tweened_alpha;

	bool auto_fade;
	float auto_fade_nr,auto_fade_fr;

	vector<MeshQueue*> queues[3];

	void enqueue( MeshQueue *q );
};

#endif
