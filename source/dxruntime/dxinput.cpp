
#include "dxstd.h"
#include "dxinput.h"
#include "dxruntime.h"

static const int QUE_SIZE=32;

class dxDevice : public gxDevice{
private:
	enum{
		QUE_SIZE=32,QUE_MASK=QUE_SIZE-1
	};
	int hit_count[256];			//how many hits of key
	bool down_state[256];			//time key went down
	int que[QUE_SIZE],put,get;


public:
	float axis_states[32];

	dxInput *input;
	bool acquired;
	IDirectInputDevice7 *device;

	dxDevice( dxInput *i,IDirectInputDevice7 *d ):input(i),acquired(false),device(d){
		reset();
	}

	virtual ~dxDevice(){
		if (device) device->Release();
	}
	bool acquire(){
		return acquired=device->Acquire()>=0;
	}
	void unacquire(){
		device->Unacquire();
		acquired=false;
	}

	void setDownState( int key,bool down ){
		if( down==down_state[key] ) return;
		if( down ) downEvent( key );
		else upEvent( key );
	}

	void flush(){
		update();
		memset( hit_count,0,sizeof(hit_count) );
		put=get=0;
	}
	bool keyDown( int key ){
		update();
		return down_state[key];
	}
	int keyHit( int key ){
		update();
		int n=hit_count[key];
		hit_count[key]-=n;
		return n;
	}
	int getKey(){
		update();
		return get<put ? que[get++ & QUE_MASK] : 0;
	}
	float getAxisState( int axis ){
		update();
		return axis_states[axis];
	}
	void reset(){
		memset( down_state,0,sizeof(down_state) );
		memset( axis_states,0,sizeof(axis_states) );
		memset( hit_count,0,sizeof(hit_count) );
		put=get=0;
	}

	void downEvent( int key ){
		down_state[key]=true;
		++hit_count[key];
		if( put-get<QUE_SIZE ) que[put++&QUE_MASK]=key;
	}
	void upEvent( int key ){
		down_state[key]=false;
	}

	virtual void update()=0;
};

class dxKeyboard : public dxDevice{
public:
	dxKeyboard( dxInput *i,IDirectInputDevice7 *d ):dxDevice(i,d){
	}
	void update(){
		if ( !device ) {
			return;
		}
		if( !acquired ){
			input->runtime->idle();
			return;
		}
		int k,cnt=32;
		DIDEVICEOBJECTDATA data[32],*curr;
		if( device->GetDeviceData( sizeof(DIDEVICEOBJECTDATA),data,(DWORD*)&cnt,0 )<0 ) return;
		curr=data;
		for( k=0;k<cnt;++curr,++k ){
			int n=curr->dwOfs;if( !n || n>255 ) continue;
			if( curr->dwData&0x80 ) downEvent( n );
			else upEvent( n );
		}
	}
};

class dxMouse : public dxDevice{
public:
	dxMouse( dxInput *i,IDirectInputDevice7 *d ):dxDevice(i,d){
	}
	void update(){
		if( !acquired ){
			input->runtime->idle();
			return;
		}
		DIMOUSESTATE state;
		if( device->GetDeviceState(sizeof(state),&state)<0 ) return;
		if( dxGraphics *g=input->runtime->graphics ){
			int mx=axis_states[0]+state.lX;
			int my=axis_states[1]+state.lY;
			if( mx<0 ) mx=0;
			else if( mx>=g->getWidth() ) mx=g->getWidth()-1;
			if( my<0 ) my=0;
			else if( my>=g->getHeight() ) my=g->getHeight()-1;
			axis_states[0]=mx;
			axis_states[1]=my;
			axis_states[2]+=state.lZ;
		}
		for( int k=0;k<3;++k ){
			setDownState( k+1,state.rgbButtons[k]&0x80 ? true : false );
		}
	}
};

class dxJoystick : public dxDevice{
public:
	int type,poll_time;
	int mins[12],maxs[12];

	dxJoystick( dxInput *i,IDirectInputDevice7 *d,int t ):dxDevice(i,d),type(t),poll_time(0){
		for( int k=0;k<12;++k ){
			//initialize joystick axis ranges (d'oh!)
			DIPROPRANGE range;
			range.diph.dwSize=sizeof(DIPROPRANGE);
			range.diph.dwHeaderSize=sizeof(DIPROPHEADER);
			range.diph.dwObj=k*4+12;
			range.diph.dwHow=DIPH_BYOFFSET;
			if( d->GetProperty( DIPROP_RANGE,&range.diph )<0 ){
				mins[k]=0;
				maxs[k]=65535;
				continue;
			}
			mins[k]=range.lMin;
			maxs[k]=range.lMax-range.lMin;
		}
	}
	void update(){
		unsigned tm=timeGetTime();
		if( tm-poll_time<3 ) return;
		if( device->Poll()<0 ){
			acquired=false;
			input->runtime->idle();
			acquire();if( device->Poll()<0 ) return;
		}
		poll_time=tm;
		DIJOYSTATE state;
		if( device->GetDeviceState( sizeof( state ),&state )<0 ) return;
		axis_states[0]=(state.lX-mins[0])/(float)maxs[0]*2-1;
		axis_states[1]=(state.lY-mins[1])/(float)maxs[1]*2-1;
		axis_states[2]=(state.lZ-mins[2])/(float)maxs[2]*2-1;
		axis_states[3]=(state.rglSlider[0]-mins[6])/(float)maxs[6]*2-1;
		axis_states[4]=(state.rglSlider[1]-mins[7])/(float)maxs[7]*2-1;
		axis_states[5]=(state.lRx-mins[3])/(float)maxs[3]*2-1;
		axis_states[6]=(state.lRy-mins[4])/(float)maxs[4]*2-1;
		axis_states[7]=(state.lRz-mins[5])/(float)maxs[5]*2-1;
		if( (state.rgdwPOV[0]&0xffff)==0xffff ) axis_states[8]=-1;
		else axis_states[8]=floor(state.rgdwPOV[0]/100.0f+.5f);

		for( int k=0;k<31;++k ){
			setDownState( k+1,state.rgbButtons[k]&0x80 ? true : false );
		}
	}
};

static dxKeyboard *keyboard;
static dxMouse *mouse;
static vector<dxJoystick*> joysticks;
					  
static dxKeyboard *createKeyboard( dxInput *input ){

  return d_new dxKeyboard(input,0);
/*
	IDirectInputDevice7 *dev;
	if( input->dirInput->CreateDeviceEx( GUID_SysKeyboard,IID_IDirectInputDevice7,(void**)&dev,0 )>=0 ){
		if( dev->SetCooperativeLevel( input->runtime->hwnd,DISCL_FOREGROUND|DISCL_EXCLUSIVE )>=0 ){

			if( dev->SetDataFormat( &c_dfDIKeyboard )>=0 ){
				DIPROPDWORD dword;
	 			memset( &dword,0,sizeof(dword) );
				dword.diph.dwSize=sizeof(DIPROPDWORD);
				dword.diph.dwHeaderSize=sizeof(DIPROPHEADER);
				dword.diph.dwObj=0;
				dword.diph.dwHow=DIPH_DEVICE;
				dword.dwData=32;
				if( dev->SetProperty( DIPROP_BUFFERSIZE,&dword.diph )>=0 ){
					return d_new dxKeyboard( input,dev );
				}else{
//					input->runtime->debugInfo( "keyboard: SetProperty failed" );
				}
			}else{
//				input->runtime->debugInfo( "keyboard: SetDataFormat failed" );
			}
		}else{
//			input->runtime->debugInfo( "keyboard: SetCooperativeLevel failed" );
		}
		dev->Release();
	}else{
//		input->runtime->debugInfo( "keyboard: CreateDeviceEx failed" );
	}
	return d_new dxKeyboard( input,0 );
*/
	return 0;
}

static dxMouse *createMouse( dxInput *input ){
	IDirectInputDevice7 *dev;
	if( input->dirInput->CreateDeviceEx( GUID_SysMouse,IID_IDirectInputDevice7,(void**)&dev,0 )>=0 ){
		if( dev->SetCooperativeLevel( input->runtime->hwnd,DISCL_FOREGROUND|DISCL_EXCLUSIVE )>=0 ){
			if( dev->SetDataFormat( &c_dfDIMouse )>=0 ){
				return d_new dxMouse( input,dev );
			}else{
//				input->runtime->debugInfo( "mouse: SetDataFormat failed" );
			}
		}else{
//			input->runtime->debugInfo( "mouse: SetCooperativeLevel failed" );
		}
		dev->Release();
	}else{
//		input->runtime->debugInfo( "mouse: CreateDeviceEx failed" );
	}
	return 0;
}

static dxJoystick *createJoystick( dxInput *input,LPCDIDEVICEINSTANCE devinst ){
	IDirectInputDevice7 *dev;
	if( input->dirInput->CreateDeviceEx( devinst->guidInstance,IID_IDirectInputDevice7,(void**)&dev,0 )>=0 ){
		if( dev->SetCooperativeLevel( input->runtime->hwnd,DISCL_FOREGROUND|DISCL_EXCLUSIVE )>=0 ){
			if( dev->SetDataFormat( &c_dfDIJoystick )>=0 ){
				int t=((devinst->dwDevType>>8)&0xff)==DIDEVTYPEJOYSTICK_GAMEPAD ? 1 : 2;
				return d_new dxJoystick( input,dev,t );
			}
		}
		dev->Release();
	}
	return 0;
}

static BOOL CALLBACK enumJoystick( LPCDIDEVICEINSTANCE devinst,LPVOID pvRef ){

	if( (devinst->dwDevType&0xff)!=DIDEVTYPE_JOYSTICK ) return DIENUM_CONTINUE;

	if( dxJoystick *joy=createJoystick( (dxInput*)pvRef,devinst ) ){
		joysticks.push_back( joy );
	}
	return DIENUM_CONTINUE;
}

dxInput::dxInput( dxRuntime *rt,IDirectInput7 *di ):
runtime(rt),dirInput(di){
	keyboard=createKeyboard( this );
	mouse=createMouse( this );
	joysticks.clear();
	dirInput->EnumDevices( DIDEVTYPE_JOYSTICK,enumJoystick,this,DIEDFL_ATTACHEDONLY );
}

dxInput::~dxInput(){
	for( int k=0;k<joysticks.size();++k ) delete joysticks[k];
	joysticks.clear();
	delete mouse;
	delete keyboard;

	dirInput->Release();
}

void dxInput::wm_keydown( int key ){
	if( keyboard ) keyboard->downEvent( key );
}

void dxInput::wm_keyup( int key ){
	if( keyboard ) keyboard->upEvent( key );
}

void dxInput::wm_mousedown( int key ){
	if( mouse ) mouse->downEvent( key );
}

void dxInput::wm_mouseup( int key ){
	if( mouse ) mouse->upEvent( key );
}

void dxInput::wm_mousemove( int x,int y ){
	if( mouse ){
		mouse->axis_states[0]=x;
		mouse->axis_states[1]=y;
	}
}

void dxInput::wm_mousewheel( int dz ){
	if( mouse ) mouse->axis_states[2]+=dz;
}

void dxInput::reset(){
	if( mouse ) mouse->reset();
	if( keyboard ) keyboard->reset();
	for( int k=0;k<joysticks.size();++k ) joysticks[k]->reset();
}

bool dxInput::acquire(){
	bool m_ok=true,k_ok=true;
	if( mouse ) m_ok=mouse->acquire();
	if( keyboard ) k_ok=keyboard->acquire();
	if( m_ok && k_ok ) return true;
	if( k_ok ) keyboard->unacquire();
	if( m_ok ) mouse->unacquire();
	return false;
}

void dxInput::unacquire(){
	if( keyboard ) keyboard->unacquire();
	if( mouse ) mouse->unacquire();
}

void dxInput::moveMouse( int x,int y ){
	if( !mouse ) return;
	mouse->axis_states[0]=x;
	mouse->axis_states[1]=y;
	runtime->moveMouse( x,y );
}

gxDevice *dxInput::getMouse()const{
	return mouse;
}

gxDevice *dxInput::getKeyboard()const{
	return keyboard;
}

gxDevice *dxInput::getJoystick( int n )const{
	return n>=0 && n<joysticks.size() ? joysticks[n] : 0;
}

int dxInput::getJoystickType( int n )const{
	return n>=0 && n<joysticks.size() ? joysticks[n]->type : 0;
}

int dxInput::numJoysticks()const{
	return joysticks.size();
}

int dxInput::toAscii( int scan )const{
	switch( scan ){
	case DIK_INSERT:return ASC_INSERT;
	case DIK_DELETE:return ASC_DELETE;
	case DIK_HOME:return ASC_HOME;
	case DIK_END:return ASC_END;
	case DIK_PGUP:return ASC_PAGEUP;
	case DIK_PGDN:return ASC_PAGEDOWN;
	case DIK_UP:return ASC_UP;
	case DIK_DOWN:return ASC_DOWN;
	case DIK_LEFT:return ASC_LEFT;
	case DIK_RIGHT:return ASC_RIGHT;
	}
	scan&=0x7f;
 	int virt=MapVirtualKey( scan,1 );
	if( !virt ) return 0;

	static unsigned char mat[256];
	mat[VK_LSHIFT]=keyboard->keyDown( DIK_LSHIFT ) ? 0x80 : 0;
	mat[VK_RSHIFT]=keyboard->keyDown( DIK_RSHIFT ) ? 0x80 : 0;
	mat[VK_SHIFT]=mat[VK_LSHIFT]|mat[VK_RSHIFT];
	mat[VK_LCONTROL]=keyboard->keyDown( DIK_LCONTROL ) ? 0x80 : 0;
	mat[VK_RCONTROL]=keyboard->keyDown( DIK_RCONTROL ) ? 0x80 : 0;
	mat[VK_CONTROL]=mat[VK_LCONTROL]|mat[VK_RCONTROL];
	mat[VK_LMENU]=keyboard->keyDown( DIK_LMENU ) ? 0x80 : 0;
	mat[VK_RMENU]=keyboard->keyDown( DIK_RMENU ) ? 0x80 : 0;
	mat[VK_MENU]=mat[VK_LMENU]|mat[VK_RMENU];

	WORD ch;
	if( ToAscii( virt,scan,mat,&ch,0 )!=1 ) return 0;
	return ch & 255;
}
