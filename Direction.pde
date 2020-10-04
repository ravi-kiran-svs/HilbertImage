enum Direction  {
  Xp, Yp, Xm, Ym;
  
  Direction revOf()  {
    switch(this)  {
      case Xp:
        return Xm;
      case Yp:
        return Ym;
      case Xm:
        return Xp;
      case Ym:
        return Yp;
      default:
        return null;
    }
  }
  
  Direction rotate90()  {
    switch(this)  {
      case Xp:
        return Yp;
      case Yp:
        return Xm;
      case Xm:
        return Ym;
      case Ym:
        return Xp;
      default:
        return null;
    }
  }
  
  Direction rotate180()  {
    switch(this)  {
      case Xp:
        return Xm;
      case Yp:
        return Ym;
      case Xm:
        return Xp;
      case Ym:
        return Yp;
      default:
        return null;
    }
  }
  
  Direction rotate270()  {
    switch(this)  {
      case Xp:
        return Ym;
      case Yp:
        return Xp;
      case Xm:
        return Yp;
      case Ym:
        return Xm;
      default:
        return null;
    }
  }
}
