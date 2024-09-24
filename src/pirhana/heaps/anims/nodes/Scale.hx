package pirhana.heaps.anims.nodes;

import pirhana.heaps.anims.ObjectWrapper;
import pirhana.heaps.anims.AnimationNode;
import pirhana.heaps.anims.TweenType;

/**
	Animate an object's scale
**/
class Scale extends AnimationNode {
	var sx:Float;
	var sy:Float;
	var tx:Float;
	var ty:Float;

	public function new(o:ObjectWrapper, toX:Float, toY:Float, stime:Float, ?tween:TweenType) {
		super(o, stime, tween);
		tx = toX;
		ty = toY;
		sx = o.scaleX;
		sy = o.scaleY;
	}

	override function begin() {
		super.begin();
		sx = o.scaleX;
		sy = o.scaleY;
	}

	override function postupdate() {
		super.postupdate();
		o.scaleX = Tween.lerp(sx, tx, ratio);
		o.scaleY = Tween.lerp(sy, ty, ratio);
	}
}