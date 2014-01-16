part of GB_WEBGL;

class SpriteSheet {
	Material sheet;
	double tileSize;
	int tileCount;
	
	SpriteSheet(String path, int this.tileCount) {
		sheet = new Material.load(path);
		tileSize = 1 / (sheet.image.width / tileCount);
	}
	
	List<Vector2> getPoints(int tx, int ty) {
		ty = tileCount - ty - 1;
	
		Vector2 p1 = new Vector2(tx * tileSize, ty * tileSize);
		Vector2 p2 = new Vector2(tx * tileSize + tileSize, ty * tileSize);
		Vector2 p3 = new Vector2(tx * tileSize + tileSize, ty * tileSize - tileSize);
		Vector2 p4 = new Vector2(tx * tileSize, ty * tileSize - tileSize);
		return [p1, p2, p3, p4];
	}
}