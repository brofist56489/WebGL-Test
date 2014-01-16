library GB_WEBGL;

import "dart:html";
import "dart:collection";
import "dart:math" as Math;
import "dart:web_gl" as WebGL;
import "dart:typed_data";
import "package:vector_math/vector_math.dart";

part "src/input/Keyboard.dart";
part "src/input/Mouse.dart";

part "src/shaders/Shader.dart";

part "src/object/Mesh.dart";
part "src/object/Material.dart";
part "src/object/Object.dart";
part "src/object/SpriteSheet.dart";

part "src/game/Game.dart";

part "src/rendering/Camera.dart";
part "src/rendering/Display.dart";

part "src/world/entity/sprite/Sprite.dart";
part "src/world/entity/Entity.dart";

WebGL.RenderingContext gl;

void main() {
	new Game();
}