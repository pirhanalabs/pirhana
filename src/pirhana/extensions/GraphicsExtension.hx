package pirhana.extensions;

typedef Point = {
    x:Float,
    y:Float
}

class GraphicsExtension{
    
    /**
     * Draws a dashed line starting from [x1, y1] going to [x2, y2].
     * This function is assuming we already set the graphics.lineStyle() function accordingly
     * @param graphics the h2d.Graphics target
     * @param x1 starting x position
     * @param y1 starting y position
     * @param x2 destination x position
     * @param y2 destination y position
     * @param width width of a single dash line
     * @param gap the gap between dash lines
     * @param offset = 0.0 scroll distance we begin drawing at
     */
    public static function drawDashed(graphics:h2d.Graphics, x1:Float, y1:Float, x2:Float, y2:Float, width:Float, gap:Float, offset = 0.0){
        var radian = hxd.Math.atan2(y2-y1, x2-x1);
        var distance = hxd.Math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1));
        var cur_distance = offset % (width + gap);
        var x = 0.0;
        var y = 0.0;

        // if we are further than the gap, draw the first dash portion needed
        if (cur_distance > gap){
            graphics.moveTo(x1, y1);
            x = x1 + hxd.Math.cos(radian) * (cur_distance - gap);
            y = y1 + hxd.Math.sin(radian) * (cur_distance - gap);
            graphics.lineTo(x, y);
        }

        while (cur_distance <= distance){
            x = x1 + hxd.Math.cos(radian) * cur_distance;
            y = y1 + hxd.Math.sin(radian) * cur_distance;
            graphics.moveTo(x, y);
            cur_distance += width;
            if (cur_distance > distance) cur_distance = distance;
            x = x1 + Math.cos(radian) * cur_distance;
            y = y1 + Math.sin(radian) * cur_distance;
            graphics.lineTo(x, y);
            cur_distance += gap;
        }
    }
}