part of ld37;

class Room {

  static const int WIDTH = 7;
  static const int HEIGHT = 5;

  List<List<Tile>> tiles;

  Room() {
    tiles = new List<List<Tile>>();
    for (int i = 0; i < WIDTH; i++) {
      tiles.add(new List<Tile>());
      for (int j = 0; j < HEIGHT; j++) {
        tiles[i].add(null);
      }
    }
  }

  void update(num deltaTime) {

  }

  void draw() {
    for (int i = 0; i < WIDTH; i++) {
      for (int j = 0; j < HEIGHT; j++) {
        if (tiles[i][j] == null) {
          bufferContext.drawImage(Resources.imgFloor, i * Tile.WIDTH, j * Tile.HEIGHT);
        }
      }
    }
  }

}