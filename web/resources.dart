part of ld37;

class Resources {

  static ImageElement imgFloor;
  static ImageElement imgBookshelve;

  static void load() {
    imgFloor = new ImageElement(src: 'res/floor.png');
    imgBookshelve = new ImageElement(src: 'res/bookshelve.png');

  }

}