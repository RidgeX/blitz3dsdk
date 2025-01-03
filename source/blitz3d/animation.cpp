
#include "std.h"
#include "animation.h"

struct Animation::Rep{

	int ref_cnt;

	typedef map<int,Quat> KeyList;

	KeyList scale_anim,rot_anim,pos_anim;

	Rep():
	ref_cnt(1){
	}

	Rep( const Rep &t ):
	ref_cnt(1),
	scale_anim(t.scale_anim),rot_anim(t.rot_anim),pos_anim(t.pos_anim){
	}

	Vector getLinearValue( const KeyList &keys,float time )const{
		KeyList::const_iterator next,curr;
		curr=next=keys.lower_bound((int)time);
		curr--;
		if (next==keys.end()) return curr->second.v;
		if (next==keys.begin()) return next->second.v;
		float delta=( time-curr->first )/( next->first-curr->first );
		return (next->second.v-curr->second.v)*delta+curr->second.v;
	}
	
	Quat getSlerpValue( const KeyList &keys,float time )const{
		KeyList::const_iterator next,curr;
		curr=next=keys.lower_bound((int)time);
		curr--;
		if (next==keys.end()) return curr->second;
		if (next==keys.begin()) return next->second;
		float delta=( time-curr->first )/( next->first-curr->first );
		Quat t;
		t=curr->second.slerpTo( next->second,delta );
		return t;
	}

	void setKey( KeyList &keys,int time,const Quat &value ){
		keys[time]=value;
	}
};

Animation::Animation():
rep( d_new Rep() ){
}

Animation::Animation( const Animation &t ):
rep( t.rep ){
	++rep->ref_cnt;
}

Animation::Animation( const Animation &t,int first,int last ):
rep( d_new Rep() ){
	Rep::KeyList::const_iterator it;
	for( it=t.rep->pos_anim.begin();it!=t.rep->pos_anim.end();++it ){
		if( it->first<first || it->first>last ) continue;
		rep->setKey( rep->pos_anim,it->first-first,it->second );
	}
	for( it=t.rep->scale_anim.begin();it!=t.rep->scale_anim.end();++it ){
		if( it->first<first || it->first>last ) continue;
		rep->setKey( rep->scale_anim,it->first-first,it->second );
	}
	for( it=t.rep->rot_anim.begin();it!=t.rep->rot_anim.end();++it ){
		if( it->first<first || it->first>last ) continue;
		rep->setKey( rep->rot_anim,it->first-first,it->second );
	}
}

Animation::~Animation(){
	if( !--rep->ref_cnt ) delete rep;
}

Animation &Animation::operator=( const Animation &t ){
	++t.rep->ref_cnt;
	if( !--rep->ref_cnt ) delete rep;
	rep=t.rep;
	return *this;
}

Animation::Rep *Animation::write(){
	if( rep->ref_cnt>1 ){
		--rep->ref_cnt;
		rep=d_new Rep( *rep );
	}
	return rep;
}

void Animation::setScaleKey( int time,const Vector &q ){
	write();
	rep->setKey( rep->scale_anim,time,Quat( 0,q ) );
}

void Animation::setPositionKey( int time,const Vector &q ){
	write();
	rep->setKey( rep->pos_anim,time,Quat( 0,q ) );
}

void Animation::setRotationKey( int time,const Quat &q ){
	write();
	rep->setKey( rep->rot_anim,time,q );
}

int Animation::numScaleKeys()const{
	return rep->scale_anim.size();
}

int Animation::numRotationKeys()const{
	return rep->rot_anim.size();
}

int Animation::numPositionKeys()const{
	return rep->pos_anim.size();
}

Vector Animation::getScale( float time )const{
	if( !rep->scale_anim.size() ) return Vector(1,1,1);
	return rep->getLinearValue( rep->scale_anim,time );
}

Vector Animation::getPosition( float time )const{
	if( !rep->pos_anim.size() ) return Vector(0,0,0);
	return rep->getLinearValue( rep->pos_anim,time );
}

Quat Animation::getRotation( float time )const{
	if( !rep->rot_anim.size() ) return Quat();
	return rep->getSlerpValue( rep->rot_anim,time );
}
