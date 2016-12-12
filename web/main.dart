library ld37;

import 'dart:html';
import 'dart:math';

part 'room.dart';
part 'tile.dart';
part 'taskhandler.dart';
part 'input.dart';
part 'resources.dart';

DivElement gameElement;
HeadingElement loadingElement;
CanvasElement canvas, buffer;
CanvasRenderingContext2D canvasContext, bufferContext;
num timeElapsed;
Room room;

void main() {
  gameElement = querySelector('#game');
  loadingElement = querySelector('#loading');
  canvas = querySelector('#canvas');
  buffer = new CanvasElement(width: canvas.width, height: canvas.height);
  canvasContext = canvas.context2D;
  bufferContext = buffer.context2D;
  canvas.onMouseDown.listen(Input.onMouseDown);
  canvas.onMouseUp.listen(Input.onMouseUp);
  canvas.onMouseMove.listen(Input.onMouseMove);
  canvas.style.display = 'none';
  Resources.load();
  timeElapsed = -1;
  requestFrame();
}

void startGame() {
  loadingElement.style.display = 'none';
  canvas.style.display = 'block';
  room = new Room();
  requestFrame();
}

void update(num deltaTime) {
  room.update(deltaTime);
}

void draw() {
  bufferContext.clearRect(0, 0, canvas.width, canvas.height);
  room.draw();
  canvasContext.clearRect(0, 0, canvas.width, canvas.height);
  canvasContext.drawImage(buffer, 0, 0);
}

frame(num time) {
  if (timeElapsed == -1) {
    if (Resources.doneLoading) {
      timeElapsed = time;
      startGame();
    }
  } else {
    num deltaTime = time - timeElapsed;
    update(deltaTime);
    draw();
    timeElapsed = time;
  }
  requestFrame();
}

void requestFrame() {
  window.animationFrame.then(frame);
}
