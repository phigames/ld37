part of ld37;

class Room {

  static const int WIDTH = 7;
  static const int HEIGHT = 5;

  List<List<Tile>> tiles;
  int highlightX, highlightY;
  Tile selectedTile;

  Room() {
    tiles = new List<List<Tile>>();
    for (int i = 0; i < WIDTH; i++) {
      tiles.add(new List<Tile>());
      for (int j = 0; j < HEIGHT; j++) {
        tiles[i].add(null);
      }
    }
    tiles[2][0] = new TileDoor(2, 0);
    TileGroup bed = new TileGroup();
    tiles[1][1] = new TileBed(1, 1, bed, 1);
    tiles[1][2] = new TileBed(1, 2, bed, 2);
    TileGroup desk = new TileGroup();
    tiles[4][1] = new TileDesk(4, 1, desk, 1);
    tiles[4][2] = new TileBed(4, 2, desk, 2);
    tiles[5][1] = new TileDish(5, 1);
    //tiles[5][2] = new TileWeed(5, 2);
    tiles[6][2] = new TileToilet(6, 2);
    //tiles[0][3] = new TileSocket(0, 3);
    tiles[1][3] = new TileChair(1, 3);
    tiles[5][3] = new TileBookshelve(5, 3);
    highlightX = 0;
    highlightY = 0;
  }

  void update(num deltaTime) {
    highlightX = Input.mouseX ~/ Tile.WIDTH;
    if (highlightX < 0) {
      highlightX = 0;
    } else if (highlightX >= Room.WIDTH) {
      highlightX = Room.WIDTH - 1;
    }
    highlightY = Input.mouseY ~/ Tile.HEIGHT;
    if (highlightY < 0) {
      highlightY = 0;
    } else if (highlightY >= Room.HEIGHT) {
      highlightY = Room.HEIGHT - 1;
    }
    if (selectedTile == null) {
      if (Input.mouseDown) {
        selectedTile = tiles[highlightX][highlightY];
      }
    } else {
      if (Input.mouseDown) {
        int moveX = highlightX - selectedTile.positionX;
        int moveY = highlightY - selectedTile.positionY;
        if ((moveX.abs() == 1 && moveY.abs() == 0) || (moveX.abs() == 0 && moveY.abs() == 1)) {
          selectedTile.move(moveX, moveY);
        }
      } else {
        selectedTile = null;
      }
    }
  }

  void draw() {
    for (int i = 0; i < WIDTH; i++) {
      for (int j = 0; j < HEIGHT; j++) {
        bufferContext.drawImage(Resources.imgFloor, i * Tile.WIDTH, j * Tile.HEIGHT);
        if (tiles[i][j] != null) {
          tiles[i][j].draw();
        }
      }
    }
    bufferContext.globalAlpha = 0.2;
    bufferContext.fillStyle = '#FFFFFF';
    bufferContext.fillRect(highlightX * Tile.WIDTH, highlightY * Tile.HEIGHT, Tile.WIDTH, Tile.HEIGHT);
    bufferContext.globalAlpha = 1;
  }

}