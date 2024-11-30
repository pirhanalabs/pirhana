package pirhana.utils;

using pirhana.extensions.FloatExtension;

typedef AnimElement =
{
	id:String,
	curtime:Float,
	maxtime:Float,
	anim:Float->Void,
	cb:Void->Void
}

class AnimGroup implements pirhana.utils.state.IEventState
{
	var cb:Void->Void;
	var all:Array<AnimElement> = [];
	var done:Bool;

	@:allow(pirhana.utils.Animator)
	var finished:Bool = false;

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

	public function update(frame:Frame)
	{
		done = true;

		for (anim in all)
		{
			if (anim.curtime != anim.maxtime)
			{
				done = false;
				anim.curtime = (anim.curtime + frame.dt).clamp(0, anim.maxtime);
			}
		}
	}

	public function postupdate()
	{
		for (anim in all)
		{
			if (anim.anim != null)
			{
				anim.anim(anim.curtime / anim.maxtime);
			}
		}
	}

	@:allow(pirhana.utils.Animator)
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

	public function onEnter() {}

	@:allow(pirhana.utils.Animator)
	private function isDone(){
		return done;
	}

	public function isFinished():Bool {
		return finished;
	}
}

class Animator
{
	var anims:Array<AnimElement>;
	var map:Map<String, AnimElement>;

	var queue:List<AnimGroup>;
	var curr:Null<AnimGroup>;

	var count:Int = 0;

	public function new()
	{
		queue = new List();
		anims = [];
		map = [];
	}

	public function isAnimating(){
		return count != 0;
	}

	public function addQueue()
	{
		var g = new AnimGroup();
		queue.add(g);
		count++;
		return g;
	}

	/**
		Nameless animations cannot be cancelled, be warned.
	**/
	public function addNameless(stime:Float, anim:Float->Void, cb:Void->Void)
	{
		var element = {
			id:'',
			curtime:0.0,
			maxtime:stime,
			anim:anim,
			cb:cb,
		};
		anims.push(element);
		count++;
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
		count++;
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
				curr.finished = true;
				curr.callback();
				curr = null;
				count--;
			}
			else
			{
				curr.update(frame);
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
					anim.cb();
				}
				anims.remove(anim);
				map.remove(anim.id);
				count--;
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
