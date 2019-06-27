//Arraylist holds the coordinates of the snake
ArrayList<Integer> x = new ArrayList<Integer>(), y = new ArrayList<Integer>();
//width,height, block side, the apple coordinates, and the score
int wid = 20, h =20, bs = 30, redx = 5, redy = 5, score = 0;
int[] dx = {0, 0, 1, -1}, dy = {1, -1, 0, 0};
//set initial direction to right
int dir = 2;
boolean gameover = false;
void setup() {
  
  //wid*bs
  size(600, 600);
  x.add(10);
  y.add(10);
}

void draw() {
  background(0);
  //grid
  //for (int i =0; i <wid; i++) {
  //  for (int j =0; j<h; j++) {
  //    fill(0, 0, 0);
  //    rect(i*bs, j*bs, bs, bs);
  //  }
  //}
  
  //snake
  for (int i =0; i <x.size(); i++) {
    fill(0, 255, 0);
    rect(x.get(i)*bs, y.get(i)*bs, bs, bs);
  }
  //Keep track of the score
  textSize(20);
  textAlign(CENTER);
  text("SCORE: " + score,  width/2, height);
  if (!gameover) {
    fill(255, 0, 0);
    rect(redx*bs, redy*bs, bs, bs);

    if (frameCount%5==0) {
      x.add(0, x.get(0) + dx[dir]);
      y.add(0, y.get(0) + dy[dir]);

      //hits the walls
      if (x.get(0) <0 ||y.get(0) <0 ||x.get(0)>= wid||y.get(0)>= h)
        gameover = true;


      //hits itself
      for (int i =1; i <x.size(); i++)
        if (x.get(0) == x.get(i) &y.get(0) == y.get(i))
          gameover = true;

      //if hit apple
      if (x.get(0) ==redx && y.get(0) ==redy) {
        redx = (int)random(0, wid);
        redy = (int)random(0, h);
        score += 10;
      } else {
        x.remove(x.size()-1);
        y.remove(y.size()-1);
      }
    }
  } else {
    fill(255);
    textSize(50);
    
    text("GAME OVER",  width/2, height/2);
    if (keyPressed && key == ' ') {
      x.clear();
      y.clear();
      x.add(5);
      y.add(5);
      score = 0;
      gameover = false;
    }
  }
}
void keyPressed() {
  
  //Control snake using wasd
  int newdir = key =='s' ? 0: (key =='w'? 1: (key == 'd' ? 2: 
    (key =='a' ?3 :-1)));
  if (newdir != -1 && (x.size() <=1 ||
    !(x.get(0)+dx[newdir] == x.get(1) && y.get(0)+dy[newdir]== y.get(1)))) dir = newdir;
}
