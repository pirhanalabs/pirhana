package pirhana;

import pirhana.utils.Timeout;

class Camera {
	private var game(get, never):Game;
	private var layers(get, never):RenderLayerManager;
	private var camera(get, never):h2d.Object;
	private var scroller(get, never):h2d.Layers;

	private var timeout:Timeout;

	private var bumpx:Float = 0;
	private var bumpy:Float = 0;
	private var bumpfrict:Float = 0.84;

	private var animator:pirhana.utils.Animator;

	inline function get_scroller() {
		return layers.scroller;
	}

	inline function get_camera() {
		return layers.cameraEffects;
	}

	inline function get_layers() {
		return game.layers;
	}

	inline function get_game() {
		return Game.instance;
	}

	private var shakePower:Float;
	private var wigglePower:Float;

	public function new() {
		animator = new pirhana.utils.Animator();
	}

	public function wiggle(seconds:Float, pow = 1.0) {
		animator.add('wiggle', seconds, wiggleAnim, null);
		wigglePower = pow;
	}

	public function shakeS(seconds:Float, pow = 1.0) {
		animator.add('shake', seconds, shakeAnim, null);
		shakePower = pow;
	}

	public function bumpAngle(angle:Float, distance:Float) {
		bumpx += Math.cos(angle) * distance;
		bumpy += Math.sin(angle) * distance;
	}

	public function bump(x:Float, y:Float) {
		bumpx += x;
		bumpy += y;
	}

	@:allow(pirhana.Game)
	private function update(frame:Frame) {
		camera.x = 0;
		camera.y = 0;
		camera.rotation = 0;

		// bumps
		bumpx *= Math.pow(bumpfrict, frame.tmod);
		bumpy *= Math.pow(bumpfrict, frame.tmod);
		camera.x -= bumpx;
		camera.y -= bumpy;

		camera.scaleX = 1 + baseScaleModX;
		camera.scaleY = 1 + baseScaleModY;

		animator.update(frame);
		animator.postupdate();
	}

	var scaleModX:Float = 0;
	var scaleModY:Float = 0;
	var baseScaleModX:Float = 0;
	var baseScaleModY:Float = 0;

	function wiggleAnim(r:Float) {
		var frames = pirhana.Game.instance.frame.frames;
		camera.rotation = Math.sin(0.3 + frames * 0.5) * (Math.PI * 0.008) * wigglePower * (1 - r);
	}

	function shakeAnim(r:Float) {
		var frames = pirhana.Game.instance.frame.frames;
		camera.x += Math.cos(frames * 1.1) * 2.5 * shakePower * (1 - r);
		camera.y += Math.sin(0.3 + frames * 1.7) * 2.5 * shakePower * (1 - r);
	}

	function scaleAnim(r:Float) {
		camera.scaleX = 1 + baseScaleModX + Tween.lerp(0, scaleModX, Tween.spikeEaseIn(r));
		camera.scaleY = 1 + baseScaleModY + Tween.lerp(0, scaleModY, Tween.spikeEaseIn(r));
	}

	public function scale(modx:Float, mody:Float, stime:Float) {
		scaleModX = modx;
		scaleModY = mody;
		animator.add('scaleani', stime, scaleAnim, null);
	}

	public function setBaseScaleMod(modX:Float, modY:Float){
		this.baseScaleModX = modX;
		this.baseScaleModY = modY;
	}

	var previousBaseScaleX:Float = 0;
	var previousBaseScaleY:Float = 0;

	private function _resetBaseScaleAnim(r:Float){
		baseScaleModX = previousBaseScaleX * (1 - r);
		baseScaleModY = previousBaseScaleY * (1 - r);
	}

	public function resetBaseScaleAnim(seconds:Float){
		previousBaseScaleX = baseScaleModX;
		previousBaseScaleY = baseScaleModY;
		animator.add('descaleani', seconds, _resetBaseScaleAnim, null);
	}
}
