part of ld37;

class Resources {

  static ImageElement imgFloor;
  static ImageElement imgBookshelve;
  static ImageElement imgBedHead;
  static ImageElement imgBedFeet;

  static void load() {
    imgFloor = new ImageElement(src: 'res/floor.png');
    imgBookshelve = new ImageElement(src: 'res/bookshelve.png');
    imgBedHead = new ImageElement(src: 'res/bedHead.png');
    imgBedFeet = new ImageElement(src: 'res/bedFeet.png');
  }

}