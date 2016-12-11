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
  num endTime;

  TaskHandler() {
    task = 0;
    taskState = 0;
    messageTexts = [ [ 'Ugh, so much', 'homework!', '', 'Where\'s', 'my chair?' ],
                     [ 'Finally done.', 'Time to roll', 'a spliff', 'on my bed.' ],
                     [ 'Sounds like', 'someone\'s at', 'the door.' ],
                     [ '"I\'m sure this', 'Ficus benjamina', 'will make your', 'new room feel', 'right at home.', 'Don\'t forget', 'to water it!', 'Love, Mom"' ],
                     [ '*stomach', 'rumbling*', 'I think I have', 'some chicken', 'leftover from', 'last week...', 'Let me set', 'the table.' ],
                     [ 'Oh no,', 'another gift', 'from Mom?' ],
                     [ '"Hey-ho nephew!', 'I heard you\'ve', 'moved, so I', 'thought you', 'could use this', 'TV I found', 'in my basement.', '- Uncle John"' ],
                     null,
                     [ '"Sweetheart,', 'I just happen', 'to be in town.', 'I\'ll meet you', 'in a minute!"' ],
                     [ 'Shit, better', 'tidy up a bit', 'before Mom', 'arrives. Let\'s', 'hide the weed', 'and the dirty', 'dishes behind', 'the cupboard!' ],
                     [ '"Sweetheart,', 'I didn\'t know', 'your room is', 'so small!', 'Let me buy you', 'a bigger one."', '', 'YOU WIN.' ],
                     [ '"Hey, I can\'t', 'open the door!', 'Fine, if you', 'don\'t let me in,', 'I won\'t pay', 'your rent."', '', 'YOU LOSE.' ],
                     [ '"Hey, what a', 'mess in here!', 'Fine, if you', 'don\'t tidy up', 'your room', 'I won\'t pay', 'your rent."', 'YOU LOSE.' ] ];
    waitTime = 0;
    endTime = 60000;
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
      if (room.tiles[1][3] is TileTV && (room.tiles[2][3] is TileArmchair ||
                                         (room.tiles[3][3] is TileArmchair && room.tiles[2][3] == null))) {
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
    } else if (task == 8) {
      task++;
      taskState = 0;
      Input.mouseDown = false;
      if (Resources.sounds['ticking'].paused) {
        Resources.sounds['ticking'].currentTime = 0;
        Resources.sounds['ticking'].loop = true;
        Resources.sounds['ticking'].play();
      }
    } else if (task == 9) {
      bool win = true;
      if (room.tiles[2][1] != null) {
        win = false;
      }
      if (!(room.tiles[4][2] is TileCupboard)) {
        win = false;
      }
      if (win) {
        for (int i = 0; i < Room.WIDTH; i++) {
          for (int j = 0; j < Room.HEIGHT; j++) {
            if (room.tiles[i][j] is TileWeed) {
              if (i != 5) {
                win = false;
              }
            } else if (room.tiles[i][j] is TileDish) {
              if (i != 5) {
                win = false;
              }
            }
          }
        }
      }
      if (win) {
        Resources.sounds['ticking'].pause();
        Resources.sounds['doorbell'].currentTime = 0;
        Resources.sounds['doorbell'].play();
        Resources.sounds['momHappy'].currentTime = 0;
        Resources.sounds['momHappy'].play();
        task = 10;
        taskState = 0;
        Input.mouseDown = false;
      } else if (endTime <= 0) {
        Resources.sounds['ticking'].pause();
        Resources.sounds['momAngry'].currentTime = 0;
        Resources.sounds['momAngry'].play();
        if (room.tiles[2][1] != null) {
          task = 11;
        } else {
          task = 12;
        }
        taskState = 0;
        Input.mouseDown = false;
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
        check();
      }
    } else if (taskState == 1) {
      if (task == 9) {
        endTime -= deltaTime;
        check();
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
        if (Resources.sounds['ringtone'].paused) {
          Resources.sounds['ringtone'].currentTime = 0;
          Resources.sounds['ringtone'].loop = true;
          Resources.sounds['ringtone'].play();
        }
      }
      if (waitTime <= 0) {
        task++;
        taskState = 0;
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
    } else if (taskState == 1 && task >= 10) {
      bufferContext.fillStyle = '#000000';
      bufferContext.fillRect(0, 0, canvas.width, canvas.height);
      bufferContext.fillStyle = '#DDDDDD';
      bufferContext.font = '100px Space Mono';
      bufferContext.textAlign = 'center';
      bufferContext.fillText('GAME OVER', 350, 200);
      bufferContext.font = '40px Space Mono';
      bufferContext.fillText('Thank you for playing', 350, 300);
      bufferContext.font = '15px Space Mono';
      bufferContext.fillText('made for Ludum Dare 37 by Soferus & phi', 350, 400);
    } else if (taskState == 2) {
      if (task == 1) {
        // smoke animation
        bufferContext.beginPath();
        bufferContext.arc(tempTile.positionX * Tile.WIDTH + 20, tempTile.positionY * Tile.HEIGHT + 30, (3000 - waitTime) / 200, 0, 2 * PI);
        bufferContext.globalAlpha = ((1000 - waitTime).abs() - 1000).abs() / 1000;
        bufferContext.fillStyle = '#BBBBBB';
        bufferContext.fill();
        bufferContext.beginPath();
        bufferContext.arc(tempTile.positionX * Tile.WIDTH + 50, tempTile.positionY * Tile.HEIGHT + 20, (4000 - waitTime) / 150, 0, 2 * PI);
        bufferContext.globalAlpha = ((1000 - waitTime).abs() - 1000).abs() / 1000;
        bufferContext.fillStyle = '#DDDDDD';
        bufferContext.fill();
        bufferContext.beginPath();
        bufferContext.arc(tempTile.positionX * Tile.WIDTH + 70, tempTile.positionY * Tile.HEIGHT + 80, (3000 - waitTime) / 100, 0, 2 * PI);
        bufferContext.globalAlpha = ((1000 - waitTime).abs() - 1000).abs() / 1000;
        bufferContext.fillStyle = '#CCCCCC';
        bufferContext.fill();
        bufferContext.beginPath();
        bufferContext.arc(tempTile.positionX * Tile.WIDTH + 30, tempTile.positionY * Tile.HEIGHT + 80, (3000 - waitTime) / 200, 0, 2 * PI);
        bufferContext.globalAlpha = ((1000 - waitTime).abs() - 1000).abs() / 1000;
        bufferContext.fillStyle = '#BBBBBB';
        bufferContext.fill();
        bufferContext.beginPath();
        bufferContext.arc(tempTile.positionX * Tile.WIDTH + 80, tempTile.positionY * Tile.HEIGHT + 30, (4000 - waitTime) / 150, 0, 2 * PI);
        bufferContext.globalAlpha = ((1000 - waitTime).abs() - 1000).abs() / 1000;
        bufferContext.fillStyle = '#DDDDDD';
        bufferContext.fill();
        bufferContext.beginPath();
        bufferContext.arc(tempTile.positionX * Tile.WIDTH + 40, tempTile.positionY * Tile.HEIGHT + 30, (3000 - waitTime) / 100, 0, 2 * PI);
        bufferContext.globalAlpha = ((1000 - waitTime).abs() - 1000).abs() / 1000;
        bufferContext.fillStyle = '#CCCCCC';
        bufferContext.fill();
        bufferContext.globalAlpha = 1;
      }
    }
  }

}