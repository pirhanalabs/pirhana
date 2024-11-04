package pirhana;

class AudioManager{

    public var volumeMusic(default, null):Float = 1;
    public var volumeSound(default, null):Float = 1;

    private var music:Null<hxd.snd.Channel>;
    private var nextm:Null<hxd.snd.Channel>;

    public function new(){

    }

    public function setMusic(snd:hxd.res.Sound, fadetime:Float){
        var c = snd.play(true, 1 * volumeMusic);

        // this should be handled differently
        if (nextm != null){
            nextm.stop();
            nextm = null;
        }

        if (music != null){
            nextm = c;
            nextm.volume = 0;
            nextm.fadeTo(1 * volumeMusic, fadetime, null);
            music.fadeTo(0, fadetime, function(){
                music.stop();
                music = nextm;
                nextm = null;
            });
        }
    }

    public function playSound(snd:hxd.res.Sound, pitchVariance:Float = 0) {
		var s = snd.play(false, 1 * volumeSound);
		#if js
		// dont add pitch if js. Js sucks for pitch.
		#else
		// add pitch. sounds more natural
        if (pitchVariance > 0){
            s.addEffect(new hxd.snd.effect.Pitch(MathTools.rand(1 - pitchVariance, 1 + pitchVariance)));
        }
		
		#end
	}

    public function setMasterVolume(vol:Float){
        hxd.snd.Manager.get().masterVolume = vol;
    }

    public function setMusicVolume(vol:Float){
        this.volumeMusic = vol;
        
    }

    public function setSoundVolume(vol:Float){
        this.volumeSound = vol;
    }
}