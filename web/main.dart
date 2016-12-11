library ld37;

import 'dart:html';
import 'dart:math';

part 'room.dart';
part 'tile.dart';
part 'taskhandler.dart';
part 'input.dart';
part 'resources.dart';

CanvasElement canvas, buffer;
CanvasRenderingContext2D canvasContext, bufferContext;
num timeElapsed;
Room room;

void main() {
  canvas = querySelector('#canvas');
  buffer = new CanvasElement(width: canvas.width, height: canvas.height);
  canvasContext = canvas.context2D;
  bufferContext = buffer.context2D;
  canvas.onMouseDown.listen(Input.onMouseDown);
  canvas.onMouseUp.listen(Input.onMouseUp);
  canvas.onMouseMove.listen(Input.onMouseMove);
  timeElapsed = -1;
  Resources.load();
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
    timeElapsed = time;
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
