void UpdateGrid_SingleThreaded() {
  Buffer = new byte [GridLength];
  for (int i = 0; i < GridLength; i ++) {
    UpdateCell (i);
  }
  Grid = Buffer;
}



void UpdateGrid_MultiThreaded() {
  Buffer = new byte [GridLength];
  FinishedThreads = 0;
  UpdateNum ++;
  while (FinishedThreads < NumOfThreads) DoBusyWork();
  Grid = Buffer;
}





void UpdateCell (int CellNum) {
  
  // Count neighbors
  int XPos = CellNum % GridWidth;
  int YPos = CellNum / GridWidth;
  int YIndex = YPos * GridWidth;
  int LeftPos   = (XPos - 1 + GridWidth ) % GridWidth;
  int RightPos  = (XPos + 1             ) % GridWidth;
  int UpIndex   = (YPos - 1 + GridHeight) % GridHeight * GridWidth;
  int DownIndex = (YPos + 1             ) % GridHeight * GridWidth;
  int Neighbors = 0;
  Neighbors += Grid[LeftPos  + UpIndex  ];
  Neighbors += Grid[XPos     + UpIndex  ];
  Neighbors += Grid[RightPos + UpIndex  ];
  Neighbors += Grid[LeftPos  + YIndex   ];
  Neighbors += Grid[RightPos + YIndex   ];
  Neighbors += Grid[LeftPos  + DownIndex];
  Neighbors += Grid[XPos     + DownIndex];
  Neighbors += Grid[RightPos + DownIndex];
  
  // Apply rules
  switch (Neighbors) {
    case (2):
      Buffer [CellNum] = Grid [CellNum];
      break;
    case (3):
      Buffer [CellNum] = 1;
      break;
    default:
      //Buffer [CellNum] = 0; 
      break;
  }
  
}
