part of ld37;

class Resources {

  //static ImageElement spritesheet;
  static ImageElement imgFloor;
  static ImageElement imgArmchair;
  static ImageElement imgChair;
  static ImageElement imgBookshelve;
  static ImageElement imgBedHead;
  static ImageElement imgBedFeet;
  static ImageElement imgDeskLeft;
  static ImageElement imgDeskRightBefore;
  static ImageElement imgDeskRightAfter;
  static ImageElement imgCupboardLeft;
  static ImageElement imgCupboardRight;
  static ImageElement imgDishBefore;
  static ImageElement imgDishAfter;
  static ImageElement imgWeedBefore;
  static ImageElement imgWeedAfter;
  static ImageElement imgPlant;
  static ImageElement imgTV;
  static ImageElement imgDoor;
  static ImageElement imgWallLeft;
  static ImageElement imgWallTop;
  static ImageElement imgWallRight;
  static ImageElement imgWallBottom;
  static ImageElement imgWallEdge1;
  static ImageElement imgWallEdge2;
  static ImageElement imgWallEdge3;
  static ImageElement imgWallEdge4;
  static ImageElement imgWallToToiletLeft;
  static ImageElement imgWallToToiletRight;
  static ImageElement imgToilet;
  static ImageElement imgSocket;
  static ImageElement imgPhone;
  static ImageElement imgMessage;
  static Map<String, AudioElement> sounds;

  static void load() {
    //spritesheet = new ImageElement(src: 'res/spritesheet.png');
    imgFloor = new ImageElement(src: 'res/floor.png');
    imgArmchair = new ImageElement(src: 'res/armchair.png');
    imgChair = new ImageElement(src: 'res/chair.png');
    imgBookshelve = new ImageElement(src: 'res/bookshelve.png');
    imgBedHead = new ImageElement(src: 'res/bedHead.png');
    imgBedFeet = new ImageElement(src: 'res/bedFeet.png');
    imgDeskLeft = new ImageElement(src: 'res/deskLeft.png');
    imgDeskRightBefore = new ImageElement(src: 'res/deskRightBefore.png');
    imgDeskRightAfter = new ImageElement(src: 'res/deskRightAfter.png');
    imgCupboardLeft = new ImageElement(src: 'res/cupboardLeft.png');
    imgCupboardRight = new ImageElement(src: 'res/cupboardRight.png');
    imgDishBefore = new ImageElement(src: 'res/dishBefore.png');
    imgDishAfter = new ImageElement(src: 'res/dishAfter.png');
    imgWeedBefore = new ImageElement(src: 'res/weedBefore.png');
    imgWeedAfter = new ImageElement(src: 'res/weedAfter.png');
    imgPlant = new ImageElement(src: 'res/plant.png');
    imgTV = new ImageElement(src: 'res/tv.png');
    imgDoor = new ImageElement(src: 'res/door.png');
    imgWallLeft = new ImageElement(src: 'res/wallSimpleLeft.png');
    imgWallTop = new ImageElement(src: 'res/wallSimpleTop.png');
    imgWallRight = new ImageElement(src: 'res/wallSimpleRight.png');
    imgWallBottom = new ImageElement(src: 'res/wallSimpleBottom.png');
    imgWallEdge1 = new ImageElement(src: 'res/wallEdge1.png');
    imgWallEdge2 = new ImageElement(src: 'res/wallEdge2.png');
    imgWallEdge3 = new ImageElement(src: 'res/wallEdge3.png');
    imgWallEdge4 = new ImageElement(src: 'res/wallEdge4.png');
    imgWallToToiletLeft = new ImageElement(src: 'res/wallToToiletLeft.png');
    imgWallToToiletRight = new ImageElement(src: 'res/wallToToiletRight.png');
    imgToilet = new ImageElement(src: 'res/toilet.png');
    imgSocket = new ImageElement(src: 'res/socket.png');
    imgPhone = new ImageElement(src: 'res/phone.png');
    imgMessage = new ImageElement(src: 'res/message.png');
    sounds = new Map<String, AudioElement>();
    sounds['scribble'] = new AudioElement('res/scribble.wav');
    sounds['cough'] = new AudioElement('res/cough.wav');
    sounds['doorbell'] = new AudioElement('res/doorbell.wav');
    sounds['water'] = new AudioElement('res/water.wav');
    sounds['crisp'] = new AudioElement('res/crisp.wav');
    sounds['tv'] = new AudioElement('res/tv.wav');
    sounds['ringtone'] = new AudioElement('res/ringtone.wav');
    sounds['ticking'] = new AudioElement('res/ticking.wav');
    sounds['momPhone'] = new AudioElement('res/momPhone.wav');
    sounds['momHappy'] = new AudioElement('res/momHappy.wav');
    sounds['momAngry'] = new AudioElement('res/momAngry.wav');
  }

}