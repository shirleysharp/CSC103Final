//making my player class
class Cow {
  //declaring my vars
  int x;
  int y;
  int w;
  int h;
  color c; //color of player
  int runSpeed; //speed of player running
  int jumpSpeed; //speed of player jumping
  int fallSpeed; //speed the player falls
  int jumpHeight; //amount of distance the player moves up when the payer jumps
  int peakY; //y value the player will have when it reaches top of the jump

  //hit box vars
  int topBound;
  int bottomBound;
  int leftBound;
  int rightBound;

  //booleans
  boolean movingLeft; //when it is true, the player will move left
  boolean movingRight; //when it is true, the player will move to the right
  boolean isJumping; //when it is true, the player will be rising from a jump
  boolean isFalling; //when it is true, the player will be falling
  boolean isFallingWithPlatform = false;
  boolean isAnimating; //will occur when player is jumping

  void fallWithPlatform(int platformSpeed) {
    if (isJumping == false) {
      y += platformSpeed;
    }
    isFalling = false;
  }

  //make my constructor function
  Cow() {
    x = width/2-w/2;
    y = 100;
    runSpeed = 10;
    jumpSpeed = 200;
    fallSpeed = 10;

    //setting booleans
    movingLeft = false;
    movingRight = false;
    isJumping = false;
    isFalling = false;

    //make my cow animation
    for (int i=0; i<cowImages.length; i++) {
      cowImages[i] = loadImage("cowpixel"+i+".png");
    }
    cowA = new Animation(cowImages, 0.2, 10.0);

    cowA.isAnimating = false;


    h = cowImages[0].height*10;
    w = cowImages[0].width*10;
    
    updateBounds();
  }
  
  
  void render() {
    updateBounds();
    jumpHeight = y > -200 ? y-200 : y;
    cowA.display(x, y);
  }

  void updateBounds() {
    topBound = y;
    bottomBound = y + h;
    leftBound = x;
    rightBound = x + w;
  }

  void move() {
    if (movingRight == true && rightBound < width) {
      x = x + runSpeed;
    }
    if (movingLeft == true && leftBound > 0) {
      x = x - runSpeed;
    }
  }

  void jump() {
    if (isJumping == true && isFalling == false) {
    cowA.isAnimating = true;

      y = y - jumpSpeed;
    }
  }

  void reachedTopofJump() {
    if ( y <= jumpHeight && isJumping == true) {
      if (!isFallingWithPlatform) {
        isFalling = true;
      }
      isJumping = false;
    }
  }

  void fall() {
    if(isFallingWithPlatform){
    return;
    }
    if (isFalling ==true && isJumping == false) {
      y = y + fallSpeed;
    }
  }

  void land() {
    if (bottomBound >= height) {
      isFalling = false;
      y = height - h;
    }
  }


  void wallDetect() {
    // wall detection for the bottom wall
    if (y + h/2 >= height) {
      y = height-100;
    }
  }
}
