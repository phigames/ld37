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
  static ImageElement imgDishBefore;
  static ImageElement imgDishAfter;
  static ImageElement imgPlant;
  static ImageElement imgDoor;
  static ImageElement imgToilet;

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
    imgDishBefore = new ImageElement(src: 'res/dishBefore.png');
    imgDishAfter = new ImageElement(src: 'res/dishAfter.png');
    imgPlant = new ImageElement(src: 'res/plant.png');
    imgDoor = new ImageElement(src: 'res/door.png');
    imgToilet = new ImageElement(src: 'res/toilet.png');
  }

}