class Cell {
  float x, y; //coordinate
  float s; //cell size
  float beforeState;
  float state; //0 or 1(dead or alive)
  int cx, cy; //coordinate as of cell

  boolean mousePressFlag;
  float waitTime;

  float col;
  int alpha;

  Cell(float x, float y, float s, int cx, int cy, int state) {
    this.x=x;
    this.y=y;
    this.s=s;
    this.cx=cx;
    this.cy=cy;
    this.state=state;
    beforeState=state;

    mousePressFlag=false;
    waitTime=0;

    col=random(360);
    alpha=0;
  }

  void display() {
    noStroke();

    fill(col, 50, 100, state==0?0:20);
    rect(x, y, s, s);

    fill(col, 50, 100, alpha);
    ellipse(x, y, s, s);
  }

  void updateState() {
    beforeState=state;
  }

  void behavior() {
    //If you clicked mouse in block range, state change to 1.
    /*if (mousePressed&&mousePressFlag==false) {
      if (mouseX>x-s/2&&mouseX<x+s/2) {
        if (mouseY>y-s/2&&mouseY<y+s/2) {
          state=1;
          alpha+=10;

          mousePressFlag=true;
          return;
        }
      }
    }

    if (mousePressFlag) {
      waitTime++;
      if (waitTime>=10) {
        waitTime=0;
        mousePressFlag=false;
      }
    }*/
    
    if(alpha>=200){
      alpha=200;
    }
    
    if(alpha<=-100){
      alpha=-100;
    }
    
    if(mousePressed){
      state=(int)random(2);
      beforeState=state;
      alpha=0;
    }

    int stateFeatureCount=0;
    int modificationCx=-1;
    int modificationCy=-1;

    for (int i=-1; i<2; i++) {
      for (int j=-1; j<2; j++) {
        if (!(i==0&&j==0)) {

          modificationCx=cx+i;
          if (modificationCx<0) {
            modificationCx=_cellNum_-1;
          }

          if (modificationCx>_cellNum_-1) {
            modificationCx=0;
          }

          modificationCy=cy+j;
          if (modificationCy<0) {
            modificationCy=_cellNum_-1;
          }

          if (modificationCy>_cellNum_-1) {
            modificationCy=0;
          }

          if (_cells_[modificationCx][modificationCy].beforeState==1) {
            stateFeatureCount++;
          }
        }
      }
    }

    if (state==0) {
      //birth
      if (stateFeatureCount==3) {
        state=1;
        alpha+=10;
        return;
      } else {
        state=0;
        alpha-=5;
        return;
      }
    }

    if (state==1) {
      //live
      if (stateFeatureCount>=2&&stateFeatureCount<=3) {
        state=1;
        alpha+=10;
        return;
      }

      //depopulation
      if (stateFeatureCount<=1) {
        state=0;
        alpha-=5;
        return;
      }

      //overcrowding
      if (stateFeatureCount>=4) {
        state=0;
        alpha-=5;
        return;
      }
    }
  }
}
