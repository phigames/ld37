part of ld37;

abstract class Tile {

  static const num WIDTH = 100;
  static const num HEIGHT = 100;

  int positionX, positionY;
  TileGroup group;
  //num spriteX, spriteY;
  ImageElement image;

  Tile(this.positionX, this.positionY, [this.group]);

  bool canMoveTo(int positionX, int positionY);

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
        if (!tiles.contains(targetTile) && !tiles[i].canMoveTo(targetX, targetY)) {
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

  bool canMoveTo(int positionX, int positionY) {
    return room.tiles[positionX][positionY] == null;
  }

  void drawOnTop() {

  }

}

class TileChair extends Tile {

  TileChair(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgChair;
  }

  bool canMoveTo(int positionX, int positionY) {
    return room.tiles[positionX][positionY] == null;
  }

  void drawOnTop() {

  }

}

class TileBookshelve extends Tile {

  TileBookshelve(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgBookshelve;
  }

  bool canMoveTo(int positionX, int positionY) {
    return room.tiles[positionX][positionY] == null;
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

  bool canMoveTo(int positionX, int positionY) {
    return room.tiles[positionX][positionY] == null;
  }

  void drawOnTop() {

  }

}

class TileDesk extends Tile {
  int part;
  int dishMode = 0;
  bool homeworkDone;

  TileDesk(int positionX, int positionY, TileGroup group, this.part) : super(positionX, positionY, group) {
    group.add(this);
    if (part == 1) {
      image = Resources.imgDeskLeft;
    } else if (part == 2) {
      image = Resources.imgDeskRight;
    }
  }

  bool canMoveTo(int positionX, int positionY) {
    Tile targetTile = room.tiles[positionX][positionY];
    if (dishMode != 0 && part == 1 && targetTile == null) {
      dishMode = 0;
      room.tiles[targetTile.positionX][targetTile.positionY] = new TileDish(targetTile.positionX, targetTile.positionY);
      return false;
    }
    return targetTile == null;
  }

  void drawOnTop() {
    if (dishMode == 1) {
      bufferContext.drawImage(Resources.imgDishBefore, positionX * Tile.WIDTH, positionY * Tile.HEIGHT);
    } else if (dishMode == 2) {
      bufferContext.drawImage(Resources.imgDishAfter, positionX * Tile.WIDTH, positionY * Tile.HEIGHT);
    }
  }

}

class TileCupboard extends Tile {

  TileCupboard(int positionX, int positionY, TileGroup group, int part) : super(positionX, positionY, group) {
    group.add(this);
    if (part == 1) {
      image = Resources.imgCupboardLeft;
    } else if (part == 2) {
      image = Resources.imgCupboardRight;
    }
  }

  bool canMoveTo(int positionX, int positionY) {
    return room.tiles[positionX][positionY] == null;
  }

  void drawOnTop() {

  }

}

class TileDish extends Tile {

  TileDish(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgDishBefore;
  }

  bool canMoveTo(int positionX, int positionY) {
    Tile targetTile = room.tiles[positionX][positionY];
    if (targetTile is TileDesk && targetTile.part == 1) {
      room.tiles[positionX][positionY] = null;
      targetTile.dishMode = 1;
      return false;
    }
    return targetTile == null;
  }

  void drawOnTop() {

  }

}

class TilePlant extends Tile {

  TilePlant(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgPlant;
  }

  bool canMoveTo(int positionX, int positionY) {
    return room.tiles[positionX][positionY] == null;
  }

  void drawOnTop() {

  }

}

class TileDoor extends Tile {

  TileDoor(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgDoor;
  }


  bool canMoveTo(int positionX, int positionY) {
    return room.tiles[positionX][positionY] == null;
  }

  void drawOnTop() {

  }

}

class TileWall extends Tile {

  TileWall(int positionX, int positionY, int type) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    switch (type) {
      case 1:
        image = Resources.imgWallLeft;
        break;
      case 2:
        image = Resources.imgWallTop;
        break;
      case 3:
        image = Resources.imgWallRight;
        break;
      case 4:
        image = Resources.imgWallBottom;
        break;
      case 5:
        image = Resources.imgWallEdge1;
        break;
      case 6:
        image = Resources.imgWallEdge2;
        break;
      case 7:
        image = Resources.imgWallEdge3;
        break;
      case 8:
        image = Resources.imgWallEdge4;
        break;
    }
  }

  bool canMoveTo(int positionX, int positionY) {
    return room.tiles[positionX][positionY] == null;
  }

  void drawOnTop() {

  }

}

class TileToilet extends Tile {

  TileToilet(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgToilet;
  }

  bool canMoveTo(int positionX, int positionY) {
    return room.tiles[positionX][positionY] == null;
  }

  void drawOnTop() {

  }

}

class TileSocket extends Tile {

  TileSocket(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgSocket;
  }

  bool canMoveTo(int positionX, int positionY) {
    return room.tiles[positionX][positionY] == null;
  }

  void drawOnTop() {

  }

}

class TilePhone extends Tile {

  TilePhone(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    image = Resources.imgPhone;
  }

  bool canMoveTo(int positionX, int positionY) {
    return room.tiles[positionX][positionY] == null;
  }

  void drawOnTop() {

  }

}