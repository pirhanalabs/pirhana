package pirhana.utils;

typedef AnimElement =
{
	id:String,
	curtime:Float,
	maxtime:Float,
	anim:Float->Void,
	cb:Void->Void
}

class AnimGroup
{
	var cb:Void->Void;
	var all:Array<AnimElement> = [];
	var done:Bool;

	public function new()
	{
		done = false;
	}

	public function setCallback(cb:Void->Void)
	{
		this.cb = cb;
		return this;
	}

	public function add(stime:Float, anim:Float->Void)
	{
		all.push(
			{
				id: '',
				curtime: 0.0,
				maxtime: stime,
				anim: anim,
				cb: cb
			});
		return this;
	}

	@:allow(utils.Animator)
	private function update(dt:Float)
	{
		done = true;

		for (anim in all)
		{
			if (anim.curtime != anim.maxtime)
			{
				done = false;
				anim.curtime = (anim.curtime + dt).clamp(0, anim.maxtime);
			}
		}
	}

	@:allow(utils.Animator)
	private function postupdate()
	{
		for (anim in all)
		{
			if (anim.anim != null)
			{
				anim.anim(anim.curtime / anim.maxtime);
			}
		}
	}

	@:allow(utils.Animator)
	private function callback()
	{
		for (anim in all)
		{
			if (anim.cb != null)
			{
				anim.cb();
			}
		}
		if (cb != null)
		{
			cb();
		}
	}

	public function isDone()
	{
		return done;
	}
}

class Animator
{
	var anims:Array<AnimElement>;
	var map:Map<String, AnimElement>;

	var queue:List<AnimGroup>;
	var curr:Null<AnimGroup>;

	public function new()
	{
		queue = new List();
		anims = [];
		map = [];
	}

	public function addQueue()
	{
		var g = new AnimGroup();
		queue.add(g);
		return g;
	}

	public function add(id:String, stime:Float, anim:Float->Void, cb:Void->Void)
	{
		var element =
			{
				id: id,
				curtime: 0.0,
				maxtime: stime,
				anim: anim,
				cb: cb
			};

		// override old one if any.
		if (map.exists(id))
		{
			var e = map.get(id);
			anims.remove(e);
		}

		map.set(id, element);
		anims.push(element);
	}

	function updateAnim(id:Int, frame:Frame)
	{
		anims[id].curtime += frame.dt;

		if (anims[id].curtime > anims[id].maxtime)
		{
			anims[id].curtime = anims[id].maxtime;
		}
	}

	function isDone(anim:AnimElement)
	{
		return anim.curtime == anim.maxtime;
	}

	public function update(frame:Frame)
	{
		// queue stuff

		if (curr != null)
		{
			if (curr.isDone())
			{
				curr.callback();
				curr = null;
			}
			else
			{
				curr.update(frame.dt);
			}
		}

		if (queue.length != 0)
		{
			if (curr == null)
			{
				curr = queue.pop();
			}
		}

		// not queued stuff

		var i = anims.length - 1;

		while (i >= 0)
		{
			var anim = anims[i];

			if (isDone(anim))
			{
				if (anim.cb != null)
				{
					anims.remove(anim);
					map.remove(anim.id);
					anim.cb();
				}
			}
			else
			{
				anim.curtime += frame.dt;
				if (anim.curtime >= anim.maxtime)
				{
					anim.curtime = anim.maxtime;
				}
			}
			i--;
		}
	}

	public function postupdate()
	{
		if (curr != null)
		{
			curr.postupdate();
		}

		for (anim in anims)
		{
			anim.anim(anim.curtime / anim.maxtime);
		}
	}
}
