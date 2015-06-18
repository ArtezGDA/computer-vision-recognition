# Computer Vision in Processing

This repository holds multiple computer vision projects, build in Processing, with the use of OpenCV (Open Computer Vision). Computer Vision means that from a (live) camera image, the computer is programmed to "see" things and recognizes certain patterns.

## Line Finder

The Line Finder sketch (`opencv_line_finder`) can be a start of a project which is set to recognize lines in the image. The sketch consists of two experiments in recognizing and finding lines in the image:

- The first one (left image) is using the **Contour finding** method, after setting an adaptive threshold.
- The second one (middle and right image) are using the **Hough** line detection after a **Canny Edges** filter.

All images and contours and lines drawn are mirrored, so the sketch can be played with using a coder-faced camera (typically the camera in your laptop) more easily.  
There are sliders to set some of the OpenCV parameters.


## Face detection with Fibonacci searching

The Face detection with Fibonacci project (`Josse_Face_detection_2_goldenratio`) is build by Josse Hermsen.  
When 2 faces are confirmed a piece of code will calculate the distance between them.  
Then when the ratio of the distance to the faces is between 1.6 and 1.7, it "recognizes" this as Fibonacci and something happens, but I am not there yet.
