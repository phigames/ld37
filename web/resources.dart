part of ld37;

class Resources {

  static ImageElement spritesheet;
  static Map<String, AudioElement> sounds;
  static int imagesLoaded = 0, soundsLoaded = 0;
  static bool doneLoading = false;

  static void load() {
    loadSpritesheet();
    sounds = new Map<String, AudioElement>();
    loadSound('scribble');
    loadSound('cough');
    loadSound('doorbell');
    loadSound('water');
    loadSound('crisp');
    loadSound('tv');
    loadSound('ringtone');
    loadSound('ticking');
    loadSound('momPhone');
    loadSound('momHappy');
    loadSound('momAngry');
  }

  static void loadSpritesheet() {
    spritesheet = new ImageElement(src: 'res/spritesheet.png')..onLoad.first.then((e) => onImageLoad());
  }

  static void loadSound(String key) {
    sounds[key] = new AudioElement('res/${key}.wav')..onLoadedData.first.then((e) => onSoundLoad());
  }

  static void onImageLoad() {
    imagesLoaded++;
    if (imagesLoaded == 1 && soundsLoaded == sounds.length) {
      doneLoading = true;
    }
  }

  static void onSoundLoad() {
    soundsLoaded++;
    if (imagesLoaded == 1 && soundsLoaded == sounds.length) {
      doneLoading = true;
    }
  }

}