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

  void draw() {
    bufferContext.drawImage(image, positionX * Tile.WIDTH, positionY * Tile.HEIGHT);
    drawOnTop();
  }

  void drawOnTop();

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

  void drawOnTop() {

  }

}

class TileBed extends Tile {

  TileBed.Head(int positionX, int positionY, [Tile feetTile]) : super(positionX, positionY) {
    if (feetTile != null) {
      partnerTile = feetTile;
      partnerTile.partnerTile = this;
    }
    image = Resources.imgBedHead;
  }

  TileBed.Feet(int positionX, int positionY, [Tile headTile]) : super(positionX, positionY) {
    if (headTile != null) {
      partnerTile = headTile;
      partnerTile.partnerTile = this;
    }
    image = Resources.imgBedFeet;
  }

  void move(int targetX, int targetY) {
    int partnerTargetX = targetX - positionX + partnerTile.positionX;
    int partnerTargetY = targetY - positionY + partnerTile.positionY;
    print('$targetX, $targetY,    $partnerTargetX, $partnerTargetY');
    if ((room.tiles[targetX][targetY] == null || room.tiles[targetX][targetY] == partnerTile) &&
        (room.tiles[partnerTargetX][partnerTargetY] == null || room.tiles[partnerTargetX][partnerTargetY] == this)) {
      if (targetX == partnerTile.positionX && targetY == partnerTile.positionY) {
        room.tiles[partnerTile.positionX][partnerTile.positionY] = null;
        room.tiles[partnerTargetX][partnerTargetY] = partnerTile;
        partnerTile.positionX = partnerTargetX;
        partnerTile.positionY = partnerTargetY;
        room.tiles[positionX][positionY] = null;
        room.tiles[targetX][targetY] = this;
        positionX = targetX;
        positionY = targetY;
      } else {
        room.tiles[positionX][positionY] = null;
        room.tiles[targetX][targetY] = this;
        positionX = targetX;
        positionY = targetY;
        room.tiles[partnerTile.positionX][partnerTile.positionY] = null;
        room.tiles[partnerTargetX][partnerTargetY] = partnerTile;
        partnerTile.positionX = partnerTargetX;
        partnerTile.positionY = partnerTargetY;
      }
    }
  }

  void drawOnTop() {

  }

}