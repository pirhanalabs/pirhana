package pirhana.utils;

using pirhana.extensions.FloatExtension;

class Timeout
{
	public var duration(default, null):Float;
	public var start(default, null):Float;
	public var isComplete(default, null):Bool;

	public var progress(get, never):Float;

	private var now(get, never):Float;

	inline function get_now():Float
	{
		return Game.instance.frame.elapsed;
	}

	inline function get_progress():Float
	{
		return ((now - start) / duration).clamp(0, 1);
	}

	public function new(seconds:Float)
	{
		this.duration = seconds;
		this.start = now;
		isComplete = false;
	}

	public function reset()
	{
		start = now;
		isComplete = false;
	}

	public function stop()
	{
		isComplete = true;
	}

	public function update()
	{
		if (!isComplete && (now - start) > duration)
		{
			isComplete = true;
			onComplete();
		}
	}

	public dynamic function onComplete() {}
}
