volatile int CurrThreadID = -1;

volatile int FinishedThreads = 0;



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
}
