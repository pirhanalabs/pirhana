package pirhana.extensions;

class MapExtension
{
	public static function each<T, K>(map:Map<T, K>, fn:K->Void)
	{
		for (k => v in map)
		{
			fn(v);
		}
	}
}
