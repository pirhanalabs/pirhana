package pirhana.heaps.anims.nodes;

import pirhana.heaps.anims.ObjectWrapper;
import pirhana.heaps.anims.AnimationNode;
import pirhana.heaps.anims.TweenType;

/**
	Shake an object around a center point for a given amount of time.
**/
class Rumble extends AnimationNode
{
	var power:Float;

	public function new(o:ObjectWrapper, power:Float, stime:Float, ?tween:TweenType)
	{
		super(o, stime, tween);
		this.power = power;
	}

	override function begin()
	{
		super.begin();
	}

	override function postupdate()
	{
		super.postupdate();
		// this modifies the object directly instead of the wrapper. This way we can move the wrapper beforehand
		// and update the rumble around the new position. However, if moving after the rumble, position will be reset.
		o.o.x = o.x + Math.cos(Game.instance.frame.frames * 1.1) * 2.5 * power * (1 - ratio);
		o.o.y = o.y + Math.sin(0.3 + Game.instance.frame.frames * 1.7) * 2.5 * power * (1 - ratio);
	}
}