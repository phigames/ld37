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
    tiles[1][2] = new TileBookshelve(1, 2);
    tiles[3][1] = new TileBed.Head(3, 1);
    tiles[3][2] = new TileBed.Feet(3, 2, tiles[3][1]);
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
        if (((highlightX - selectedTile.positionX).abs() == 0 && (highlightY - selectedTile.positionY).abs() == 1) ||
            ((highlightX - selectedTile.positionX).abs() == 1 && (highlightY - selectedTile.positionY).abs() == 0)) {
          selectedTile.move(highlightX, highlightY);
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