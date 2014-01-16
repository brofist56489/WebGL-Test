part of GB_WEBGL;

class Display {
	List<Object> objects = new List<Object>();
	Camera camera;
	Vector2 centerPos = new Vector2(427.0, 240.0);
	Mesh wallMesh = new Mesh();
	
	Display() {
		camera = new Camera();
		wallMesh.setVerticies(
		[
			-0.5, 0.5, 0.5, 0.0, 0.0,
			-0.5, 0.5, -0.5, 1.0, 0.0,
			0.5, 0.5, -0.5, 1.0, 1.0,
			0.5, 0.5, 0.5, 0.0, 1.0,
			-0.5, -0.5, 0.5, 0.0, 0.0,
			0.5, -0.5, 0.5, 1.0, 0.0,
			0.5, -0.5, -0.5, 1.0, 1.0,
			-0.5, -0.5, -0.5, 0.0, 1.0,
		],
		[
			0, 3, 5, 0, 5, 4,
			3, 2, 6, 3, 6, 5,
			2, 1, 7, 2, 7, 6,
			1, 0, 4, 1, 4, 7,
		]);
	}
	
	void update() {
		objects.forEach((Object obj) {
			obj.update();
		});
		
		if(Keyboard.isPressed(KeyCode.LEFT)) {
			camera.roty -= 0.05;
		} else if(Keyboard.isPressed(KeyCode.RIGHT)) {
			camera.roty += 0.05;
		}
		
		if(Keyboard.isPressed(KeyCode.W)) {
			camera.position.z -= Math.cos(camera.roty) * 0.25;
			camera.position.x += Math.sin(camera.roty) * 0.25;
		}
		if(Keyboard.isPressed(KeyCode.A)) {
			camera.position.z -= Math.cos(camera.roty - Math.PI / 2) * 0.25;
			camera.position.x += Math.sin(camera.roty - Math.PI / 2) * 0.25;
		}
		if(Keyboard.isPressed(KeyCode.D)) {
			camera.position.z -= Math.cos(camera.roty + Math.PI / 2) * 0.25;
			camera.position.x += Math.sin(camera.roty + Math.PI / 2) * 0.25;
		}
		if(Keyboard.isPressed(KeyCode.S)) {
			camera.position.z -= Math.cos(camera.roty + Math.PI) * 0.25;
			camera.position.x += Math.sin(camera.roty + Math.PI) * 0.25;
		}
	}
	
	void render() {
		camera.updateUniform();
		
		objects.forEach((Object obj) {
			obj.render();
		});
		
		wallMesh.render(new Vector3(-3.0, 0.0, -3.0), new Vector3.zero(), new Vector3(2.0, 2.0, 2.0), new Vector3(1.0, 0.0, 0.0));
	}
}