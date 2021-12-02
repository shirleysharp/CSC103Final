int interval;
int startTime = millis();
int endTime;
int state; //declaring my variable state
int score; //tells the player what their score is

//declaring my arraylist var
ArrayList<Platform>platformList;

//importing sound
//import processing.sound.*;

//declaring variables to store sounds
//SoundFile mooSound;
//SoundFile fallingSound;
//SoundFile backgroundSound;

//make my animations
Cow pixelCow;
Animation cowA;
Snake pixelSnake;
Animation snakeA;

PImage[] cowImages =new PImage[2];
PImage[] snakeImages = new PImage[1];
PImage backgroundImage;
PImage gameoverImage;

void setup() {
  size(1200, 700);
backgroundImage = loadImage("barn background.jpeg");
gameoverImage = loadImage("gameover screen.png");
frameRate(10);

  //initalize the sound variable
  //mooSound = new SoundFile(this, "mooSound.wav");
  //fallingSound = new SoundFile(this, "fallingSound.mp3");
  //backgroundSound = new SoundFile(this, "backgroundSound.mp3");
  startTime = millis();
  interval = 50;
  //initalize my array list
  platformList = new ArrayList<Platform>();

  for (int i=0; i<12; i++) {
    platformList.add(makePlatform(0, 600));
  }


  //change the speed of moo sound
  //mooSound.rate(2.0);

  pixelCow=new Cow();
  pixelSnake = new Snake(100, 200);
  //don't allow snake and cow to allign in the start of game
  var snakeOverlaps = true;
  while(snakeOverlaps){
    snakeOverlaps = false;
    if(pixelSnake.isOverlapping(pixelCow)){
      snakeOverlaps = true;
      pixelSnake = new Snake(100, 200);
    }
  }
}

Platform makePlatform(int minY, int maxY) {
  var newPlatform = new Platform(minY, maxY);
  var overlaps = true;
  while (overlaps) {
    overlaps = false;
    for (Platform p : platformList) {
      if (newPlatform.isOverlapping(p)) {
        overlaps = true;
        newPlatform = new Platform(minY, maxY);
        break;
      }
    }
  }
  return newPlatform;


  //initalizng my state variabe
  //state = 0;
}


void draw() {
  background (42);
    image(backgroundImage, 0, 0, width, height);


  //looping background music
  //if (backgroundSound.isPlaying() == false) {
  //  backgroundSound.play();
  //}

  //my different states
  switch(state) {
  case 0:
    textSize(80);
    text("Farm Jump:", width/2 - 175, 620);
    fill(color(#FF2424));
    square(140, 250, 60);
    textSize(40);
    fill(color(#FFFAFA));
    text("w", 155,290);
    fill(color(#FF2424));
    square(90, 320, 60);
    textSize(40);
    fill(color(#FFFAFA));
    text("a", 110, 360);
    fill(color(#FF2424));
    square(180, 320, 60);
    textSize(40);
    fill(color(#FFFAFA));
    text("d", 200, 363);
    textSize(25);
    fill(color(#151212));
    text("Use These Keys to Play:", 70, 230);
    textSize(48);
    text("press the space bar to start game", width/2-275, 670);
    break;
  case 1:
    endTime = millis();

    if (endTime - startTime >= interval) {

    //cow functions
    pixelCow.move();
    pixelCow.fall();
    pixelCow.reachedTopofJump();
    pixelCow.land();
    pixelCow.jump();
    pixelCow.render();
    //snake functions
    pixelSnake.fall();
    pixelSnake.render();
 
    
    if(pixelSnake.y > height){
      pixelSnake = new Snake(-100, -10);
    }
 

    var deadPlatforms = 0;

    //platform functions
    var onPlatform = false;
    for (int i=0; i<platformList.size(); i++) {
      Platform aPlatform = platformList.get(i);
      if (aPlatform.y > height) {
        //println(aPlatform.bottomBound);
        platformList.remove(i);
        deadPlatforms++;
      }
      aPlatform.render();
      aPlatform.move();
      aPlatform.wallDetect();
      if (aPlatform.LandedOn(pixelCow)) {
        onPlatform = true;
      }
      aPlatform.fallingPlatform();
    }
    //println(onPlatform);
    if (!onPlatform) {
      pixelCow.isFalling = true;
      pixelCow.isFallingWithPlatform = false;
    } else {
      pixelCow.isFallingWithPlatform = true;
    }

    for (int j=0; j<deadPlatforms; j++) {
      platformList.add(makePlatform(-100, -10));
    }
    startTime = millis();
    //creating my score
    score += 1;
    textSize(75);
    text(score, width/2 -75, 100);
    
    //if statements for case 2
        if(pixelCow.y > height-111){
    state = 2;
     }
    if(pixelSnake.isOverlapping(pixelCow)){
      state = 2;
    }
        startTime = millis();
    }
    break;
    
    
  case 2:
    //losing score screen
    image(gameoverImage, 0, 0, width, height);
    break;
  }
 
  }






  //make my player move
  void keyPressed() {
    //start the game
    if(key == ' '){
      state = 1;
    }
    //move to left if a is pressed
    if (key =='a') {
      pixelCow.x = pixelCow.x - pixelCow.runSpeed;
    }
    //jump upwards if 'w' key is pressed
    if (key =='w') {
      //mooSound.play();
      if(pixelCow.isFallingWithPlatform){
      pixelCow.isJumping = true;
      }
    }
    //move to the right if 'd' key is pressed
    if (key == 'd') {
      pixelCow.x = pixelCow.x + pixelCow.runSpeed;
    }
  }

  void keyReleased() {
    if (key == 'w') {
      cowA.isAnimating = false;
      pixelCow.isJumping = false;
      if (!pixelCow.isFallingWithPlatform) {
        pixelCow.isFalling = true;
      }
    }
    if(key == 'a'){
      pixelCow.movingLeft = false;

    }
    if(key == 'd'){
      pixelCow.movingRight = false;
    }
  }
