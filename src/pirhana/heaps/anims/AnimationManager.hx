package pirhana.heaps.anims;

import pirhana.heaps.anims.nodes.*;

/**
	Handles all the animation class stuff.
**/
class AnimationManager {
	private var nodes:List<AnimationNode>;

	/**
		Instantiate this class in your screens or framework to handle animation stuff.
	**/
	public function new() {
		nodes = new List();
	}

	/**
		Clears all the animations. Warning: if animations are ongoing, they will stop midway and not
		reach their endpoint. Might change this if it becomes bothersome.
	**/
	public function clear() {
		nodes.clear();
	}

	/**
		Moves the object to a desired position.
	**/
	public function moveto(o:h2d.Object, tox:Float, toy:Float, stime:Float, ?tween:TweenType) {
		var n = new MoveTo(new ObjectWrapper(o), tox, toy, stime, tween);
		add(n);
		return new AnimationHandler(n);
	}

	/**
		Scales the object to [scalex, scaley].
	**/
	public function scale(o:h2d.Object, scalex:Float, scaley:Float, stime:Float, ?tween:TweenType) {
		var n = new Scale(new ObjectWrapper(o), scalex, scaley, stime, tween);
		add(n);
		return new AnimationHandler(n);
	}

	/**
		Modify the color of a h2d.Drawable over time.
	**/
	public function coloradd(o:h2d.Drawable, color:Color, stime:Float, ?tween:TweenType) {
		var n = new ColorAdd(new ObjectWrapper(o), color.toVector(), stime, tween);
		add(n);
		return new AnimationHandler(n);
	}

	/**
		Wait a given amount of time.
	**/
	public function wait(o:h2d.Object, stime:Float) {
		var n = new Wait(new ObjectWrapper(o), stime);
		add(n);
		return new AnimationHandler(n);
	}

	/**
		Modify the alpha value of an object.
	**/
	public function alpha(o:h2d.Object, to:Float, stime:Float, ?tween:TweenType) {
		var n = new Alpha(new ObjectWrapper(o), to, stime, tween);
		add(n);
		return new AnimationHandler(n);
	}

	/**
		Moves the object around from its current position.
	**/
	public function rumble(o:h2d.Object, power:Float, stime:Float, ?tween:TweenType) {
		var n = new Rumble(new ObjectWrapper(o), power, stime, tween);
		add(n);
		return new AnimationHandler(n);
	}

	/**
		Apply a custom animation.
	**/
	public function custom(node:AnimationNode) {
		add(node);
		return new AnimationHandler(node);
	}

	public function add<T:AnimationNode>(node:T):T {
		nodes.push(node);
		return node;
	}

	public function update(frame:Frame) {
		for (n in nodes.iterator()) {
			if (n.completed) {
				nodes.remove(n);
			}
			updateNode(n, frame);
		}
	}

	private function updateNode(n:AnimationNode, frame:Frame) {
		if (n.completed && n.callback != null) {
			n.callback(n.o.o);
		}

		if (n.time <= 0) {
			n.begin();
		}

		var siblings = true;
		if (n.siblings.length != 0) {
			for (s in n.siblings) {
				if (s.completed) {
					continue;
				}

				if (siblings) {
					siblings = n.completed;
				}

				updateNode(s, frame);
			}
		}

		if (n.time / n.stime == 1) {
			if (siblings) {
				n.completed = true;
				if (n.child != null) {
					updateNode(n.child, frame);
					n.completed = n.child.completed;
				}
			}
		} else {
			n.time = Math.min(n.time + frame.dt, n.stime);
			n.ratio = n.tweenfn(n.time / n.stime);
		}
	}

	public function postupdate() {
		for (n in nodes) {
			postupdateNode(n);
		}
	}

	private function postupdateNode(n:AnimationNode) {
		n.postupdate();

		if (n.time / n.stime == 1 && n.child != null && n.child.time != 0) {
			postupdateNode(n.child);
		}

		if (n.siblings.length != 0) {
			for (s in n.siblings) {
				if (!s.completed) {
					postupdateNode(s);
				}
			}
		}
	}
}
