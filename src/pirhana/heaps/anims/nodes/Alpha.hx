package pirhana.heaps.anims.nodes;

import pirhana.heaps.anims.ObjectWrapper;
import pirhana.heaps.anims.AnimationNode;
import pirhana.heaps.anims.TweenType;

/**
	Animate an object's alpha value
**/
class Alpha extends AnimationNode
{
	var sa:Float;
	var ta:Float;

	public function new(o:ObjectWrapper, toAlpha:Float, stime:Float, ?tween:TweenType)
	{
		super(o, stime, tween);
		ta = toAlpha;
	}

	override function begin()
	{
		super.begin();
		sa = o.alpha;
	}

	override function postupdate()
	{
		super.postupdate();
		o.alpha = Tween.lerp(sa, ta, ratio);
	}
}