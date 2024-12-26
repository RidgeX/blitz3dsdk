
#include "std.h"
#include "geom.h"

Matrix Matrix::tmps[64];
Transform Transform::tmps[64];

Quat rotationQuat( float p,float y,float r ){
	return yawQuat(y)*pitchQuat(p)*rollQuat(r);
}


/*
Quat Quat::slerpTo( const Quat &q,float a ) const{
	Quat t=q;
	float d=dot(q),b=1-a;
	if( d<0 ){ t.w=-t.w;t.v=-t.v;d=-d; }
	if( d<1-EPSILON ){
		float om=acosf( d );
		float si=sinf( om );
		a=sinf( a*om )/si;
		b=sinf( b*om )/si;
	}
//	Quat tt=*this*b + t*a;
//	return tt;
		return (*this*b + t*a);		//simon was here
}
*/

/*
Quat rotationQuat( float p,float y,float r ){
	float sp=sin(p/-2),cp=cos(p/-2);
	float sy=sin(y/ 2),cy=cos(y/ 2);
	float sr=sin(r/-2),cr=cos(r/-2);
	float qw=cr*cp*cy + sr*sp*sy;
	float qx=cr*sp*cy + sr*cp*sy;
	float qy=cr*cp*sy - sr*sp*cy;
	float qz=sr*cp*cy - cr*sp*sy;
	return Quat( qw,Vector(-qx,-qy,qz) );
}
*/
