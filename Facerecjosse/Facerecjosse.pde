import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import ddf.minim.*;

AudioPlayer player;
Minim minim;//audio context


Capture video;
OpenCV opencv;
PImage img;

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();

  img = loadImage("fibon.png");

minim = new Minim(this);
  player = minim.loadFile("Censor Beep Sound Effect.mp3", 2048);
  player.play();

}



void draw() {
  scale(2);
  opencv.loadImage(video);

  boolean gevonden = false;
  image(video, 0, 0 );

  noFill();
  stroke(0, 255, 0);
  strokeWeight(15);
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  if (faces.length > 1) {
    Rectangle gezicht1 = faces[0];
    Rectangle gezicht2 = faces[1];

    float total_x = (gezicht2.x +gezicht2.width) - gezicht1.x;
    float tussen_x = gezicht2.x - (gezicht1.x +gezicht1.width);

    float verhouding1 =    gezicht1.width / (gezicht2.width * 1.0);
    float verhouding2 =    gezicht1.width / (total_x * 1.0);
    float verhouding3 =    gezicht1.width / (tussen_x *1.0);
    float verhouding4 =    tussen_x / (gezicht2.width *1.0);
    float verhouding5 =    total_x / (gezicht2.x *1.0);
    float verhouding6 =    tussen_x / (total_x * 1.0);

    float total_y = (gezicht2.y +gezicht2.height) - gezicht1.y;
    float tussen_y = gezicht2.y - (gezicht1.y +gezicht1.height);

    float verhouding7 =    gezicht1.height / (gezicht2.height * 1.0);
    float verhouding8 =    gezicht1.height / (total_y * 1.0);
    float verhouding9 =    gezicht1.height / (tussen_y *1.0);
    float verhouding10 =    tussen_y / (gezicht2.height *1.0);
    float verhouding11 =    total_y / (gezicht2.y *1.0);
    float verhouding12 =    tussen_y / (total_y * 1.0);

    float marge = 0.05;
    float phi = 1.6103;
    float phi_min = phi - marge;
    float phi_max = phi + marge;

    float phi_inv_min = 1.0 / phi_min;
    float phi_inv_max = 1.0 / phi_max;

    if (((verhouding1 > phi_min) && (verhouding1 < phi_max)) || ((verhouding1 < phi_inv_min) && (verhouding1 > phi_inv_max))) 
    {
      gevonden = true;
    }
    if (((verhouding2 > phi_min) && (verhouding2 < phi_max)) || ((verhouding2 < phi_inv_min) && (verhouding2 > phi_inv_max))) 
    {
      gevonden = true;
    }
    if (((verhouding3 > phi_min) && (verhouding3 < phi_max)) || ((verhouding3 < phi_inv_min) && (verhouding3 > phi_inv_max))) 
    {
      gevonden = true;
    }
    if (((verhouding1 > phi_min) && (verhouding4 < phi_max)) || ((verhouding4 < phi_inv_min) && (verhouding4 > phi_inv_max))) 
    {
      gevonden = true;
    }
    if (((verhouding1 > phi_min) && (verhouding5 < phi_max)) || ((verhouding5 < phi_inv_min) && (verhouding5 > phi_inv_max))) 
    {
      gevonden = true;
    }
     if (((verhouding1 > phi_min) && (verhouding6 < phi_max)) || ((verhouding6 < phi_inv_min) && (verhouding6 > phi_inv_max))) 
    {
      gevonden = true;
    }
     if (((verhouding1 > phi_min) && (verhouding7 < phi_max)) || ((verhouding7 < phi_inv_min) && (verhouding7 > phi_inv_max))) 
    {
      gevonden = true;
    }
     if (((verhouding1 > phi_min) && (verhouding8 < phi_max)) || ((verhouding8 < phi_inv_min) && (verhouding8 > phi_inv_max))) 
    {
      gevonden = true;
    }
     if (((verhouding1 > phi_min) && (verhouding9 < phi_max)) || ((verhouding9 < phi_inv_min) && (verhouding9 > phi_inv_max))) 
    {
      gevonden = true;
    }
     if (((verhouding1 > phi_min) && (verhouding10 < phi_max)) || ((verhouding10 < phi_inv_min) && (verhouding10 > phi_inv_max))) 
    {
      gevonden = true;
    }
     if (((verhouding1 > phi_min) && (verhouding11 < phi_max)) || ((verhouding11 < phi_inv_min) && (verhouding11 > phi_inv_max))) 
    {
      gevonden = true;
    }
     if (((verhouding1 > phi_min) && (verhouding12 < phi_max)) || ((verhouding12 < phi_inv_min) && (verhouding12 > phi_inv_max))) 
    {
      gevonden = true;
    }
     

  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    
    if (gevonden) {
      int breedte = int(faces[i].width * (915 / 579.0));
      int hoogte = faces[i].height;
      int verschil = breedte - hoogte;
      int x = faces[i].x - (verschil / 2);
      int y = faces[i].y;
      image(img, x, y, breedte, hoogte);
      //915 × 579
    } else {
      rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }
  }
  
  if (gevonden = true) {
    // doe iets als gevonden
  } else {
    // doe iets als niet gevonden
  }
}

//void captureEvent(Capture c) {
 // c.read();
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
}
