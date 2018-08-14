float _cellSize_=6;
int _cellNum_=200;
Cell[][] _cells_=new Cell[_cellNum_][_cellNum_];

void setup() {
  size(1200, 1200);
  rectMode(CENTER);
  colorMode(HSB, 360, 100, 100, 100);

  frameRate(30);
  for (int i=0; i<_cellNum_; i++) {
    for (int j=0; j<_cellNum_; j++) {
      _cells_[i][j]=new Cell(width/2+_cellSize_*(i-_cellNum_/2), height/2+_cellSize_*(j-_cellNum_/2), _cellSize_, i, j, (int)random(2));
    }
  }
}

void draw() {
  background(0, 0, 0);

  for (int i=0; i<_cellNum_; i++) {
    for (int j=0; j<_cellNum_; j++) {
      _cells_[i][j].display();
      _cells_[i][j].behavior();
    }
  }

  for (int i=0; i<_cellNum_; i++) {
    for (int j=0; j<_cellNum_; j++) {
      _cells_[i][j].updateState();
    }
  }
}
