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
    messageTexts = [ [ 'Ugh, so much', 'homework!', '', 'Where\'s', 'my chair?' ],
                     [ 'Finally done.', 'Time to roll', 'a spliff.' ],
                     [ 'Sounds like', 'someone\'s at', 'the door.' ],
                     [ '"I\'m sure this', 'Ficus benjamini', 'will make your', 'new room feel', 'right at home.', 'Don\'t forget', 'to water it!', 'Love, Mom"' ],
                     [ '*stomach', 'rumbling*', 'I think I have', 'some chicken', 'leftover from', 'last week...', 'Let me set', 'the table.' ],
                     [ 'Oh no,', 'another gift', 'from Mom?' ],
                     [ '"Hey-ho nephew!', 'I heard you\'ve', 'moved, so I', 'thought you', 'could use this', 'TV I found', 'in my basement.', '- Uncle John"' ],
                     null,
                     [ '"Sweetheart,', 'I just happen', 'to be in town.', 'I\'ll meet you', 'in 20 seconds!"', '', 'Shit, better', 'tidy up a bit.' ] ];
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
            Resources.sounds['scribble'].currentTime = 0;
            Resources.sounds['scribble'].play();
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
            Resources.sounds['cough'].currentTime = 0;
            Resources.sounds['cough'].play();
          }
        }
      }
    } else if (task == 2) {
      if (room.tiles[2][1] == null) {
        taskState = 2;
        tempTile = room.tiles[2][1];
        waitTime = 1000;
      }
    } else if (task == 3) {
      if ((room.tiles[6][2] as TileToilet).plantMode == 1) {
        taskState = 2;
        tempTile = room.tiles[6][2];
        waitTime = 1000;
        Resources.sounds['water'].currentTime = 0;
        Resources.sounds['water'].play();
      }
    } else if (task == 4) {
      for (int i = 0; i < Room.WIDTH; i++) {
        for (int j = 0; j < Room.HEIGHT; j++) {
          if (room.tiles[i][j] is TileDesk && (room.tiles[i][j] as TileDesk).part == 1 && (room.tiles[i][j] as TileDesk).dishMode == 1 && room.tiles[i][j - 1] is TileChair) {
            taskState = 2;
            tempTile = room.tiles[i][j];
            waitTime = 2000;
            Resources.sounds['crisp'].currentTime = 0;
            Resources.sounds['crisp'].play();
          }
        }
      }
    } else if (task == 5) {
      if (room.tiles[2][1] == null) {
        taskState = 2;
        tempTile = room.tiles[2][1];
        waitTime = 1000;
      }
    } else if (task == 6) {
      if (room.tiles[1][3] is TileTV && room.tiles[2][3] is TileArmchair) {
        taskState = 2;
        tempTile = room.tiles[1][3];
        waitTime = 2000;
        Resources.sounds['tv'].currentTime = 0;
        Resources.sounds['tv'].play();
      }
    } else if (task == 7) {
      if (room.tiles[1][3] == null) {
        taskState = 2;
        tempTile = room.tiles[1][3];
        waitTime = 500;
        Resources.sounds['ringtone'].pause();
        Resources.sounds['momPhone'].currentTime = 0;
        Resources.sounds['momPhone'].play();
      }
    }
  }

  void update(num deltaTime) {
    if (taskState == 0) {
      if (messageTexts[task] == null) {
        taskState = 1;
      }
      // message is being shown
      if (Input.mouseDown &&
          Input.mouseX > OK_X && Input.mouseX < OK_X + OK_WIDTH &&
          Input.mouseY > OK_Y && Input.mouseY < OK_Y + OK_HEIGHT) {
        taskState = 1;
      }
    } else if (taskState == 2) {
      waitTime -= deltaTime;
      // task is done, play animation and go to next task
      if (task == 0) {
        if (waitTime <= 700) {
          (tempTile as TileDesk).homeworkDone = true;
        }
      } else if (task == 1) {
        if (waitTime <= 1000) {
          (tempTile as TileBed).weedMode = 2;
        }
        if (waitTime <= 0) {
          Resources.sounds['doorbell'].currentTime = 0;
          Resources.sounds['doorbell'].play();
        }
      } else if (task == 2) {
        if (waitTime <= 1000 && room.tiles[2][1] == null) {
          room.tiles[2][1] = new TilePlant(2, 1);
        }
      } else if (task == 3) {

      } else if (task == 4) {
        if (waitTime <= 1800) {
          (tempTile as TileDesk).dishMode = 2;
        }
        if (waitTime <= 0) {
          Resources.sounds['doorbell'].currentTime = 0;
          Resources.sounds['doorbell'].play();
        }
      } else if (task == 5) {
        if (waitTime <= 1000 && room.tiles[2][1] == null) {
          room.tiles[2][1] = new TileTV(2, 1);
        }
      } else if (task == 6) {
        Resources.sounds['ringtone'].currentTime = 0;
        Resources.sounds['ringtone'].loop = true;
        Resources.sounds['ringtone'].play();
      }
      if (waitTime <= 0) {
        task++;
        taskState = 0;
        check();
      }
    }
  }

  void draw() {
    if (taskState == 0 && messageTexts[task] != null) {
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