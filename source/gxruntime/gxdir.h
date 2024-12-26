
#ifndef GXDIR_H
#define GXDIR_H

#include <string>

class gxDir{
public:
	virtual std::string getNextFile()=0;
};

#endif