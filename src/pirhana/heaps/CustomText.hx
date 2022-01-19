package pirhana.heaps;

import h2d.RenderContext;

private class BouncyTextCharacter extends TextCharacter{

    public var t : Float = 0;
    public var baseY : Float = 0;
    var bounciness = 7;
    var speed = 5;

    override function draw(ctx:RenderContext) {
        super.draw(ctx);
    }

    override function sync(ctx:RenderContext) {
        super.sync(ctx);

        var dt = hxd.Timer.dt;

        t += 1 * dt * speed;
        t %= Math.PI*2;
        this.y = baseY + Math.cos(t) * bounciness;
    }
}

private class TextCharacter extends h2d.Text{

    public function new(font:h2d.Font, character:String, ?parent:h2d.Object){
        super(font, parent);
        this.text = character;
    }
}

class CustomText extends h2d.Object{

    var font : h2d.Font;
    var handler : String->TextCharacter;
    var color : Int = 0x000000;
    var lastX : Float = 0.0;
    var lastY : Float = 0.0;
    var bouncyOffset = 0.0;

    /**
        usage:
        "<bounce>this</bounce> is my cool <0xff0000>text"
    **/
    public function new(font:h2d.Font, text:String, ?parent:h2d.Object){
        super(parent);

        var effects = [
            "bounce" => startBouncyHandler,
            "/bounce" => endBouncyHandler
        ];

        this.font = font;
        this.color = 0x000000;
        this.lastX = 0.0;
        this.lastY = 0.0;

        var chars = text.split("");
        var isTag = false;
        var tag = "";

        handler = makeDefaultCharacter;

        for (char in chars){
            if(char == "\n"){
                lastX = 0;
                lastY += font.lineHeight;
                continue;
            }

            if (char == "<"){
                isTag = true;
                continue;
            }

            if (char == ">"){

                if (tag.indexOf("0x") == 0)
                    color = Std.parseInt(tag);

                else if (effects[tag] != null)
                    handler = effects[tag]();

                tag = "";
                isTag = false;
                continue;
            }

            if (isTag){
                tag += char;
                continue;
            }

            createCharacters(char);
        }
    }

    private function createCharacters(char:String){
        var tc = handler(char);
        tc.x = lastX;
        tc.y = lastY;
        tc.textColor = color;
        this.addChild(tc);
        lastX = tc.x + tc.calcTextWidth(char);
    }

    private function makeDefaultCharacter(character:String):TextCharacter{
        return new TextCharacter(font, character, this);
    }

    private function makeBouncyCharacter(character:String):TextCharacter{
        return makeDefaultCharacter(character);
        var c = new BouncyTextCharacter(font, character, this);
        c.baseY = lastY;
        c.t += this.bouncyOffset;
        bouncyOffset += Math.PI * 0.1;
        return c;
    }

    private function startBouncyHandler(){
        return makeBouncyCharacter;
    }

    private function endBouncyHandler(){
        bouncyOffset = 0;
        return makeDefaultCharacter;
    }
}