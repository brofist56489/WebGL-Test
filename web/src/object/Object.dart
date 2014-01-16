part of GB_WEBGL;

class Object {
	Vector3 position;
	Vector3 rotation;
	Vector3 color;
	Vector3 scale;
	Material texture;
	Mesh mesh;
	
	Object(this.position, this.texture, this.mesh) {
		this.rotation = new Vector3(0.0, 0.0, 0.0);
		this.color = new Vector3(1.0, 1.0, 1.0);
		this.scale = new Vector3(1.0, 1.0, 1.0);
	}
	
	void update() {}
	
	void render() {
		if(texture != null)
			texture.use();
		mesh.render(position, rotation, scale, color);
	}
}