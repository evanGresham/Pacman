class Pacman {
  PVector pos;
  PVector vel = new PVector(-1, 0);
  PVector turnTo = new PVector(-1, 0);
  boolean turn = false;
  int score = 0;
  Pacman() {
    pos = new PVector(13*16+8, 23*16 +8);
  }


  void show() {
    ellipse(pos.x, pos.y, 20, 20);
  }



  void move() {
    if (checkPosition()) {
      pos.add(vel);
    }
  }



  //-------------------------------------------------------------------------------------------------------------------------------------------------

  boolean checkPosition() {
    if ((pos.x-8)%16 == 0 && (pos.y - 8)% 16 ==0) {//if on a critical position

      PVector matrixPosition = new PVector((pos.x-8)/16, (pos.y - 8)/16);//convert position to an array position
      //pacmanNode = new Node(matrixPosition.x, matrixPosition.y);
      //for (int i = 90; i < nodes.size(); i++) {
      //  nodes.get(i).checkIfEdgeWithPacman();
      //}
      //start = nodes.get(1);
      //end = pacmanNode;
      findPacman();

     // println(pacmanNode.x, pacmanNode.y);
      if (!tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].eaten ) {
        tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].eaten =true;
        score +=1;
        //println("Score:", score);
      }
      PVector positionToCheck= new PVector(matrixPosition.x + turnTo.x, matrixPosition.y+ turnTo.y); // the position in the array that the player is turning towards

      if (tiles[floor(positionToCheck.y)][floor(positionToCheck.x)].wall) {//check if there is a free space in the direction that it is going to turn
        if (tiles[floor(matrixPosition.y + vel.y)][floor(matrixPosition.x + vel.x)].wall) {//if not check if the path ahead is free
          return false;//if neither are free then dont move
        } else {//forward is free
          return true;
        }
      } else {//free to turn
        vel = new PVector(turnTo.x, turnTo.y);
        return true;
      }
    } else {
      if ((pos.x+10*vel.x-8)%16 == 0 && (pos.y + 10*vel.y - 8)% 16 ==0) {//if 10 places off a critical position in the direction that pacman is moving
        PVector matrixPosition = new PVector((pos.x+10*vel.x-8)/16, (pos.y+10*vel.y-8)/16);//convert position to an array position
        if (!tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].eaten ) {//if that tile has not been eaten 
          tiles[floor(matrixPosition.y)][floor(matrixPosition.x)].eaten =true;//eat it
          score +=1;
          println("Score:", score);
        }
      }
      if (turnTo.x + vel.x == 0 && vel.y + turnTo.y ==0) {//if turning chenging directions entirely i.e. 180 degree turn
        vel = new PVector(turnTo.x, turnTo.y);//turn
        return true;
      }
      return true;//if not on a critical postion then no sweat
    }

    //is on critical point
    //get the positon
  }
}