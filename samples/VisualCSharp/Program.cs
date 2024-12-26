using System;

using bb = Blitz3DSDK;

static class RotateCube
{
	[STAThread]
	static void Main()
	{
		bb.BeginBlitz3D();
		bb.Graphics3D(960, 540, 0, 2);

		int cube = bb.CreateCube(0);
		int light = bb.CreateLight(1, 0);
		int camera = bb.CreateCamera(0);

		bb.PositionEntity(camera, 0, 0, -4, 1);

		while (bb.KeyHit(bb.KEY_ESCAPE) == 0)
		{
			bb.UpdateWorld(1);
			bb.RenderWorld(0);
			bb.TurnEntity(cube, .1f, .2f, .3f, 1);
			bb.Text(20, bb.GraphicsHeight() - 20, "Blitz3DSDK C# Example (C)2007 Blitz Research 2007", 0, 0);
			bb.Flip(1);
		}
		bb.EndBlitz3D();
	}
}
