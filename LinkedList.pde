class LinkedList<T>  {
  
  private Node start, cursor, end;
  
  LinkedList(T... t)  {
    for(int i=0; i<t.length; i++)  {
      add(t[i]);
    }
  }
  
  void add(T t)  {
    Node n = new Node(t);
    if  (start == null)  {
      start = n;
      cursor = n;
      end = n;
      
    }else  {
      Node n1 = cursor.next;
      cursor.next = n;
      n.prev = cursor;
      if  (n1 == null)  {
        end = n;
      }else  {
        n.next = n1;
        n1.prev = n;
      }
      cursor = n;
    }
  }
  
  void addPrev(T t)  {
    Node n = new Node(t);
    if  (start == null)  {
      start = n;
      cursor = n;
      end = n;
      
    }else  {
      Node n1 = cursor.prev;
      cursor.prev = n;
      n.next = cursor;
      if  (n1 == null)  {
        start = n;
      }else  {
        n.prev = n1;
        n1.next = n;
      }
      cursor = n;
    }
  }
  
  String toString()  {
    String s = "[";
    Node n = start;
    while(n != null)  {
      if  (n == cursor)  {
        s += " (" + n.value + ")";
      }else  {
        s += " " + n.value;
      }
      n = n.next;
    }
    s += " ]";
    return s;
  }
  
  int size()  {
    int size = 0;
    Node n = start;
    while(n != null)  {
      size++;
      n = n.next;
    }
    return size;
  }
  
  T getCurrentValue()  {
    return cursor.value;  
  }
  
  boolean moveNext()  {
    if  (cursor.next != null)  {
      cursor = cursor.next;
      return true;
    }else  {
      return false;
    }
  }
  
  boolean movePrev()  {
    if  (cursor.prev != null)  {
      cursor = cursor.prev;
      return true;
    }else  {
      return false;
    }
  }
  
  boolean moveToStart()  {
    if  (start != null)  {
      cursor = start;
      return true;
    }else  {
      return false;
    }
  }
  
  boolean moveToEnd()  {
    if  (end != null)  {
      cursor = end;
      return true;
    }else  {
      return false;
    }
  }
  
  LinkedList getClone()  {
    LinkedList l = new LinkedList();
    Node n = start;
    while(n != null)  {
      l.add(n.value);
      n = n.next;
    }
    return l;
  }
  
  private class Node  {
    Node prev;
    T value;
    Node next;
    
    Node(T value)  {
      this.value = value;
    }
  }
  
}
