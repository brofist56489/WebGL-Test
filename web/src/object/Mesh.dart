part of GB_WEBGL;

class Mesh {
	WebGL.Buffer vertexBuffer;
	WebGL.Buffer indexBuffer;
	int size;
	
	Mesh() {
		vertexBuffer = gl.createBuffer();
		indexBuffer = gl.createBuffer();
	}
	
	void setVerticies(List<double> vs, List<int> ind) {
		Float32List verticies = new Float32List.fromList(vs);
		Int16List indicies = new Int16List.fromList(ind);
	
		size = indicies.length;
		
		gl.bindBuffer(WebGL.ARRAY_BUFFER, vertexBuffer);
		gl.bufferData(WebGL.ARRAY_BUFFER, verticies, WebGL.STATIC_DRAW);
		
		gl.bindBuffer(WebGL.ELEMENT_ARRAY_BUFFER, indexBuffer);
		gl.bufferData(WebGL.ELEMENT_ARRAY_BUFFER, indicies, WebGL.STATIC_DRAW);
	}
	
	void render(Vector3 pos, Vector3 rotation, Vector3 scale, Vector3 color) {
		Shader.setColor(color);
		
		Matrix4 objMatrix = new Matrix4.identity();
		objMatrix.translate(pos);
		objMatrix.rotate(new Vector3(1.0, 0.0, 0.0), rotation.x);
		objMatrix.rotate(new Vector3(0.0, 1.0, 0.0), rotation.y);
		objMatrix.rotate(new Vector3(0.0, 0.0, 1.0), rotation.z);
		objMatrix.scale(scale);
		Shader.setObjMatrix(objMatrix);
	
		gl.bindBuffer(WebGL.ARRAY_BUFFER, vertexBuffer);
		gl.vertexAttribPointer(Shader.current.posLoc, 3, WebGL.FLOAT, false, 20, 0);
		gl.vertexAttribPointer(Shader.current.texLoc, 2, WebGL.FLOAT, false, 20, 12);
		
		gl.bindBuffer(WebGL.ELEMENT_ARRAY_BUFFER, indexBuffer);
		gl.drawElements(WebGL.TRIANGLES, size, WebGL.UNSIGNED_SHORT, 0);
	}
}