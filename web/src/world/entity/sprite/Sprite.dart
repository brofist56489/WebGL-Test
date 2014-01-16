part of GB_WEBGL;

class Sprite extends Entity {
	Sprite(Vector3 position, String path, double size) : super(position, new Material.load(path), null) {
		mesh = new Mesh();
		double halfSize = size / 2;
		mesh.setVerticies(
		[
			-halfSize, -halfSize, 0.0, 0.0, 1.0,
			-halfSize, halfSize, 0.0, 0.0, 0.0,
			halfSize, halfSize, 0.0, 1.0, 0.0,
			halfSize, -halfSize, 0.0, 1.0, 1.0,
		],
		[
			0, 1, 2, 0, 2, 3
		]);
	}
	
	void update() {
		rotation = new Vector3(0.0, -Game.getDisplay().camera.roty, 0.0);	
	}
}