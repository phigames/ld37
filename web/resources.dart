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
  static ImageElement imgDeskRight;
  static ImageElement imgCupboardLeft;
  static ImageElement imgCupboardRight;
  static ImageElement imgDishBefore;
  static ImageElement imgDishAfter;
  static ImageElement imgPlant;
  static ImageElement imgDoor;
  static ImageElement imgWallLeft;
  static ImageElement imgWallTop;
  static ImageElement imgWallRight;
  static ImageElement imgWallBottom;
  static ImageElement imgWallEdge1;
  static ImageElement imgWallEdge2;
  static ImageElement imgWallEdge3;
  static ImageElement imgWallEdge4;
  static ImageElement imgToilet;
  static ImageElement imgSocket;
  static ImageElement imgPhone;

  static void load() {
    //spritesheet = new ImageElement(src: 'res/spritesheet.png');
    imgFloor = new ImageElement(src: 'res/floor.png');
    imgArmchair = new ImageElement(src: 'res/armchair.png');
    imgChair = new ImageElement(src: 'res/chair.png');
    imgBookshelve = new ImageElement(src: 'res/bookshelve.png');
    imgBedHead = new ImageElement(src: 'res/bedHead.png');
    imgBedFeet = new ImageElement(src: 'res/bedFeet.png');
    imgDeskLeft = new ImageElement(src: 'res/deskLeft.png');
    imgDeskRight = new ImageElement(src: 'res/deskRight.png');
    imgCupboardLeft = new ImageElement(src: 'res/cupboardLeft.png');
    imgCupboardRight = new ImageElement(src: 'res/cupboardRight.png');
    imgDishBefore = new ImageElement(src: 'res/dishBefore.png');
    imgDishAfter = new ImageElement(src: 'res/dishAfter.png');
    imgPlant = new ImageElement(src: 'res/plant.png');
    imgDoor = new ImageElement(src: 'res/door.png');
    imgWallLeft = new ImageElement(src: 'res/wallSimpleLeft.png');
    imgWallTop = new ImageElement(src: 'res/wallSimpleTop.png');
    imgWallRight = new ImageElement(src: 'res/wallSimpleRight.png');
    imgWallBottom = new ImageElement(src: 'res/wallSimpleBottom.png');
    imgWallEdge1 = new ImageElement(src: 'res/wallEdge1.png');
    imgWallEdge2 = new ImageElement(src: 'res/wallEdge2.png');
    imgWallEdge3 = new ImageElement(src: 'res/wallEdge3.png');
    imgWallEdge4 = new ImageElement(src: 'res/wallEdge4.png');
    imgToilet = new ImageElement(src: 'res/toilet.png');
    imgSocket = new ImageElement(src: 'res/socket.png');
    imgPhone = new ImageElement(src: 'res/phone.png');
  }

}