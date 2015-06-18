import controlP5.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
PImage dst, cannyImg, cannyMask, cannyBack;
OpenCV opencv;
ControlP5 cp5;

int videoWidth;
int videoHeight;

int opencv_threshold;
int opencv_adaptive;
int canny_blur;
int canny_low;
int canny_high;
int hough_treshold;
int hough_minLength;
int hough_maxGap;
Textlabel nContoursLabel;
Textlabel nLinesLabel;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;
ArrayList<Line> lines;

void setup() {
  size(960, 480);
  videoWidth = 640 / 2;
  videoHeight = 480 / 2;
  video = new Capture(this, videoWidth, videoHeight);
  opencv = new OpenCV(this, videoWidth, videoHeight);
  
  opencv.gray();
  opencv_threshold = 70;
  
  cp5 = new ControlP5(this);
  cp5.addSlider("opencv_threshold")
       .setPosition(10, videoHeight + 5)
       .setRange(0, 255)
       .setValue(128);
  cp5.addSlider("opencv_adaptive")
       .setPosition(10, videoHeight + 15)
       .setRange(0, 20)
       .setValue(1);
  nContoursLabel = cp5.addTextlabel("nContoursLabel")
       .setText("n contours")
       .setPosition(250, videoHeight + 5);
       
  cp5.addSlider("canny_blur")
       .setPosition(videoWidth + 10, videoHeight + 5)
       .setRange(1, 20)
       .setValue(2);
  cp5.addSlider("canny_low")
       .setPosition(videoWidth + 10, videoHeight + 15)
       .setRange(0, 200)
       .setValue(100);
  cp5.addSlider("canny_high")
       .setPosition(videoWidth + 10, videoHeight + 25)
       .setRange(0, 200)
       .setValue(160);
       
  cp5.addSlider("hough_treshold")
       .setPosition(videoWidth + 10, videoHeight + 45)
       .setRange(1, 255)
       .setValue(20);
  cp5.addSlider("hough_minLength")
       .setPosition(videoWidth + 10, videoHeight + 55)
       .setRange(1, 100)
       .setValue(50);
  cp5.addSlider("hough_maxGap")
       .setPosition(videoWidth + 10, videoHeight + 65)
       .setRange(1, 100)
       .setValue(5);
  nLinesLabel = cp5.addTextlabel("nLinesLabel")
       .setText("n lines")
       .setPosition(videoWidth + 250, videoHeight + 5);

  cannyImg = createImage(videoWidth, videoHeight, RGB);
  cannyImg.loadPixels();
  for (int i = 0; i < cannyImg.pixels.length; i++) {
      cannyImg.pixels[i] = color(255, 0, 0);      
  }
  cannyImg.updatePixels();
  
  cannyBack = createImage(videoWidth, videoHeight, RGB);
  cannyBack.loadPixels();
  for (int i = 0; i < cannyBack.pixels.length; i++) {
      cannyBack.pixels[i] = color(100);      
  }
  cannyBack.updatePixels();

  video.start();
}

void draw() {
  background(200);
  scale(1);
  opencv.loadImage(video);

  // adaptive filtering
  opencv.flip(1);
  dst = opencv.getOutput();
  opencv.threshold(opencv_threshold);
  opencv.adaptiveThreshold(5, opencv_adaptive);
  
  contours = opencv.findContours(false, false);
  //println("found " + contours.size() + " contours");

  // Canny Edge Detection
  opencv.loadImage(video);
  opencv.flip(1);
  opencv.blur(canny_blur);
  dst = opencv.getSnapshot();
  opencv.findCannyEdges(canny_low, canny_high);
  cannyMask = opencv.getOutput();
  // Find lines with Hough line detection
  // Arguments are: threshold, minLengthLength, maxLineGap
  lines = opencv.findLines(hough_treshold, hough_minLength, hough_maxGap);
  println("found " + contours.size() + " contours - " + lines.size() + " lines");
  nContoursLabel.setText(contours.size() + " contours");
  nLinesLabel.setText(lines.size() + " lines"); 
  
  cannyImg.mask(cannyMask);
  cannyBack.mask(cannyMask);
  
  pushMatrix();
  scale(-1, 1);
  translate( -videoWidth, 0);
  image(video, 0, 0 );
  popMatrix();
  
  image(dst, videoWidth, 0);
  image(cannyImg, videoWidth, 0);
  
  fill(0);
  rect(videoWidth * 2, 0, videoWidth, videoHeight);
  image(cannyBack, videoWidth * 2, 0);

  // contour Finding
  noFill();
  strokeWeight(1);
  
  int i = 0;
  for (Contour contour : contours) {
    stroke(255, 0, 0);
    contour.draw();
    
    stroke(255, 255, 0);
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      vertex(point.x, point.y);
    }
    endShape();
    
    i++;
  }
  
  // Line drawing
  
  // on middle video
  stroke(255, 255, 0);
  for (Line line : lines) {
      line(videoWidth + line.start.x, line.start.y, videoWidth + line.end.x, line.end.y);
  }
  
  // on right image
  stroke(255, 0, 0);
  for (Line line : lines) {
      line((videoWidth * 2) + line.start.x, line.start.y, (videoWidth * 2) + line.end.x, line.end.y);
  }
  
}

void captureEvent(Capture c) {
  c.read();
}

