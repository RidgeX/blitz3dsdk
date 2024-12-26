
#ifndef PIVOT_H
#define PIVOT_H

#include "object.h"

/// Pivot's rock
class Pivot : public Object{
public:
	Pivot();
	Pivot( const Object &t );

	//Entity interface
	Entity *clone(){ return d_new Pivot( *this ); }
};

#endif
