part of ld37;

abstract class Tile {

  static const num WIDTH = 100;
  static const num HEIGHT = 100;

  int positionX, positionY;
  TileGroup group;
  //num spriteX, spriteY;
  ImageElement image;

  Tile(this.positionX, this.positionY, [this.group]);

  bool canMoveTo(Tile tile);

  void move(int moveX, moveY) {
    group.move(moveX, moveY);
  }

  void draw() {
    //bufferContext.drawImageScaledFromSource(Resources.spritesheet, spriteX * Tile.WIDTH, spriteY * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT,
    //                                                               positionX * Tile.WIDTH, positionY * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT);
    bufferContext.drawImage(image, positionX * Tile.WIDTH, positionY * Tile.HEIGHT);
    drawOnTop();
  }

  void drawOnTop();

}

class TileGroup {

  List<Tile> tiles;

  TileGroup() {
    tiles = new List<Tile>();
  }

  void add(Tile tile) {
    tiles.add(tile);
  }

  void move(int moveX, int moveY) {
    bool moveable = true;
    for (int i = 0; i < tiles.length; i++) {
      int targetX = tiles[i].positionX + moveX;
      int targetY = tiles[i].positionY + moveY;
      if (targetX < 0 || targetX >= Room.WIDTH || targetY < 0 || targetY >= Room.HEIGHT) {
        moveable = false;
      } else {
        Tile targetTile = room.tiles[targetX][targetY];
        if (!tiles.contains(targetTile) && !tiles[i].canMoveTo(targetTile)) {
          moveable = false;
        }
      }
    }
    if (moveable) {
      for (int i = 0; i < tiles.length; i++) {
        room.tiles[tiles[i].positionX][tiles[i].positionY] = null;
      }
      for (int i = 0; i < tiles.length; i++) {
        room.tiles[tiles[i].positionX + moveX][tiles[i].positionY + moveY] = tiles[i];
        tiles[i].positionX += moveX;
        tiles[i].positionY += moveY;
      }
    }
  }

}

class TileArmchair extends Tile {

  TileArmchair(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgArmchair;
  }

  bool canMoveTo(Tile tile) {
    return tile == null;
  }

  void drawOnTop() {

  }

}

class TileChair extends Tile {

  TileChair(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgChair;
  }

  bool canMoveTo(Tile tile) {
    return tile == null;
  }

  void drawOnTop() {

  }

}

class TileBookshelve extends Tile {

  TileBookshelve(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgBookshelve;
  }

  bool canMoveTo(Tile tile) {
    return tile == null;
  }

  void drawOnTop() {

  }

}

class TileBed extends Tile {

  TileBed(int positionX, int positionY, TileGroup group, int part) : super(positionX, positionY, group) {
    group.add(this);
    if (part == 1) {
      image = Resources.imgBedHead;
    } else if (part == 2) {
      image = Resources.imgBedFeet;
    }
  }

  bool canMoveTo(Tile tile) {
    return tile == null;
  }

  void drawOnTop() {

  }

}

class TileDesk extends Tile {

  TileDesk(int positionX, int positionY, TileGroup group, int part) : super(positionX, positionY, group) {
    group.add(this);
    if (part == 1) {
      image = Resources.imgDeskLeft;
    } else if (part == 2) {
      image = Resources.imgDeskRight;
    }
  }

  bool canMoveTo(Tile tile) {
    return tile == null;
  }

  void drawOnTop() {

  }

}

class TileDish extends Tile {

  TileDish(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgDishBefore;
  }

  bool canMoveTo(Tile tile) {
    return tile == null;
  }

  void drawOnTop() {

  }

}

class TilePlant extends Tile {

  TilePlant(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgPlant;
  }

  bool canMoveTo(Tile tile) {
    return tile == null;
  }

  void drawOnTop() {

  }

}

class TileDoor extends Tile {

  TileDoor(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgDoor;
  }

  bool canMoveTo(Tile tile) {
    return false;
  }

  void drawOnTop() {

  }

}

class TileToilet extends Tile {

  TileToilet(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgToilet;
  }

  bool canMoveTo(Tile tile) {
    return false;
  }

  void drawOnTop() {

  }

}