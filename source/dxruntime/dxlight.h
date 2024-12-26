
#ifndef DXLIGHT_H
#define DXLIGHT_H

#include "../gxruntime/gxlight.h"

class dxScene;

class dxLight:public gxLight{
public:
	dxLight( dxScene *scene,int type );
	~dxLight();

	D3DLIGHT7 d3d_light;

private:
	dxScene *scene;

	/***** GX INTERFACE *****/
public:
	enum{
		LIGHT_DISTANT=1,LIGHT_POINT=2,LIGHT_SPOT=3
	};
	void setRange( float range );
	void setColor( const float rgb[3] ){ memcpy( &d3d_light.dcvDiffuse,rgb,12 ); }
	void setPosition( const float pos[3] );
	void setDirection( const float dir[3] );
	void setConeAngles( float inner,float outer );

	void getColor( float rgb[3] ){ memcpy( rgb,&d3d_light.dcvDiffuse,12 ); }
};

#endif
