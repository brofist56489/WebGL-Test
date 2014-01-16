part of GB_WEBGL;

class Entity extends Object {
	Entity(Vector3 position, Material texture, Mesh mesh) : super(position, texture, mesh);
	
	Vector3 velocity;
}