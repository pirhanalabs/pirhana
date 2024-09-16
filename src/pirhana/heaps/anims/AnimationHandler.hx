package pirhana.heaps.anims;

import pirhana.heaps.anims.nodes.*;

/** interface for creating animation **/
class AnimationHandler
{
	private var isafter:Bool = false;
	private var node:AnimationNode;

	public function new(node:AnimationNode)
	{
		this.node = node;
	}

	/**
		Adds a callback to this animation node.
	**/
	public function callback(callback:h2d.Object->Void)
	{
		this.node.addCallback(callback);
		return this;
	}

	/**
		Adds a callback to the last sibling added of this animation node.
	**/
	public function callbackToSibling(callback:h2d.Object->Void)
	{
		if (this.node.siblings.length > 0)
		{
			this.node.siblings[this.node.siblings.length - 1].addCallback(callback);
		}
		return this;
	}

	/**
		Adds a custom animation node.

		if `o` of `node` is null, previous o defined will be used.
	**/
	public function custom(node:AnimationNode)
	{
		if (node.o == null)
		{
			node.o = this.node.o;
		}
		parse(node);
		return this;
	}

	/**
		Moves the object to a desired position.

		if `o` is null, previous o defined will be used.
	**/
	public function moveto(?o:h2d.Object, tox:Float, toy:Float, stime:Float, ?tween:TweenType)
	{
		var n = new MoveTo(o == null ? node.o : new ObjectWrapper(o), tox, toy, stime, tween);
		parse(n);
		return this;
	}

	/**
		Scales the object to [scalex, scaley].

		if `o` is null, previous o defined will be used.
	**/
	public function scale(?o:h2d.Object, tox:Float, toy:Float, stime:Float, ?tween:TweenType)
	{
		var n = new Scale(o == null ? node.o : new ObjectWrapper(o), tox, toy, stime, tween);
		parse(n);
		return this;
	}

	/**
		Modify the alpha value of an object.

		if `o` is null, previous o defined will be used.
	**/
	public function alpha(?o:h2d.Object, to:Float, stime:Float, ?tween:TweenType)
	{
		var n = new Alpha(o == null ? node.o : new ObjectWrapper(o), to, stime, tween);
		parse(n);
		return this;
	}

	/**
		Moves the object around from its current position.

		if `o` is null, previous o defined will be used.
	**/
	public function rumble(?o:h2d.Object, power:Float, stime:Float, ?tween:TweenType)
	{
		var n = new Rumble(o == null ? node.o : new ObjectWrapper(o), power, stime, tween);
		parse(n);
		return this;
	}

	/**
		Modify the color of a h2d.Drawable over time.

		if `o` is null, previous o defined will be used.
	**/
	public function coloradd(?o:h2d.Drawable, to:Color, stime:Float, ?tween:TweenType)
	{
		var n = new ColorAdd(o == null ? node.o : new ObjectWrapper(o), to.toVector(), stime, tween);
		parse(n);
		return this;
	}

	/**
		Wait a given amount of time.
	**/
	public function wait(stime:Float)
	{
		after();
		var n = new Wait(node.o, stime);
		parse(n);
		after();
		return this;
	}

	/**
		Makes the next added animation as a child instead of a sibling.
	**/
	public function after()
	{
		isafter = true;
		return this;
	}

	public function getEvent(){
		return AnimationNodeEvent(node);
	}

	private function parse(n:AnimationNode)
	{
		if (isafter)
		{
			isafter = false;
			node.child = n;
			n.parent = node;
			node = n;
		}
		else
		{
			node.siblings.push(n);
		}
	}
}