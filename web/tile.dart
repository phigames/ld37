part of ld37;

abstract class Tile {

  static const num WIDTH = 100;
  static const num HEIGHT = 100;

  int positionX, positionY;
  Tile partnerTile;
  //num spriteX, spriteY;
  ImageElement image;

  Tile(this.positionX, this.positionY);

  void move(int targetX, int targetY);

}

class TileBookshelve extends Tile {

  TileBookshelve(int positionX, int positionY) : super(positionX, positionY) {
    image = Resources.imgBookshelve;
  }

  void move(int targetX, int targetY) {
    if (room.tiles[targetX][targetY] == null) {
      room.tiles[positionX][positionY] = null;
      room.tiles[targetX][targetY] = this;
      positionX = targetX;
      positionY = targetY;
    }
  }

}

class TileBed extends Tile {

  TileBed.Head(int positionX, int positionY) : super(positionX, positionY) {
    image = Resources.imgBookshelve;
  }

  void move(int targetX, int targetY) {
    if (room.tiles[targetX][targetY] == null) {
      room.tiles[positionX][positionY] = null;
      room.tiles[targetX][targetY] = this;
      positionX = targetX;
      positionY = targetY;
    }
  }

}