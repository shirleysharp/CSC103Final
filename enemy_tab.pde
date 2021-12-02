//make my enemy class
class Snake extends Cow {
 // declaring my vars
  //int x;
  //int y;
  //int h;
  //int w;
  //color c; //color of player

  ////hit box vars
  //int topBound;
  //int bottomBound;
  //int leftBound;
  //int rightBound;

  //make my constructor function
  Snake(int minY, int maxY) {
    x = int (random(0, width-200));
    y = int (random(minY, maxY));
    fallSpeed = 3;
    isFalling = true;

    //make my snake animation
    for (int i=0; i<snakeImages.length; i++) {
      snakeImages[i] = loadImage("snakepixel"+i+".png");
    }
    snakeA = new Animation(snakeImages, 0.2, 10.0);
    snakeA.isAnimating = false;
    h = snakeImages[0].height*10;
    w = snakeImages[0].width*10;
    
    updateBounds();
  }

  void render() {
    snakeA.display(x, y);
      //declaring my hit box vars
    topBound = y;
    bottomBound = y + h;
    leftBound = x;
    rightBound = x + w;
  }
  
  
 boolean isOverlapping(Cow other) {
    if (leftBound > other.rightBound || rightBound < other.leftBound ||
      topBound > other.bottomBound || bottomBound < other.topBound) {
      return false;
    }
    return true;
  }
}
