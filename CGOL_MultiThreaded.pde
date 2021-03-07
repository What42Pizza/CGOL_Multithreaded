// Created 03/06/21
// Last updated 03/07/21





// Settings

final int GridWidth = 1024;
final int GridHeight = 1024;

final int NumOfThreads = 5; // Gives down to ~ 1.6-1.5 ms (average) (~ 5.5-5.7 ms on 1024x1024)

final float StartRandomPlaceThreshold = 0.5;

final boolean UpdateOnSpacePressed = false;





// Vars

int GridLength = GridWidth * GridHeight;

byte[] Grid = new byte [GridLength];
byte[] Buffer;



long TotalUpdateNano = 0;
long TotalRenderNano = 0;










void setup() {
  
  InitGrid();
  
  size (1024, 1024);
  frameRate (60);
  
  LaunchThreads();
  
}



void InitGrid() {
  for (int i = 0; i < GridLength; i ++) {
    Grid [i] = (byte) (random(1) < StartRandomPlaceThreshold ? 1 : 0);
  }
}










void draw() {
  
  long Nano1 = System.nanoTime();
  
  //if (!UpdateOnSpacePressed) UpdateGrid_SingleThreaded();
  if (!UpdateOnSpacePressed) UpdateGrid_MultiThreaded();
  
  long Nano2 = System.nanoTime();
  
  RenderGrid();
  
  long Nano3 = System.nanoTime();
  
  long UpdateNano = Nano2 - Nano1;
  long RenderNano = Nano3 - Nano2;
  TotalUpdateNano += UpdateNano;
  TotalRenderNano += RenderNano;
  
  println();
  println ("Time taken (micro-s):");
  println ("Update: " + UpdateNano / 1000 + "; Average: " + (TotalUpdateNano / frameCount / 1000));
  println ("Render: " + RenderNano / 1000 + "; Average: " + (TotalRenderNano / frameCount / 1000));
  println ("Total: "  + (UpdateNano + RenderNano) / 1000000 + "; Average: " + ((TotalUpdateNano + TotalRenderNano) / frameCount / 1000));
  
}





void RenderGrid() {
  loadPixels();
  for (int i = 0; i < GridLength; i ++) {
    pixels [i] = color ((1 - Grid[i]) * 255);
  }
  updatePixels();
}










void keyPressed() {
  
  if (UpdateOnSpacePressed && key == ' ') UpdateGrid_SingleThreaded();
  
}
