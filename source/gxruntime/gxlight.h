
#ifndef GXLIGHT_H
#define GXLIGHT_H

class gxScene;

class gxLight{
public:
	enum{
		LIGHT_DISTANT=1,LIGHT_POINT=2,LIGHT_SPOT=3
	};
	virtual void setRange( float range )=0;
	virtual void setColor( const float rgb[3] )=0;
	virtual void setPosition( const float pos[3] )=0;
	virtual void setDirection( const float dir[3] )=0;
	virtual void setConeAngles( float inner,float outer )=0;
	virtual void getColor( float rgb[3] )=0;
};

#endif
