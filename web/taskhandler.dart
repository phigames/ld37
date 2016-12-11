part of ld37;

class TaskHandler {

  static const num MESSAGE_X = 225;
  static const num MESSAGE_Y = 75;
  static const num OK_X = MESSAGE_X + 183;
  static const num OK_Y = MESSAGE_Y + 303;
  static const num OK_WIDTH = 54;
  static const num OK_HEIGHT = 34;

  int task;
  int taskState;
  List<List<String>> messageTexts;
  Tile tempTile;
  num waitTime;

  TaskHandler() {
    task = 0;
    taskState = 0;
    messageTexts = [ [ 'Do your', 'homework!' ],
                     [ 'Time to', 'roll a spliff.' ],
                     [ 'Sounds like someone\'s at the door.' ],
                     [ 'Take this plant. Don\'t forget to water it. Love, mom.' ],
                     [ '*stomach grumble*' ],
                     [ 'Let\'s see what\'s on TV.' ],
                     null,
                     [ 'See you in 20 seconds. Better tidy up your room first.' ] ];
    waitTime = 0;
  }

  void check() {
    if (task == 0) {
      for (int i = 0; i < Room.WIDTH; i++) {
        for (int j = 0; j < Room.HEIGHT; j++) {
          if (room.tiles[i][j] is TileDesk && (room.tiles[i][j] as TileDesk).part == 2 && room.tiles[i][j - 1] is TileChair) {
            taskState = 2;
            tempTile = room.tiles[i][j];
            waitTime = 2000;
            //play SFX
          }
        }
      }
    } else if (task == 1) {
      for (int i = 0; i < Room.WIDTH; i++) {
        for (int j = 0; j < Room.HEIGHT; j++) {
          if (room.tiles[i][j] is TileBed && (room.tiles[i][j] as TileBed).weedMode == 1) {
            taskState = 2;
            tempTile = room.tiles[i][j];
            waitTime = 2000;
            //play SFX
          }
        }
      }
    } else if (task == 2) {
      if (room.tiles[2][1] == null) {
        taskState = 2;
        tempTile = room.tiles[2][1];
        waitTime = 1000;
        //play SFX
      }
    }
  }

  void update(num deltaTime) {
    if (taskState == 0) {
      // message is being shown
      if (Input.mouseDown &&
          Input.mouseX > OK_X && Input.mouseX < OK_X + OK_WIDTH &&
          Input.mouseY > OK_Y && Input.mouseY < OK_Y + OK_HEIGHT) {
        taskState = 1;
      }
    } else if (taskState == 2) {
      // task is done, play animation and go to next task
      if (task == 0) {
        if (waitTime <= 1000) {
          (tempTile as TileDesk).homeworkDone = true;
        }
      } else if (task == 1) {
        if (waitTime <= 1000) {
          (tempTile as TileBed).weedMode = 2;
        }
      } else if (task == 3) {

      } else if (task == 4) {

      } else if (task == 5) {

      } else if (task == 6) {

      }
      waitTime -= deltaTime;
      if (waitTime <= 0) {
        task++;
        taskState = 0;
        // animation is done, start next task
        if (task == 2) {

        }
      }
    }
  }

  void draw() {
    if (taskState == 0) {
      bufferContext.drawImage(Resources.imgMessage, 225, 75);
      if (Input.mouseX > OK_X && Input.mouseX < OK_X + OK_WIDTH &&
          Input.mouseY > OK_Y && Input.mouseY < OK_Y + OK_HEIGHT) {
        bufferContext.globalAlpha = 0.2;
        bufferContext.fillStyle = '#FFFFFF';
        bufferContext.fillRect(OK_X, OK_Y, OK_WIDTH, OK_HEIGHT);
        bufferContext.globalAlpha = 1;
      }
      bufferContext.fillStyle = '#000000';
      bufferContext.font = '25px Space Mono';
      bufferContext.textAlign = 'center';
      for (int i = 0; i < messageTexts[task].length; i++) {
        bufferContext.fillText(messageTexts[task][i], 350, 160 + i * 30);
      }
    } else if (taskState == 2) {
      if (task == 1) {
        // smoke animation
        bufferContext.beginPath();
        bufferContext.arc(tempTile.positionX * Tile.WIDTH, tempTile.positionY * Tile.HEIGHT, 20, 0, 2 * PI);
        bufferContext.globalAlpha = ((1000 - waitTime).abs() - 1000).abs() / 1000;
        bufferContext.fillStyle = '#BBBBBB';
        bufferContext.fill();
        bufferContext.globalAlpha = 1;
      } else if (task == 3) {

      }
    }
  }

}