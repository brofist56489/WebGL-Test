part of GB_WEBGL;

class Shader {
	static Shader current = basic;
	static Shader basic = new Shader(basicVertexShaderCode, basicFragmentShaderCode);

	String vertexCode, fragmentCode;
	WebGL.UniformLocation objectMatrixLoc, viewMatrixLoc, cameraMatrixLoc, colorLoc;
	WebGL.Shader vertexShader, fragmentShader;
	WebGL.Program program;
	
	int posLoc, texLoc;
	
	Shader(this.vertexCode, this.fragmentCode) {
		compile();
		use();
		Matrix4 viewMatrix = makePerspectiveMatrix(75.0*Math.PI/180.0, Game.CANVAS.width/Game.CANVAS.height, 0.01, 100.0);
		gl.uniformMatrix4fv(viewMatrixLoc, false, viewMatrix.storage);
		
		gl.uniformMatrix4fv(cameraMatrixLoc, false, new Matrix4.identity().storage);
	}
	
	static void setColor(Vector3 color) {
		gl.uniform3fv(current.colorLoc, color.storage);
	}
	
	static void setObjMatrix(Matrix4 objMatrix) {
		gl.uniformMatrix4fv(current.objectMatrixLoc, false, objMatrix.storage);
	}
	
	static void setCameraMatrix(Matrix4 cameraMatrix) {
		gl.uniformMatrix4fv(current.cameraMatrixLoc, false, cameraMatrix.storage);
	}
	
	void use() {
		gl.useProgram(program);
		gl.enableVertexAttribArray(posLoc);
		gl.enableVertexAttribArray(texLoc);
	}
	
	void compile() {
		vertexShader = gl.createShader(WebGL.VERTEX_SHADER);
		gl.shaderSource(vertexShader, vertexCode);
		gl.compileShader(vertexShader);
		if(!gl.getShaderParameter(vertexShader, WebGL.COMPILE_STATUS)) {
			throw gl.getShaderInfoLog(vertexShader);
		}
		
		fragmentShader = gl.createShader(WebGL.FRAGMENT_SHADER);
		gl.shaderSource(fragmentShader, fragmentCode);
		gl.compileShader(fragmentShader);
		if (!gl.getShaderParameter(fragmentShader, WebGL.COMPILE_STATUS)) {
			throw gl.getShaderInfoLog(fragmentShader);
		}
		
		program = gl.createProgram();
		gl.attachShader(program, vertexShader);
		gl.attachShader(program, fragmentShader);
		gl.linkProgram(program);
		if (!gl.getProgramParameter(program, WebGL.LINK_STATUS)) {
			throw gl.getProgramInfoLog(program);
		}
		
		posLoc = gl.getAttribLocation(program, "a_pos");
		texLoc = gl.getAttribLocation(program, "a_texCoord");
		
		objectMatrixLoc = gl.getUniformLocation(program, "objectMatrix");
		viewMatrixLoc = gl.getUniformLocation(program, "viewMatrix");
		cameraMatrixLoc = gl.getUniformLocation(program, "cameraMatrix");
		colorLoc = gl.getUniformLocation(program, "color");
	}
}

String basicVertexShaderCode = """
	precision highp float;

	attribute vec3 a_pos;
	attribute vec2 a_texCoord;

	uniform mat4 objectMatrix;
	uniform mat4 viewMatrix;
	uniform mat4 cameraMatrix;

	varying vec2 v_texCoord;

	void main() {
		v_texCoord = a_texCoord;
		vec4 pos = viewMatrix*cameraMatrix*objectMatrix*vec4(a_pos, 1.0);
		gl_Position = pos;
	}
""";

String basicFragmentShaderCode = """
	precision highp float;
	
	varying vec2 v_texCoord;

	uniform vec3 color;
	uniform sampler2D u_tex;

	void main() {
		vec4 col = texture2D(u_tex, v_texCoord);
		if (col.a > 0.0) {
			gl_FragColor	 = length(v_texCoord) * vec4(color, 1.0);
		} else {
			discard;
		}
	}
""";