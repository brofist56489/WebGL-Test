part of GB_WEBGL;

class Game {
	static CanvasElement CANVAS;
	static GameTimer _timer;
	
	static Display _display;

	bool running;
	
	Game() {
		Keyboard.init();
		Mouse.init();
		
		running = true;
		_timer = new GameTimer(this);
		CANVAS = querySelector("#targetCanvas");
		CANVAS.width = 854;
		CANVAS.height = 480;
		gl = CANVAS.getContext("webgl");
		if(gl == null) {
			gl = CANVAS.getContext("experimental-webgl");
		}
		gl.enable(WebGL.DEPTH_TEST);
		
		Shader.current.use();
		
		_display = new Display();
		Sprite s = new Sprite(new Vector3(0.0, 0.0, -2.0), "texture.png", 1.0);
		s.color = new Vector3(1.0, 1.0, 1.0);
		_display.objects.add(s);
		
		Mesh mesh = new Mesh();
		mesh.setVerticies(
		[
			-10.0, 0.0, -10.0, 0.0, 0.0,
			10.0, 0.0, -10.0, 1.0, 0.0,
			10.0, 0.0, 10.0, 1.0, 1.0,
			-10.0, 0.0, 10.0, 0.0, 1.0,
		],
		[
			0, 1, 2, 0, 2, 3
		]);
		
		Object floor = new Object(new Vector3(0.0, -0.5, 0.0), new Material.load("texture.png"), mesh);
		floor.color = new Vector3(1.0, 0.0, 0.0);
		_display.objects.add(floor);
		
		_display.camera.position = new Vector3(0.0, 0.5, 4.0);
		
		_timer.start();
	}
	
	void tick() {
		Keyboard.poll();
		Mouse.poll();
		_display.update();
	}
	
	void render() {
		gl.viewport(0, 0, CANVAS.width, CANVAS.height);
		gl.clearColor(0.0, 0.0, 0.0, 1.0);
		gl.clear(WebGL.COLOR_BUFFER_BIT | WebGL.DEPTH_BUFFER_BIT);
		
		_display.render();
	}
	
	static Display getDisplay() {
		return _display;
	}
}

class GameTimer {
	int ltr = new DateTime.now().millisecondsSinceEpoch;
	int lt = new DateTime.now().millisecondsSinceEpoch;
	int now;
	double msPt = 60.0 / 1000.0;
	double delta = 0.0;
	
	int ticks = 0;
	int frames = 0;
	
	Game game;
	
	GameTimer(Game this.game);
	
	void start() {
		window.requestAnimationFrame(update);
	}
	
	void update(double time) {
		now = new DateTime.now().millisecondsSinceEpoch;
		delta += (now - lt) * msPt;
		lt = now;
		
		while(delta >= 1) {
			game.tick();
			ticks++;
			delta--;
		}
		
		game.render();
		frames++;
		
		if(now - ltr >= 1000.0) {
			print("$ticks tps, $frames fps");
			ticks = 0;
			frames = 0;
			ltr += 1000;
		}
		
		if(game.running)
			window.requestAnimationFrame(update);
	}
}