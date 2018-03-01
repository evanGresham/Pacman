class Node {
  LinkedList<Node> edges = new LinkedList<Node>();

  float x;
  float y;
  float smallestDistToPoint = 10000000;
  int degree;
  int value;  
  boolean checked = false;

  Node(float x1, float y1) {
    x = x1;
    y = y1;
  }

  void show() {
    fill(0, 100, 100);
    ellipse(x*16 +8, y*16 +8, 10, 10 );
    //for (int i = 0; i < edges.size(); i++) {

    //    fill(200);
    //    stroke(200);
    //    line(x*16+8, y*16+8, edges.get(i).x*16+8, edges.get(i).y*16+8);
      
    //}
  }

//  void checkIfEdgeWithPacman() {
//    println("HERE");
//    if (pacmanNode.y == y ^ pacmanNode.x == x) {//if thw pacman is either horrizontally inline or vertically inline but not both
//      boolean edge = true;
//      PVector moveDirection = new PVector(pacmanNode.x-x, pacmanNode.y-y);//move direction
//      moveDirection.limit(1);
//      println("lookHere",moveDirection);
//      PVector checkPos = new PVector(x+moveDirection.x, y + moveDirection.y);
//      while (checkPos.x != pacmanNode.x && checkPos.y != pacmanNode.y) {
//        if (tiles[(int)checkPos.y][(int)checkPos.x].wall) {
//          edge = false;
//          break;
//        }
//         checkPos.add(moveDirection);
//      }

//      if (edge) {
//        if (edges.contains(pacmanNode)) {
//        } else {
//          edges.add(pacmanNode);
//        }
//      }
//    } else {
//      println("this is pacmanNode",pacmanNode.x,pacmanNode.y);
//      println("this is node",x,y);
//      if (edges.contains(pacmanNode)) {
//        edges.remove(pacmanNode);
//      }
//    }
//  }








  //      if ( <0)
  //      }

  //      if (pacmanNode.y == y) {//if horizontally in line with pacman
  //        float mostLeft = min(pacmanNode.x, x) + 1;//position to check
  //        boolean edge = true;//is this node an edge to pacman

  //        //now 
  //        float moveDirection;
  //        if (p
  //          moveDirection
  //      }

  //    while (pacmanNode.x != mostLeft && x != mostLeft) {//while not on pacman or the 
  //      if (tiles[(int)y][(int)mostLeft].wall) {
  //        edge = false;
  //        break;
  //      }
  //      mostLeft ++;
  //    }

  //    if (edge) {
  //      if (edges.contains(pacmanNode)) {
  //      } else {
  //        edges.add(pacmanNode);
  //      }
  //    }
  //  } else if (pacmanNode.x == x) {
  //  float mostLeft = min(pacmanNode.y, y) + 1;
  //  boolean edge = true;
  //  while (pacmanNode.y != mostLeft && y != mostLeft) {
  //    if (tiles[(int)mostLeft][(int)x].wall) {
  //      edge = false;
  //      break;
  //    }
  //    mostLeft ++;
  //  }

  //  if (edge) {
  //    if (edges.contains(pacmanNode)) {
  //    } else {
  //      edges.add(pacmanNode);
  //    }
  //  }
  //} else {
  //  if (edges.contains(pacmanNode)) {
  //    edges.remove(pacmanNode);
  //  }
  //}
  //}











  void addEdges() {
    for (int i =0; i < nodes.size(); i++) {
      if (nodes.get(i).y == y) {
        float mostLeft = min(nodes.get(i).x, x) + 1;
        boolean edge = true;
        while (nodes.get(i).x != mostLeft && x != mostLeft) {
          if (tiles[(int)y][(int)mostLeft].wall) {
            edge = false;
            break;
          }
          //if (mostLeft == pacmanNode.x && nodes.get(i).y == pacmanNode.y) {
          //  edges.add(pacmanNode);
          //  println(123);
          //  edge = false;
          //  break;
          //}
          mostLeft ++;
        }
        if (edge) {
          edges.add(nodes.get(i));
        }
      } else if (nodes.get(i).x == x) {// ^ nodes.get(i).y == y){
        float mostUp = min(nodes.get(i).y, y) + 1;
        boolean edge = true;
        while (nodes.get(i).y != mostUp && y != mostUp) {
          if (tiles[(int)mostUp][(int)x].wall) {
            edge = false;
            break;
          }
          //if (nodes.get(i).x == pacmanNode.x && mostUp == pacmanNode.y) {
          //  edges.add(pacmanNode);
          //  edge = false;
          //  break;
          //}
          mostUp ++;
        }
        if (edge) {
          edges.add(nodes.get(i));
        }
      }
    }
  }
}