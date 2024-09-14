package pirhana.heaps.anims.nodes;

import pirhana.heaps.anims.ObjectWrapper;
import pirhana.heaps.anims.AnimationNode;
import pirhana.heaps.anims.TweenType;

/**
	Animate an object's colorAdd
**/
class ColorAdd extends AnimationNode
{
	var t:h3d.Vector;
	var f:h3d.Vector;
	var d:h2d.Drawable;

	public function new(o:ObjectWrapper, to:h3d.Vector, stime:Float, ?tween:TweenType)
	{
		super(o, stime, tween);
		t = to;
	}

	override function begin()
	{
		super.begin();
		f = Color.fromRGBf(o.r, o.g, o.b).toVector();
	}

	override function postupdate()
	{
		super.postupdate();
		o.r = Tween.lerp(f.r, t.r, ratio);
		o.g = Tween.lerp(f.g, t.g, ratio);
		o.b = Tween.lerp(f.b, t.b, ratio);
	}
}