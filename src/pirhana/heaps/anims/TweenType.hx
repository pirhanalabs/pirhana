package pirhana.heaps.anims;

/**
	Enumerator of Tween types, used in AnimationNode.
**/
enum TweenType
{
	EaseIn;
	EaseOut;
    EaseInOut;
    Spike;
    SpikeEaseIn;
    SpikeEaseOut;
    SpikeEaseInOut;
	ElasticEaseOut;
    ElasticEaseIn;
    ElasticEaseInOut;
    BounceEaseOut;
    BounceEaseIn;
    BounceEaseInOut;
    Custom(fn:Float->Float);
}