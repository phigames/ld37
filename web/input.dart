part of ld37;

class Input {

  static bool mouseDown = false;
  static num mouseX = 0;
  static num mouseY = 0;

  static void onMouseDown(MouseEvent event) {
    if (event.button == 0) {
      mouseDown = true;
    }
  }

  static void onMouseUp(MouseEvent event) {
    if (event.button == 0) {
      mouseDown = false;
    }
  }

  static void onMouseMove(MouseEvent event) {
    mouseX = event.page.x - gameElement.offsetLeft - canvas.offsetLeft;
    mouseY = event.page.y - gameElement.offsetTop - canvas.offsetTop;
  }

}