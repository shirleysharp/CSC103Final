//make my platform class
class Platform {

  //declare my variables
  int x;
  int y;
  int h;
  int w;
  int speed;
  color c;

  int ySpeed;

  //hit box vars
  int topBound;
  int bottomBound;
  int leftBound;
  int rightBound;

  //constructor

  Platform(int minY, int maxY) {
    x = int (random(0, width-200));
    y = int (random(minY, maxY));
    w = 200;
    h = 25;
    speed = 3;
    c = color(color(#F0EBEB));

    //declaring my hitbox variables
    topBound = y;
    bottomBound = y + h;
    leftBound = x;
    rightBound = x + w;
  }
  boolean isOverlapping(Platform other) {
    if (leftBound > (other.rightBound+30) || rightBound < (other.leftBound-30) ||
      topBound > (other.bottomBound+30) || bottomBound < (other.topBound-30)) {
      return false;
    }
    return true;
  }
  //functions
  void render() {
    fill(c);
    rect(x, y, w, h);
  }

  void move() {
    y = y + ySpeed;
    topBound = y;
    bottomBound = y + h;
  }

  //function that checks if platform is near wall
  void wallDetect() {
    //wall detection for left wall
    if (x <=0) {
      x = width/2;
    }
    if (x >= width) {
      x = width/2;
    }
  }


  //creating landed on function
  boolean LandedOn (Cow aCow) {
    if (aCow.isFalling == true && leftBound < aCow.rightBound && rightBound >  aCow.leftBound &&
      topBound > (aCow.bottomBound-aCow.fallSpeed) && topBound < (aCow.bottomBound+aCow.fallSpeed)  ) {
      aCow.y = y - aCow.h - 5;
      aCow.fallWithPlatform(speed);
      return true;
    } 
    return false;
  }


  void fallingPlatform () {
    y = y + speed;
  }
}
