package pirhana.heaps.anims.nodes;

import pirhana.heaps.anims.ObjectWrapper;
import pirhana.heaps.anims.AnimationNode;
import pirhana.heaps.anims.TweenType;

/**
	Animate an object's current position to a desired position
**/
class MoveTo extends AnimationNode
{
	var sx:Float;
	var sy:Float;
	var tx:Float;
	var ty:Float;

	public function new(o:ObjectWrapper, toX:Float, toY:Float, stime:Float, ?tween:TweenType)
	{
		super(o, stime, tween);
		sx = 0;
		sy = 0;
		tx = toX;
		ty = toY;
	}

	override function begin()
	{
		super.begin();
		sx = o.x;
		sy = o.y;
	}

	override function postupdate()
	{
		super.postupdate();
		o.x = Tween.lerp(sx, tx, ratio);
		o.y = Tween.lerp(sy, ty, ratio);
	}
}