// Created 03/06/21





// Settings

final int GridWidth = 512;
final int GridHeight = 512;

final int NumOfThreads = 6; // (6) Gives down to ~ 2.6-2.7 ms (average)

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
  
  size (512, 512);
  frameRate (60);
  
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
  println ("Time taken (microseconds):");
  println ("Update: " + UpdateNano / 1000 + "; Average: " + (TotalUpdateNano / frameCount / 1000));
  println ("Render: " + RenderNano / 1000 + "; Average: " + (TotalRenderNano / frameCount / 1000));
  println ("Total: "  + (UpdateNano + RenderNano) / 1000 + "; Average: " + ((TotalUpdateNano + TotalRenderNano) / frameCount / 1000));
  
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
