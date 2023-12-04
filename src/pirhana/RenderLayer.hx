package pirhana;

enum RenderLayerSpace
{
	Screen;
	World;
}

class RenderLayer
{
	public var space(default, null):RenderLayerSpace;
	public var ob(default, null):h2d.Layers;
	public var visible(get, set):Bool;

	public function new(space:RenderLayerSpace)
	{
		this.space = space;
		ob = new h2d.Layers();
		visible = true;
	}

	inline function set_visible(val:Bool)
	{
		return ob.visible = val;
	}

	inline function get_visible()
	{
		return ob.visible;
	}
}
