part of GB_WEBGL;

class Mouse {
	static Vector2 pos;
	static Vector2 rel;
	static List<bool> buttons;
	static List<bool> onceButtons;
	
	static void init() {
		pos = new Vector2(0.0, 0.0);
		rel = new Vector2(0.0, 0.0);
		buttons = new List<bool>(3);
		buttons.fillRange(0, 3, false);
		onceButtons = new List<bool>(3);
		onceButtons.fillRange(0, 3, false);
		
		window.onMouseDown.listen((MouseEvent e) {
			buttons[e.button] = true;
			onceButtons[e.button] = true;
		});
		window.onMouseUp.listen((MouseEvent e) {
			buttons[e.button] = false;
			onceButtons[e.button] = false;
		});
		window.onMouseMove.listen((MouseEvent e) {
			int x = e.offset.x;
			int y = e.offset.y;
			Vector2 newPos = new Vector2(x + 0.0, y + 0.0);
			rel = newPos - pos;
			pos = newPos;
		});
	}
	
	static void poll() {
		rel = new Vector2(0.0, 0.0);
		onceButtons.fillRange(0, 3, false);
	}
}