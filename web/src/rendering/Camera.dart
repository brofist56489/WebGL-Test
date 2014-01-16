part of GB_WEBGL;

class Camera {
	Vector3 position;
	double rotx = 0.0;
	double roty = 0.0;
	Matrix4 matrix;
	
	Camera() : position = new Vector3(0.0, 0.0, 0.0),
			   matrix = new Matrix4.identity();
	
	void updateUniform() {
		matrix = new Matrix4.identity();	
		matrix.rotate(new Vector3(1.0, 0.0, 0.0), rotx);
		matrix.rotate(new Vector3(0.0, 1.0, 0.0), roty);
		matrix.translate(-position.x, -position.y, -position.z);
		Shader.setCameraMatrix(matrix);
	}
	
	void moveTo(Vector3 pos) {
		position = pos;
	}
	
	void rotate(double rotx, double roty) {
		this.rotx += rotx;
		this.roty += roty;
	}
	
	void setRotation(double rotx, double roty) {
		this.rotx = rotx;
		this.roty = roty;
	}
}