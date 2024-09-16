package pirhana.heaps.anims;

/**
	Base class of an AnimationNode. Must be extended by other animation things.
**/
class AnimationNode
{
	public var o:ObjectWrapper;

	public var stime:Float = 0;
	public var time:Float = 0;
	public var ratio:Float = 0;

	public var parent:Null<AnimationNode>;
	public var child:Null<AnimationNode>;
	public var siblings:Array<AnimationNode>;
	public var completed:Bool;
	public var paused:Bool;

	public var tweenfn:Float->Float;
	public var callback:Null<h2d.Object->Void>;

	private function new(o:ObjectWrapper, stime:Float, ?tween:TweenType)
	{
		this.completed = false;
		this.paused = false;
		this.stime = stime;
		this.time = 0;
		this.ratio = 0;
		this.o = o;
		this.siblings = [];
		tweenfn = Tween.linear;

		if (tween != null)
		{
			setTween(tween);
		}

		if (this.stime == 0)
		{
			this.stime = time = ratio = -1;
		}
	}

	public function begin()
	{
		// override this in subclasses
	}

	public function addCallback(fn:h2d.Object->Void)
	{
		this.callback = fn;
		return this;
	}

	private function setTween(type:TweenType)
	{
		switch (type)
		{
			case EaseIn:
				tweenfn = Tween.easeIn;
			case EaseOut:
				tweenfn = Tween.easeOut;
            case EaseInOut:
                tweenfn = Tween.easeInOut;
            case Spike:
                tweenfn = Tween.spike;
            case SpikeEaseIn:
                tweenfn = Tween.spikeEaseIn;
            case SpikeEaseOut:
                tweenfn = Tween.spikeEaseOut;
            case SpikeEaseInOut:
                tweenfn = Tween.spikeEaseInOut;
            case ElasticEaseIn:
                tweenfn = Tween.elasticEaseIn;
			case ElasticEaseOut:
				tweenfn = Tween.elasticEaseOut;
            case ElasticEaseInOut:
                tweenfn = Tween.elasticEaseInOut;
            case BounceEaseIn:
                tweenfn = Tween.bounceEaseIn;
            case BounceEaseOut:
                tweenfn = Tween.bounceEaseOut;
            case BounceEaseInOut:
                tweenfn = Tween.bounceEaseInOut;
            case Custom(fn):
                tweenfn = fn;
		}
		return this;
	}

	public function postupdate()
	{
		// override this in subclasses
	}
}