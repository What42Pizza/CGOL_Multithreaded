volatile int CurrThreadID = -1;

volatile int FinishedThreads = 0;

volatile int UpdateNum = 0;





void LaunchThreads() {
  //CurrThreadID = -1;
  for (int i = 0; i < NumOfThreads; i ++) {
    println ("Launching thread " + i);
    thread ("UpdateThreadFunction");
  }
  while (CurrThreadID < NumOfThreads - 1) DoBusyWork();
}



void UpdateThreadFunction() {
  int ThreadID = GetThreadID(); // Incs CurrThreadID
  println ("Thread " + ThreadID + " started");
  int LastSeenUpdateNum = 0;
  while (true) {
    //println ("Waiting...");
    while (UpdateNum == LastSeenUpdateNum) DoBusyWork(); // Breaks when different
    LastSeenUpdateNum = UpdateNum;
    for (int i = ThreadID; i < GridLength; i += NumOfThreads) {
      UpdateCell (i);
    }
    IncFinishedThreads();
  }
}





synchronized int GetThreadID() {
  CurrThreadID ++;
  return CurrThreadID;
}



synchronized void IncFinishedThreads() {
  FinishedThreads ++;
}



void DoBusyWork() { // wait ~1 microsecond
  long StartNanoTime = System.nanoTime();
  while (System.nanoTime() - StartNanoTime < 1000) {
    byte Void = -128;
    while (Void < 127) Void ++;
  }
  //println ("Waited for " + (System.nanoTime() - StartNanoTime) + " nanoseconds");
}
