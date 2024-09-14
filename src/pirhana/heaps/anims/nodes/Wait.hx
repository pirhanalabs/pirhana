package pirhana.heaps.anims.nodes;

import pirhana.heaps.anims.ObjectWrapper;
import pirhana.heaps.anims.AnimationNode;
import pirhana.heaps.anims.TweenType;

/**
	Wait for a given amount of time
**/
class Wait extends AnimationNode
{
	public function new(?o:ObjectWrapper, stime:Float)
	{
		super(o, stime);
	}
}