PImage original;
final int segmentL = 5;
Direction[] L1 = {Direction.Yp, Direction.Xp, Direction.Ym};

String fileName = "yenn_0.png";

int[] brightnessLevels = {255, 200, 125, 75, 25};
boolean enable_points = true;

void setup()  {
  size(720, 720);
  background(255);
  colorMode(HSB);
  //noSmooth();

  original = loadImage(fileName);
  
  LinkedList<Direction> l1 = new LinkedList(L1[0], L1[1], L1[2]);
  
  nextLevel(l1);
  nextLevel(l1);
  nextLevel(l1);
  nextLevel(l1);
  nextLevel(l1);
  nextLevel(l1);

  translate(40, 40);
  drawCurve(l1);
  
  if (enable_points) {
    save("hilbert_1_" + fileName);
  }else {
    save("hilbert_0_" + fileName);
  }
}

void drawCurve(LinkedList<Direction> l)  {
  l.moveToStart();
  Position currentPosition = new Position(0, 0);
  do {
    Position newPosition;
    switch(l.getCurrentValue())  {
      case Xp:  {
        newPosition = new Position(currentPosition.x + segmentL, 
          currentPosition.y);
        break;
      }
      case Xm:  {
        newPosition = new Position(currentPosition.x - segmentL, 
          currentPosition.y);
        break;
      }
      case Yp:  {
        newPosition = new Position(currentPosition.x, 
          currentPosition.y + segmentL);
        break;
      }
      case Ym:  {
        newPosition = new Position(currentPosition.x, 
          currentPosition.y - segmentL);
        break;
      }
      default:  {
        newPosition = new Position(currentPosition.x, 
          currentPosition.y);
      }
    }
    
    int pos1 = 128*(currentPosition.y/segmentL) 
      + (currentPosition.x/segmentL);
    int b1 = (int) brightness(original.pixels[pos1]);
    int w1;
    if(b1 >= brightnessLevels[0])  {
      w1 = 0;
    }else if(b1 >= brightnessLevels[1])  {
      w1 = 1;
    }else if(b1 >= brightnessLevels[2])  {
      w1 = 2;
    }else if(b1 >= brightnessLevels[3])  {
      w1 = 3;
    }else if(b1 >= brightnessLevels[4])  {
      w1 = 4;
    }else  {
      w1 = 5;
    }
    
    int pos2 = 128*(newPosition.y/segmentL) 
      + (newPosition.x/segmentL);
    int b2 = (int) brightness(original.pixels[pos2]);
    int w2;
    if(b2 >= brightnessLevels[0])  {
      w2 = 0;
    }else if(b2 >= brightnessLevels[1])  {
      w2 = 1;
    }else if(b2 >= brightnessLevels[2])  {
      w2 = 2;
    }else if(b2 >= brightnessLevels[3])  {
      w2 = 3;
    }else if(b2 >= brightnessLevels[4])  {
      w2 = 4;
    }else  {
      w2 = 5;
    }

    if (enable_points) {
      if(w2 > 1)  {
        noStroke();
        fill(0);
        ellipse(newPosition.x + 0.5, newPosition.y + 0.5, w2, w2);
      }
    }
    
    if(w1==0 && w2==0)  {
      noFill();
      stroke(255, 0, 200);
      line(currentPosition, newPosition);
      
    }else if((w1<=1) && (w2<=1))  {
      noFill();
      stroke(0);
      line(currentPosition, newPosition);
      
    }else if((w1<=1 && w2>1) || (w1>1 && w2<=1))  {
      noStroke();
      fill(0);
      if(l.getCurrentValue() == Direction.Xp || 
        l.getCurrentValue() == Direction.Xm)  {
        if(w1<=1)  {
          triangle(currentPosition.x + 0.5, currentPosition.y + 0.5, 
            newPosition.x + 0.5, newPosition.y + w2/2 + 0.5, 
            newPosition.x + 0.5, newPosition.y - w2/2 + 0.5);
            
        }else if(w2<=1)  {
          triangle(currentPosition.x + 0.5, currentPosition.y + w1/2 + 0.5, 
            currentPosition.x + 0.5, currentPosition.y - w1/2 + 0.5, 
            newPosition.x + 0.5, newPosition.y + 0.5);
        }
      }else  {
        if(w1<=1)  {
          triangle(currentPosition.x + 0.5, currentPosition.y + 0.5, 
            newPosition.x + w2/2 + 0.5, newPosition.y + 0.5, 
            newPosition.x - w2/2 + 0.5, newPosition.y + 0.5);
            
        }else if(w2<=1)  {
          triangle(currentPosition.x + w1/2 + 0.5, currentPosition.y + 0.5, 
            currentPosition.x - w1/2 + 0.5, currentPosition.y + 0.5, 
            newPosition.x + 0.5, newPosition.y + 0.5);
        }
      }
    }else  {
      noStroke();
      fill(0);
      if(l.getCurrentValue() == Direction.Xp || 
        l.getCurrentValue() == Direction.Xm)  {
        quad(currentPosition.x + 0.5, currentPosition.y - w1/2 + 0.5, 
          currentPosition.x + 0.5, currentPosition.y + w1/2 + 0.5, 
          newPosition.x + 0.5, newPosition.y + w2/2 + 0.5, 
          newPosition.x + 0.5, newPosition.y - w2/2 + 0.5);
          
      }else  {
        quad(currentPosition.x - w1/2 + 0.5, currentPosition.y + 0.5, 
          currentPosition.x + w1/2 + 0.5, currentPosition.y + 0.5, 
          newPosition.x + w2/2 + 0.5, newPosition.y + 0.5, 
          newPosition.x - w2/2 + 0.5, newPosition.y + 0.5);
      }
    }
    
    currentPosition = newPosition;
  }while(l.moveNext());
}

void nextLevel(LinkedList<Direction> l)  {
  LinkedList<Direction> l11 = l.getClone();
  
  l.moveToStart();
  l11.moveToEnd();
  do  {
    l.addPrev(l11.getCurrentValue().revOf().rotate270());
    l.moveNext();
  }while(l11.movePrev());
  
  l.addPrev(L1[0]);
  
  l.moveToEnd();
  l11.moveToStart();
  
  l.add(L1[1]);
  
  do  {
    l.add(l11.getCurrentValue());
  }while(l11.moveNext());
  
  l.add(L1[2]);
  
  l11.moveToEnd();
  do  {
    l.add(l11.getCurrentValue().revOf().rotate90());
  }while(l11.movePrev());
  
  l.moveToStart();
}

void line(Position p1, Position p2)  {
  line(p1.x + 0.5, p1.y + 0.5, p2.x + 0.5, p2.y + 0.5);
}