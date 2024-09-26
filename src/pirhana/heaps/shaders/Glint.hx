package pirhana.heaps.shaders;

class Glint extends hxsl.Shader {
	static var SRC = {
		@:import h3d.shader.Base2d;

		/**
			Glint line speed.
		**/
		@param var speed:Float = 0.8;

		/**
			Glint line width.
		**/
		@param var linewidth:Float = 0.8;

		/**
			Gradiant angle.
		**/
		@param var grad:Float = 3.0;

		/**
			Glint strength.
		**/
		@param var intensity:Float = 0.5;

		/**
			Delay between each passing glint.
		**/
		@param var delay:Float = 2.0;

		/**
			Fragment shader.
		**/
		function fragment() {
			var col1 = vec4(0.3, 0.0, 0.0, 1.0);
			var col2 = vec4(0.85, 0.85, 0.85, 1.0);
			var color = textureColor;
			var linepos = input.uv;

			var tdelay = 1.0 + delay;

			linepos.x = linepos.x - clamp(mod(time * speed * (1.0 / tdelay), 2.0), 0.0, 1.0) * tdelay + 0.5;

			var y = linepos.x * grad;
			var s = smoothstep(y - linewidth, y, linepos.y) - smoothstep(y, y + linewidth, linepos.y);

			pixelColor = color + ((s * col1) + (s * col2)) * intensity;
			pixelColor.a = color.a;
		}
	}
}