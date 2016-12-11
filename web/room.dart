part of ld37;

class Room {

  static const int WIDTH = 7;
  static const int HEIGHT = 5;

  List<List<Tile>> tiles;
  int highlightX, highlightY;
  Tile selectedTile;
  TaskHandler taskHandler;

  Room() {
    tiles = new List<List<Tile>>();
    for (int i = 0; i < WIDTH; i++) {
      tiles.add(new List<Tile>());
      for (int j = 0; j < HEIGHT; j++) {
        tiles[i].add(null);
      }
    }
    tiles[0][1] = new TileWall(0, 1, 1);
    tiles[0][2] = new TileWall(0, 2, 1);
    tiles[1][0] = new TileWall(1, 0, 2);
    tiles[3][0] = new TileWall(3, 0, 2);
    tiles[4][0] = new TileWall(4, 0, 2);
    tiles[5][0] = new TileWall(5, 0, 2);
    tiles[6][1] = new TileWall(6, 1, 3);
    tiles[6][3] = new TileWall(6, 3, 3);
    tiles[2][4] = new TileWall(2, 4, 4);
    tiles[3][4] = new TileWall(3, 4, 4);
    tiles[4][4] = new TileWall(4, 4, 4);
    tiles[5][4] = new TileWall(5, 4, 4);
    tiles[0][0] = new TileWall(0, 0, 5);
    tiles[6][0] = new TileWall(6, 0, 6);
    tiles[6][4] = new TileWall(6, 4, 7);
    tiles[0][4] = new TileWall(0, 4, 8);
    tiles[2][0] = new TileDoor(2, 0);
    TileGroup bed = new TileGroup();
    tiles[1][1] = new TileBed(1, 1, bed, 1);
    tiles[1][2] = new TileBed(1, 2, bed, 2);
    TileGroup cupboard = new TileGroup();
    tiles[4][1] = new TileCupboard(4, 1, cupboard, 1);
    tiles[4][2] = new TileCupboard(4, 2, cupboard, 2);
    tiles[5][1] = new TileDish(5, 1);
    //tiles[5][2] = new TileWeed(5, 2);
    tiles[6][2] = new TileToilet(6, 2);
    tiles[0][3] = new TileSocket(0, 3);
    tiles[1][3] = new TileChair(1, 3);
    TileGroup desk = new TileGroup();
    tiles[2][3] = new TileDesk(2, 3, desk, 1);
    tiles[3][3] = new TileDesk(3, 3, desk, 2);
    tiles[5][3] = new TileBookshelve(5, 3);
    tiles[1][4] = new TilePhone(1, 4);
    highlightX = 0;
    highlightY = 0;
    taskHandler = new TaskHandler();
  }

  void update(num deltaTime) {
    taskHandler.update(deltaTime);
    if (taskHandler.taskState == 1) {
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
          taskHandler.check();
        }
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
    taskHandler.draw();
  }

}