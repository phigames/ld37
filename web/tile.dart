part of ld37;

abstract class Tile {

  static const num WIDTH = 100;
  static const num HEIGHT = 100;

  int positionX, positionY;
  TileGroup group;
  num spriteX, spriteY;

  Tile(this.positionX, this.positionY, [this.group]);

  bool canMoveTo(int positionX, int positionY);

  void move(int moveX, moveY) {
    group.move(moveX, moveY);
  }

  void draw() {
    bufferContext.drawImageScaledFromSource(Resources.spritesheet, spriteX * Tile.WIDTH, spriteY * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT,
                                                                   positionX * Tile.WIDTH, positionY * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT);
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
    spriteX = 4;
    spriteY = 2;
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
    spriteX = 2;
    spriteY = 0;
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
    spriteX = 1;
    spriteY = 0;
  }

  bool canMoveTo(int positionX, int positionY) {
    return room.tiles[positionX][positionY] == null;
  }

  void drawOnTop() {

  }

}

class TileBed extends Tile {

  int part;
  int weedMode = 0;

  TileBed(int positionX, int positionY, TileGroup group, this.part) : super(positionX, positionY, group) {
    group.add(this);
    if (part == 1) {
      spriteX = 1;
      spriteY = 1;
    } else if (part == 2) {
      spriteX = 1;
      spriteY = 2;
    }
  }

  bool canMoveTo(int targetX, int targetY) {
    Tile targetTile = room.tiles[targetX][targetY];
    if (weedMode != 0 && targetTile == null && room.selectedTile == this) {
      room.tiles[targetX][targetY] = new TileWeed(targetX, targetY, weedMode == 2);
      weedMode = 0;
      room.selectedTile = room.tiles[targetX][targetY];
      return false;
    }
    return targetTile == null;
  }

  void drawOnTop() {
    if (weedMode == 1) {
      bufferContext.drawImageScaledFromSource(Resources.spritesheet, 3 * Tile.WIDTH, 1 * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT,
                                                                     positionX * Tile.WIDTH, positionY * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT);
    } else if (weedMode == 2) {
      bufferContext.drawImageScaledFromSource(Resources.spritesheet, 3 * Tile.WIDTH, 2 * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT,
                                                                     positionX * Tile.WIDTH, positionY * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT);
    }
  }

}

class TileDesk extends Tile {

  int part;
  int dishMode = 0;
  bool homeworkDone;

  TileDesk(int positionX, int positionY, TileGroup group, this.part) : super(positionX, positionY, group) {
    group.add(this);
    if (part == 1) {
      spriteX = 3;
      spriteY = 0;
    } else if (part == 2) {
      spriteX = 4;
      spriteY = 0;
    }
    homeworkDone = false;
  }

  bool canMoveTo(int targetX, int targetY) {
    Tile targetTile = room.tiles[targetX][targetY];
    if (dishMode != 0 && part == 1 && targetTile == null && room.selectedTile == this) {
      room.tiles[targetX][targetY] = new TileDish(targetX, targetY, dishMode == 2);
      dishMode = 0;
      room.selectedTile = room.tiles[targetX][targetY];
      return false;
    }
    return targetTile == null;
  }

  void drawOnTop() {
    if (dishMode == 1) {
      bufferContext.drawImageScaledFromSource(Resources.spritesheet, 2 * Tile.WIDTH, 1 * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT,
                                                                     positionX * Tile.WIDTH, positionY * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT);
    } else if (dishMode == 2) {
      bufferContext.drawImageScaledFromSource(Resources.spritesheet, 2 * Tile.WIDTH, 2 * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT,
                                                                     positionX * Tile.WIDTH, positionY * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT);
    }
  }

}

class TileCupboard extends Tile {

  TileCupboard(int positionX, int positionY, TileGroup group, int part) : super(positionX, positionY, group) {
    group.add(this);
    if (part == 1) {
      spriteX = 0;
      spriteY = 1;
    } else if (part == 2) {
      spriteX = 0;
      spriteY = 2;
    }
  }

  bool canMoveTo(int positionX, int positionY) {
    return room.tiles[positionX][positionY] == null;
  }

  void drawOnTop() {

  }

}

class TileDish extends Tile {

  int mode;

  TileDish(int positionX, int positionY, bool used) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    if (!used) {
      spriteX = 2;
      spriteY = 1;
      mode = 1;
    } else {
      spriteX = 2;
      spriteY = 2;
      mode = 2;
    }
  }

  bool canMoveTo(int targetX, int targetY) {
    Tile targetTile = room.tiles[targetX][targetY];
    if (targetTile is TileDesk && targetTile.part == 1) {
      room.tiles[positionX][positionY] = null;
      targetTile.dishMode = mode;
      room.selectedTile = null;
      return false;
    }
    return targetTile == null;
  }

  void drawOnTop() {

  }

}

class TileWeed extends Tile {

  int mode;

  TileWeed(int positionX, int positionY, bool used) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    if (!used) {
      spriteX = 3;
      spriteY = 1;
      mode = 1;
    } else {
      spriteX = 3;
      spriteY = 2;
      mode = 2;
    }
  }

  bool canMoveTo(int targetX, int targetY) {
    Tile targetTile = room.tiles[targetX][targetY];
    if (targetTile is TileBed) {
      room.tiles[positionX][positionY] = null;
      targetTile.weedMode = mode;
      room.selectedTile = null;
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
    spriteX = 4;
    spriteY = 1;
  }

  bool canMoveTo(int targetX, int targetY) {
    Tile targetTile = room.tiles[targetX][targetY];
    if (targetTile is TileToilet) {
      room.tiles[positionX][positionY] = null;
      targetTile.plantMode = 1;
      room.selectedTile = null;
      return false;
    }
    return targetTile == null;
  }

  void drawOnTop() {

  }

}

class TileTV extends Tile {

  TileTV(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    spriteX = 5;
    spriteY = 1;
  }

  bool canMoveTo(int targetX, int targetY) {
    Tile targetTile = room.tiles[targetX][targetY];
    return targetTile == null;
  }

  void drawOnTop() {

  }

}

class TileDoor extends Tile {

  TileDoor(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    spriteX = 0;
    spriteY = 4;
  }


  bool canMoveTo(int positionX, int positionY) {
    return false;
  }

  void drawOnTop() {

  }

}

class TileWall extends Tile {

  TileWall(int positionX, int positionY, int type) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    switch (type) {
      case 1:
        spriteX = 0;
        spriteY = 3;
        break;
      case 2:
        spriteX = 1;
        spriteY = 3;
        break;
      case 3:
        spriteX = 2;
        spriteY = 3;
        break;
      case 4:
        spriteX = 3;
        spriteY = 3;
        break;
      case 5:
        spriteX = 4;
        spriteY = 3;
        break;
      case 6:
        spriteX = 5;
        spriteY = 3;
        break;
      case 7:
        spriteX = 5;
        spriteY = 4;
        break;
      case 8:
        spriteX = 4;
        spriteY = 4;
        break;
      case 9:
        spriteX = 6;
        spriteY = 4;
        break;
      case 10:
        spriteX = 7;
        spriteY = 4;
        break;
    }
  }

  bool canMoveTo(int positionX, int positionY) {
    return false;
  }

  void drawOnTop() {

  }

}

class TileToilet extends Tile {
  int plantMode = 0; // 0: no plant on toilet, 1: plant on toilet

  TileToilet(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    spriteX = 3;
    spriteY = 4;
  }

  bool canMoveTo(int targetX, int targetY) {
    Tile targetTile = room.tiles[targetX][targetY];
    if (plantMode != 0 && targetTile == null && room.selectedTile == this) {
      plantMode = 0;
      room.tiles[targetX][targetY] = new TilePlant(targetX, targetY);
      room.selectedTile = room.tiles[targetX][targetY];
      return false;
    }
    return false;
  }

  void drawOnTop() {
    if (plantMode == 1) {
      bufferContext.drawImageScaledFromSource(Resources.spritesheet, 4 * Tile.WIDTH, 1 * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT,
                                                                     positionX * Tile.WIDTH, positionY * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT);
    }
  }
}

class TileSocket extends Tile {

  TileSocket(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    spriteX = 2;
    spriteY = 4;
  }

  bool canMoveTo(int positionX, int positionY) {
    return false;
  }

  void drawOnTop() {

  }

}

class TilePhone extends Tile {

  TilePhone(int positionX, int positionY) : super(positionX, positionY) {
    group = new TileGroup()..add(this);
    spriteX = 1;
    spriteY = 4;
  }

  bool canMoveTo(int positionX, int positionY) {
    return false;
  }

  void drawOnTop() {

  }

}