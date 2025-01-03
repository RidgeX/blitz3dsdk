
#ifndef GXFILESYSTEM_H
#define GXFILESYSTEM_H

#include <string>

#include "gxdir.h"

class gxFileSystem{
	/***** GX INTERFACE *****/
public:
	enum{
		FILE_TYPE_NONE=0,FILE_TYPE_FILE=1,FILE_TYPE_DIR=2
	};

	virtual bool createDir( const std::string &dir )=0;
	virtual bool deleteDir( const std::string &dir )=0;
	virtual bool createFile( const std::string &file )=0;
	virtual bool deleteFile( const std::string &file )=0;
	virtual bool copyFile( const std::string &src,const std::string &dest )=0;
	virtual bool renameFile( const std::string &src,const std::string &dest )=0;
	virtual bool setCurrentDir( const std::string &dir )=0;

	virtual std::string getCurrentDir()const=0;
	virtual int getFileSize( const std::string &name )const=0;
	virtual int getFileType( const std::string &name )const=0;

	virtual gxDir *openDir( const std::string &name,int flags )=0;
	virtual gxDir *verifyDir( gxDir *d )=0;
	virtual void closeDir( gxDir *dir )=0;
};

#endif
