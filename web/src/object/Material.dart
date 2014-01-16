part of GB_WEBGL;

class Material {
	ImageElement image;
	WebGL.Texture texture;
	bool loaded = false;
	
	Material.load(String path) {
		image = new ImageElement();
		texture = gl.createTexture();
		image.onLoad.listen((Event e) {
			gl.bindTexture(WebGL.TEXTURE_2D, texture);
			gl.texImage2DImage(WebGL.TEXTURE_2D, 0, WebGL.RGBA, WebGL.RGBA, WebGL.UNSIGNED_BYTE, image);
			gl.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_MIN_FILTER, WebGL.NEAREST);
			gl.texParameteri(WebGL.TEXTURE_2D, WebGL.TEXTURE_MAG_FILTER, WebGL.NEAREST);
			loaded = true;
		});
		image.src = path;
	}
	
	void use() {
		if(loaded)
			gl.bindTexture(WebGL.TEXTURE_2D, texture);
	}
}