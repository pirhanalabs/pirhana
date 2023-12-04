package pirhana.heaps.shaders;

class Glint extends hxsl.Shader {

    static var SRC = {
        @:import h3d.shader.Base2d;
        
        @param var speed : Float = 0.6;
        @param var linewidth : Float = 0.8;
        @param var grad : Float = 3.0;
        @param var intensity : Float = 0.6;
        
        function fragment() {
            var col1 = vec4(0.3, 0.0, 0.0, 1.0);
            var col2 = vec4(0.85, 0.85, 0.85, 1.0);
            var color = textureColor;
            var linepos = calculatedUV;

            linepos.x = linepos.x - mod(time*speed,2.0)+0.5;

            var y = linepos.x * grad;
            var s = smoothstep(y-linewidth, y, linepos.y) - smoothstep(y, y+linewidth, linepos.y);

            pixelColor = color + ((s*col1)+(s*col2)) * intensity;
            pixelColor.a = color.a;
        }
    }

}