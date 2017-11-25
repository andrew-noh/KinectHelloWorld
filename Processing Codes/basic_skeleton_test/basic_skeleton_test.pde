//Skeleton test


import SimpleOpenNI.*;

SimpleOpenNI context;

color[] userColor = new color[]{ 
  color(255, 0, 0), 
  color(0, 255, 0), 
  color(0, 0, 255), 
  color(255, 255, 0), 
  color(255, 0, 255), 
  color(0, 255, 255)
};


void setup() {
  size(1260, 960, P2D);

  context = new SimpleOpenNI(this);
  if (context.isInit() == false) {
    println("Can't initialize SimpleOpenNI, camera not connected properly."); 
    exit();
    return;
  }

  context.enableDepth();
  context.enableUser();
  context.setMirror(false);

  background(0);

  stroke(0, 0, 255);
  strokeWeight(3);
  smooth();
}

void draw() {
  context.update();
  scale(2);

  image(context.userImage(), 0, 0);

  int[] userList = context.getUsers();
  for (int i=0; i<userList.length; i++) {
    if (context.isTrackingSkeleton(userList[i])) {
      stroke(userColor[ (userList[i] - 1) % userColor.length ]);
      background(0);
      drawSkeleton(userList[i]);
    }
  }
}

void onNewUser(SimpleOpenNI curContext, int userId) {
  println("onNewUser - userId: " + userId);
  curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId) {
  println("onLostUser - userId: " + userId);
}

void onVisibleUser(SimpleOpenNI curContext, int userId) {
  println("onVisibleUser - userId: " + userId);
}