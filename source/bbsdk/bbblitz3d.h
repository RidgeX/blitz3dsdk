
#ifndef BBBLITZ3D_H
#define BBBLITZ3D_H

#include "stdutil.h"
#include "../gxruntime/gxscene.h"

extern gxScene *gx_scene;

extern int update_ms;

#include "../blitz3d/std.h"
#include "../blitz3d/world.h"
#include "../blitz3d/texture.h"
#include "../blitz3d/brush.h"
#include "../blitz3d/camera.h"
#include "../blitz3d/sprite.h"
#include "../blitz3d/meshmodel.h"
#include "../blitz3d/loader_x.h"
#include "../blitz3d/loader_3ds.h"
#include "../blitz3d/loader_b3d.h"
#include "../blitz3d/md2model.h"
#include "../blitz3d/q3bspmodel.h"
#include "../blitz3d/meshutil.h"
#include "../blitz3d/pivot.h"
#include "../blitz3d/planemodel.h"
#include "../blitz3d/terrain.h"
#include "../blitz3d/listener.h"
#include "../blitz3d/cachedtexture.h"

///////////////////////////
// GLOBAL WORLD COMMANDS //
///////////////////////////

extern "C"{

BBSDK_API void bbLoaderMatrix( const char *ext,float xx,float xy,float xz,float yx,float yy,float yz,float zx,float zy,float zz );

// live states

BBSDK_API int bbHWTexUnits();
BBSDK_API int bbGfxDriverCaps3D();

BBSDK_API void bbHWMultiTex( int enable );
BBSDK_API void bbWBuffer( int enable );
BBSDK_API void bbDither( int enable );
BBSDK_API void bbAntiAlias( int enable );
BBSDK_API void bbWireFrame( int enable );
BBSDK_API void bbAmbientLight( float r,float g,float b );
BBSDK_API void bbClearCollisions();

BBSDK_API void bbCollisions( int src_type,int dest_type,int method,int response );

BBSDK_API void bbUpdateWorld( float elapsed=1.0 );
BBSDK_API void bbCaptureWorld();
BBSDK_API void bbRenderWorld( float tween=1.0 );
BBSDK_API int bbTrisRendered();
BBSDK_API float bbStats3D( int n );

//////////////////////
// TEXTURE COMMANDS //
//////////////////////

BBSDK_API Texture *bbLoadTexture( const char *file,int flags=1 );
BBSDK_API Texture *bbLoadAnimTexture( const char *file,int flags,int w,int h,int first,int cnt );
BBSDK_API Texture *bbCreateTexture( int w,int h,int flags=3,int frames=1 );
BBSDK_API void bbFreeTexture( Texture *t );
BBSDK_API void bbTextureBlend( Texture *t,int blend );
BBSDK_API void bbTextureCoords( Texture *t,int flags );
BBSDK_API void bbScaleTexture( Texture *t,float u_scale,float v_scale );
BBSDK_API void bbRotateTexture( Texture *t,float angle );
BBSDK_API void bbPositionTexture( Texture *t,float u_pos,float v_pos );
BBSDK_API int bbTextureWidth( Texture *t );
BBSDK_API int bbTextureHeight( Texture *t );


BBSDK_API const char *bbTextureName( Texture *t );
BBSDK_API void bbSetCubeFace( Texture *t,int face );
BBSDK_API void bbSetCubeMode( Texture *t,int mode );
BBSDK_API gxCanvas *bbTextureBuffer( Texture *t,int frame=0 );
BBSDK_API void bbClearTextureFilters();
BBSDK_API void bbTextureFilter( const char *t,int flags );

////////////////////
// BRUSH COMMANDS //
////////////////////
BBSDK_API Brush *bbCreateBrush( float r=255.0f,float g=255.0f,float b=255.0f );
BBSDK_API Brush *bbLoadBrush( const char *file,int flags=1,float u_scale=1.0,float v_scale=1.0 );

BBSDK_API void bbFreeBrush( Brush *b );
BBSDK_API void bbBrushColor( Brush *br,float r,float g,float b );
BBSDK_API void bbBrushAlpha( Brush *b,float alpha );
BBSDK_API void bbBrushShininess( Brush *b,float n );
BBSDK_API void bbBrushTexture( Brush *b,Texture *t,int frame,int index );
BBSDK_API Texture *bbGetBrushTexture( Brush *b,int index );
BBSDK_API void bbBrushBlend( Brush *b,int blend );
BBSDK_API void bbBrushFX( Brush *b,int fx );

///////////////////
// MESH COMMANDS //
///////////////////
BBSDK_API MeshModel *bbCreateMesh( Entity *p=0 );
BBSDK_API MeshModel *bbLoadMesh( const char *f,Entity *p=0 );
BBSDK_API MeshModel *bbLoadAnimMesh( const char *f,Entity *p=0 );
BBSDK_API MeshModel *bbCreateCube( Entity *p=0 );
BBSDK_API MeshModel *bbCreateSphere( int segs=8,Entity *p=0 );
BBSDK_API MeshModel *bbCreateCylinder( int segs=8,int solid=1,Entity *p=0 );
BBSDK_API MeshModel *bbCreateCone( int segs=8,int solid=1,Entity *p=0 );
BBSDK_API MeshModel *bbCopyMesh( MeshModel *m,Entity *p=0 );
BBSDK_API void bbScaleMesh( MeshModel *m,float x,float y,float z );
BBSDK_API void bbRotateMesh( MeshModel *m,float x,float y,float z );
BBSDK_API void bbPositionMesh( MeshModel *m,float x,float y,float z );
BBSDK_API void bbFitMesh( MeshModel *m,float x,float y,float z,float w,float h,float d,int uniform=0 );
BBSDK_API void bbFlipMesh( MeshModel *m );
BBSDK_API void bbPaintMesh( MeshModel *m,Brush *b );
BBSDK_API void bbAddMesh( MeshModel *src,MeshModel *dest );
BBSDK_API void bbUpdateNormals( MeshModel *m );
BBSDK_API void bbLightMesh( MeshModel *m,float r,float g,float b,float range,float x,float y,float z );
BBSDK_API float bbMeshWidth( MeshModel *m );
BBSDK_API float bbMeshHeight( MeshModel *m );
BBSDK_API float bbMeshDepth( MeshModel *m );
BBSDK_API int bbMeshesIntersect( MeshModel *a,MeshModel *b );
BBSDK_API int bbCountSurfaces( MeshModel *m );
BBSDK_API Surface *bbGetSurface( MeshModel *m,int index );
BBSDK_API void bbMeshCullBox( MeshModel *m,float x,float y,float z,float w,float h,float d );

//////////////////////
// SURFACE COMMANDS //
//////////////////////

BBSDK_API Surface *bbFindSurface( MeshModel *m,Brush *b );
BBSDK_API Surface *bbCreateSurface( MeshModel *m,Brush *b=0 );
BBSDK_API Brush *bbGetSurfaceBrush( Surface *s );
BBSDK_API Brush *bbGetEntityBrush( Model *m );
BBSDK_API void bbCreateBones( );

BBSDK_API void bbClearSurface( Surface *s,int verts,int tris );
BBSDK_API void bbPaintSurface( Surface *s,Brush *b );
BBSDK_API int bbAddVertex( Surface *s,float x,float y,float z,float tu=0.0f,float tv=0.0f,float tw=0.0f );
BBSDK_API int bbAddTriangle( Surface *s,int v0,int v1,int v2 );
BBSDK_API void bbVertexCoords( Surface *s,int n,float x,float y,float z );
BBSDK_API void bbVertexNormal( Surface *s,int n,float x,float y,float z );

BBSDK_API void bbVertexColor( Surface *s,int n,float r,float g,float b,float a );
BBSDK_API void bbVertexTexCoords( Surface *s,int n,float u,float v,float w,int set );
BBSDK_API int bbCountVertices( Surface *s );
BBSDK_API int bbCountTriangles( Surface *s );
BBSDK_API float bbVertexX( Surface *s,int n );
BBSDK_API float bbVertexY( Surface *s,int n );
BBSDK_API float bbVertexZ( Surface *s,int n );
BBSDK_API float bbVertexNX( Surface *s,int n );
BBSDK_API float bbVertexNY( Surface *s,int n );
BBSDK_API float bbVertexNZ( Surface *s,int n );
BBSDK_API float bbVertexRed( Surface *s,int n );
BBSDK_API float bbVertexGreen( Surface *s,int n );
BBSDK_API float bbVertexBlue( Surface *s,int n );
BBSDK_API float bbVertexAlpha( Surface *s,int n );
BBSDK_API float bbVertexU( Surface *s,int n,int t );
BBSDK_API float bbVertexV( Surface *s,int n,int t );
BBSDK_API float bbVertexW( Surface *s,int n,int t );
BBSDK_API int bbTriangleVertex( Surface *s,int n,int v );

/////////////////////
// CAMERA COMMANDS //
/////////////////////

BBSDK_API Camera *bbCreateCamera( Entity *p=0 );
BBSDK_API void bbCameraZoom( Camera *c,float zoom );
BBSDK_API void bbCameraRange( Camera *c,float nr,float fr );
BBSDK_API void bbCameraClsColor( Camera *c,float r,float g,float b );
BBSDK_API void bbCameraClsMode( Camera *c,int cls_color,int cls_zbuffer );
BBSDK_API void bbCameraProjMode( Camera *c,int mode );
BBSDK_API void bbCameraViewport( Camera *c,int x,int y,int w,int h );
BBSDK_API void bbCameraFogRange( Camera *c,float nr,float fr );
BBSDK_API void bbCameraFogColor( Camera *c,float r,float g,float b );
BBSDK_API void bbCameraFogMode( Camera *c,int mode );
BBSDK_API int bbCameraProject( Camera *c,float x,float y,float z );
BBSDK_API float bbProjectedX();
BBSDK_API float bbProjectedY();
BBSDK_API float bbProjectedZ();
BBSDK_API Object *doPick( const Line &l,float radius );	// static
BBSDK_API Entity *bbCameraPick( Camera *c,float x,float y );
BBSDK_API Entity *bbLinePick( float x,float y,float z,float dx,float dy,float dz,float radius );
BBSDK_API Entity *bbEntityPick( Object *src,float range );
BBSDK_API int bbEntityVisible( Object *src,Object *dest );
BBSDK_API int bbEntityInView( Entity *e,Camera *c );
BBSDK_API float bbPickedX();
BBSDK_API float bbPickedY();
BBSDK_API float bbPickedZ();
BBSDK_API float bbPickedNX();
BBSDK_API float bbPickedNY();
BBSDK_API float bbPickedNZ();
BBSDK_API float bbPickedTime();
BBSDK_API Object *bbPickedEntity();
BBSDK_API void *bbPickedSurface();
BBSDK_API int bbPickedTriangle();

////////////////////
// LIGHT COMMANDS //
////////////////////

BBSDK_API Light *bbCreateLight( int type=0,Entity *p=0 );
BBSDK_API void bbLightColor( Light *light,float r,float g,float b );
BBSDK_API void bbLightRange( Light *light,float range );
BBSDK_API void bbLightConeAngles( Light *light,float inner,float outer );

////////////////////
// PIVOT COMMANDS //
////////////////////

BBSDK_API Pivot *bbCreatePivot( Entity *p=0 );

/////////////////////
// SPRITE COMMANDS //
/////////////////////

BBSDK_API Sprite *bbCreateSprite( Entity *p=0 );
BBSDK_API Sprite *bbLoadSprite( const char *file,int flags=1,Entity *p=0 );
BBSDK_API void bbRotateSprite( Sprite *s,float angle );
BBSDK_API void bbScaleSprite( Sprite *s,float x,float y );
BBSDK_API void bbHandleSprite( Sprite *s,float x,float y );
BBSDK_API void bbSpriteViewMode( Sprite *s,int mode );

/////////////////////
// MIRROR COMMANDS //
/////////////////////

BBSDK_API Mirror *bbCreateMirror( Entity *p=0 );

////////////////////
// PLANE COMMANDS //
////////////////////

BBSDK_API PlaneModel *bbCreatePlane( int segs=1,Entity *p=0 );

//////////////////
// MD2 COMMANDS //
//////////////////

BBSDK_API MD2Model *bbLoadMD2( const char *file,Entity *p=0 );
BBSDK_API void bbAnimateMD2( MD2Model *m,int mode=1,float speed=1.0,int first=0,int last=9999,float trans=0.0 );
BBSDK_API float bbMD2AnimTime( MD2Model *m );
BBSDK_API int bbMD2AnimLength( MD2Model *m );
BBSDK_API int bbMD2Animating( MD2Model *m );

//////////////////
// BSP Commands //
//////////////////

BBSDK_API Q3BSPModel *bbLoadBSP( const char *file,float gam,Entity *p=0 );
BBSDK_API void bbBSPAmbientLight( Q3BSPModel *t,float r,float g,float b );
BBSDK_API void bbBSPLighting( Q3BSPModel *t,int lmap );

//////////////////////
// TERRAIN COMMANDS //
//////////////////////

BBSDK_API Terrain *bbCreateTerrain( int n,Entity *p=0 );
BBSDK_API Terrain *bbLoadTerrain( const char *file,Entity *p=0 );
BBSDK_API void bbTerrainDetail( Terrain *t,int n,int m );
BBSDK_API void bbTerrainShading( Terrain *t,int enable );
BBSDK_API float bbTerrainX( Terrain *t,float x,float y,float z );
BBSDK_API float bbTerrainY( Terrain *t,float x,float y,float z );
BBSDK_API float bbTerrainZ( Terrain *t,float x,float y,float z );
BBSDK_API int bbTerrainSize( Terrain *t );
BBSDK_API float bbTerrainHeight( Terrain *t,int x,int z );
BBSDK_API void bbModifyTerrain( Terrain *t,int x,int z,float h,int realtime );

////////////////////
// AUDIO COMMANDS //
////////////////////

BBSDK_API Entity *bbCreateListener( Entity *p=0,float roll=1.0,float dopp=1.0,float dist=1.0 );
BBSDK_API gxChannel *bbEmitSound( gxSound *sound,Object *o );

/////////////////////
// ENTITY COMMANDS //
/////////////////////

BBSDK_API Entity *bbCopyEntity( Entity *e,Entity *p=0 );
BBSDK_API void bbFreeEntity( Entity *e );
BBSDK_API void bbHideEntity( Entity *e );
BBSDK_API void bbShowEntity( Entity *e );
BBSDK_API void bbEntityParent( Entity *e,Entity *p=0,int global=1 );
BBSDK_API int bbCountChildren( Entity *e );
BBSDK_API Entity *bbGetChild( Entity *e,int index );
BBSDK_API Entity *bbFindChild( Entity *e,const char *t );

////////////////////////
// ANIMATION COMMANDS //
////////////////////////

BBSDK_API int bbLoadAnimSeq( Object *o,const char *f );
BBSDK_API void bbSetAnimTime( Object *o,float time,int seq );
BBSDK_API void bbAnimate( Object *o,int mode=1,float speed=1.0f,int seq=0,float trans=0.0f );

BBSDK_API void bbSetAnimKey( Object *o,int frame,int pos_key=1,int rot_key=1,int scl_key=1 );
BBSDK_API int bbExtractAnimSeq( Object *o,int first,int last,int seq );
BBSDK_API int bbAddAnimSeq( Object *o,int length );
BBSDK_API int bbAnimSeq( Object *o );
BBSDK_API float bbAnimTime( Object *o );
BBSDK_API int bbAnimLength( Object *o );
BBSDK_API int bbAnimating( Object *o );

////////////////////////////////
// ENTITY SPECIAL FX COMMANDS //
////////////////////////////////

BBSDK_API void bbPaintEntity( Entity *e,Brush *b );
//void bbPaintEntity( Model *m,Brush *b );
BBSDK_API void bbEntityColor( Model *m,float r,float g,float b );
BBSDK_API void bbEntityAlpha( Model *m,float alpha );
BBSDK_API void bbEntityShininess( Model *m,float shininess );
BBSDK_API void bbEntityTexture( Model *m,Texture *t,int frame=0,int index=0 );
BBSDK_API void bbEntityBlend( Model *m,int blend );
BBSDK_API void bbEntityFX( Model *m,int fx );
BBSDK_API void bbEntityAutoFade( Model *m,float nr,float fr );
BBSDK_API void bbEntityOrder( Object *o,int n );

//////////////////////////////
// ENTITY PROPERTY COMMANDS //
//////////////////////////////

BBSDK_API float bbEntityX( Entity *e,int global=0 );
BBSDK_API float bbEntityY( Entity *e,int global=0 );
BBSDK_API float bbEntityZ( Entity *e,int global=0 );
BBSDK_API float bbEntityPitch( Entity *e,int global=0 );
BBSDK_API float bbEntityYaw( Entity *e,int global=0 );
BBSDK_API float bbEntityRoll( Entity *e,int global=0 );
BBSDK_API float bbGetMatElement( Entity *e,int row,int col );
BBSDK_API void bbTFormPoint( float x,float y,float z,Entity *src,Entity *dest );
BBSDK_API void bbTFormVector( float x,float y,float z,Entity *src,Entity *dest );
BBSDK_API void bbTFormNormal( float x,float y,float z,Entity *src,Entity *dest );
BBSDK_API float bbTFormedX();
BBSDK_API float bbTFormedY();
BBSDK_API float bbTFormedZ();
BBSDK_API float bbVectorYaw( float x,float y,float z );
BBSDK_API float bbVectorPitch( float x,float y,float z );
BBSDK_API float bbDeltaYaw( Entity *src,Entity *dest );
BBSDK_API float bbDeltaPitch( Entity *src,Entity *dest );

///////////////////////////////
// ENTITY COLLISION COMMANDS //
///////////////////////////////

BBSDK_API void bbResetEntity( Object *o );
//BBSDK_API void entityType( Entity *e,int type );	//static
BBSDK_API void bbEntityType( Object *o,int type,int recurs=0 );
BBSDK_API void bbEntityPickMode( Object *o,int mode,int obs );
BBSDK_API Entity *bbGetParent( Entity *e );
BBSDK_API int bbGetEntityType( Object *o );
BBSDK_API void bbEntityRadius( Object *o,float x_radius,float y_radius=0.0 );
BBSDK_API void bbEntityBox( Object *o,float x,float y,float z,float w,float h,float d );
BBSDK_API Object *bbEntityCollided( Object *o,int type );
BBSDK_API int bbCountCollisions( Object *o );
BBSDK_API float bbCollisionX( Object *o,int index );
BBSDK_API float bbCollisionY( Object *o,int index );
BBSDK_API float bbCollisionZ( Object *o,int index );
BBSDK_API float bbCollisionNX( Object *o,int index );
BBSDK_API float bbCollisionNY( Object *o,int index );
BBSDK_API float bbCollisionNZ( Object *o,int index );
BBSDK_API float bbCollisionTime( Object *o,int index );
BBSDK_API Object *bbCollisionEntity( Object *o,int index );
BBSDK_API void *bbCollisionSurface( Object *o,int index );
BBSDK_API int bbCollisionTriangle( Object *o,int index );
BBSDK_API float bbEntityDistance( Entity *src,Entity *dest );

////////////////////////////////////
// ENTITY TRANSFORMATION COMMANDS //
////////////////////////////////////

BBSDK_API void bbMoveEntity( Entity *e,float x,float y,float z );
BBSDK_API void bbTurnEntity( Entity *e,float p,float y,float r,int global=0 );
BBSDK_API void bbTranslateEntity( Entity *e,float x,float y,float z,int global=0 );
BBSDK_API void bbPositionEntity( Entity *e,float x,float y,float z,int global=0 );
BBSDK_API void bbScaleEntity( Entity *e,float x,float y,float z,int global=0 );
BBSDK_API void bbRotateEntity( Entity *e,float p,float y,float r,int global=0 );
BBSDK_API void bbPointEntity( Entity *e,Entity *t,float roll=0 );
BBSDK_API void bbAlignToVector( Entity *e,float nx,float ny,float nz,int axis,float rate );

//////////////////////////
// ENTITY MISC COMMANDS //
//////////////////////////

BBSDK_API void bbNameEntity( Entity *e,const char *t );
BBSDK_API const char *bbEntityName( Entity *e );
BBSDK_API const char *bbEntityClass( Entity *e );
BBSDK_API void bbClearWorld( int e,int b,int t );
BBSDK_API void bbSetEntityID( Entity *e,int id );
BBSDK_API int bbEntityID( Entity *e );
BBSDK_API void bbCaptureEntity( Object *o );

//extern int active_texs;
BBSDK_API int bbActiveTextures();
};

#endif





// simon was here
//extern gxFileSystem *gx_filesys;
/*
class Texture;
class Brush;
class Model;
class MeshModel:Model;
class Object;
class Entity;
class Surface;
class Camera;
class Light;
class Sprite;
class Line;
class MD2Model;
class Q3BSPModel;
class Terrain;
class Vector;
class Pivot;
class Mirror;
class PlaneModel;
*/


/*

BBSDK_API void blitz3d_open();
BBSDK_API void blitz3d_close();
BBSDK_API bool blitz3d_create();
BBSDK_API bool blitz3d_destroy();

static declarations from bbblitz3d.cpp

static int tri_count;
static World *world;
static set<Brush*> brush_set;
static set<Texture*> texture_set;
static set<Entity*> entity_set;
static Listener *listener;
static bool stats_mode;
//converts 0...255 color to 0...1
static const float ctof=1.0f/255.0f;
//degrees to radians and back
static const float dtor=0.0174532925199432957692369076848861f;
static const float rtod=1/dtor;
static Vector projected,tformed;
static ObjCollision picked;
extern float stats3d[10];
static Loader_X loader_x;
static Loader_3DS loader_3ds;
static Loader_B3D loader_b3d;
static map<string,Transform> loader_mat_map;

static void erase( Entity *e );
static Entity *findChild( Entity *e,const string &t );

static inline void debug3d(){
static inline void debugTexture( Texture *t ){
static inline void debugBrush( Brush *b ){
static inline void debugEntity( Entity *e ){
static inline void debugParent( Entity *e ){
static inline void debugMesh( MeshModel *m ){
static inline void debugObject( Object *o ){
static inline void debugColl( Object *o,int index ){
static inline void debugCamera( Camera *c ){
static inline void debugLight( Light *l ){
static inline void debugModel( Model *m ){
static inline void debugSprite( Sprite *s ){
static inline void debugMD2( MD2Model *m ){
static inline void debugBSP( Q3BSPModel *m ){
static inline void debugTerrain( Terrain *t ){
static inline void debugSegs( int n ){
static inline void debugVertex( Surface *s,int n ){
static inline void debugVertex( Surface *s,int n,int t ){
static Entity *loadEntity( BBStr *f,int hint ){
static void collapseMesh( MeshModel *mesh,Entity *e ){
static void insert( Entity *e ){
static Entity *insertEntity( Entity *e,Entity *p ){
*/
