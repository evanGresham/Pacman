//464 × 512
import java.util.Deque;
import java.util.Iterator;
import java.util.LinkedList;

ArrayList<Node> nodes = new ArrayList<Node>();
Pacman pacman;
PImage img;
Node start;
Node end;
boolean searched = false;
int timer;
Path bestPath;
LinkedList<Path> big = new LinkedList<Path>();//stores all paths
Path extend = new Path(); //used to extend paths
Path finalPath = new Path();  //the final path
Path winningPath = new Path();  //the final path
Path extended = new Path(); //the extended path
LinkedList<Path> sorting = new LinkedList<Path>();///used for sorting paths
//Node pacmanNode = new Node(23,13);
Ghost ghost1 = new Ghost();

Tile[][] tiles = new Tile[31][28]; //note it goes y then x
int[][] tilesRepresentation = {
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 8, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 8, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 6, 1, 1, 6, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 6, 1, 1, 6, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 6, 6, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 6, 6, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 0, 1, 1, 1, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1}, 
  {1, 8, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 8, 1}, 
  {1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1}, 
  {1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1}, 
  {1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}};

void setup() {
  frameRate(100);
  size(448, 496);
  img = loadImage("map.jpg");
  //initiate tiles
  for (int i = 0; i< 28; i++) {
    for (int j = 0; j< 31; j++) {
      tiles[j][i] = new Tile(16*i +8, 16*j+8);
      switch(tilesRepresentation[j][i]) {
      case 1:
        tiles[j][i].wall = true;
        break;
      case 0:
        tiles[j][i].dot = true;
        break;
      case 8:
        tiles[j][i].bigDot = true;
        break;
      }
    }
  }

  pacman = new Pacman();
  setNodes();
  start = nodes.get(1);
  end = nodes.get(nodes.size() -1);// pacman 
  bestPath = AStar(start, end);
}

void draw() {
  image(img, 0, 0);
  stroke(255);

  for (int i = 0; i< 28; i++) {
    for (int j = 0; j< 31; j++) {
      tiles[j][i].show();
    }
  }
  pacman.move();
  
    bestPath.show();
  pacman.show();
  ghost1.show();

  //for (int i = 0; i< nodes.size(); i++) {
  //  nodes.get(i).show();
  ////  pacmanNode.show();
  //}





}

void keyPressed() {
  switch(key) {
  case CODED:
    switch(keyCode) {
    case UP:
      pacman.turnTo = new PVector(0, -1);
      pacman.turn = true;
      break;
    case DOWN:
      pacman.turnTo = new PVector(0, 1);
      pacman.turn = true;
      break;
    case LEFT:
      pacman.turnTo = new PVector(-1, 0);
      pacman.turn = true;
      break;
    case RIGHT:
      pacman.turnTo = new PVector(1, 0);
      pacman.turn = true;
      break;
    }
  }
}

PVector convertTileLocationToCoords(int x, int y) {
  return new PVector(8+16*x, 8 + 16*y);
}

Tile getNearestTile(float x, float y) {
  println(x, y);
  println(floor((y+8)/16.0), floor((x+8)/16.0));
  println(tiles[floor((y+8)/16.0)][floor((x+8)/16.0)].wall);
  return tiles[floor((y+8)/16.0)][floor((x+8)/16.0)];
}



void setNodes() {
  for (int i = 1; i< 27; i++) {//check every position
    for (int j = 1; j< 30; j++) {
      //if there is a space up or below and a space left or right then this space is a node
      if (!tiles[j][i].wall) {
        if (!tiles[j-1][i].wall || !tiles[j+1][i].wall) { //check up for space
          if (!tiles[j][i-1].wall || !tiles[j][i+1].wall) {//check left and right for space

            nodes.add(new Node(i, j));
          }
        }
      }
    }
  }
  
  nodes.add(new Node((pacman.pos.x-8) / 16,(pacman.pos.y-8)/16));
  for (int i = 0; i< nodes.size(); i++) {
    nodes.get(i).addEdges();
    //nodes.get(i).checkIfEdgeWithPacman();
  }
  
}

Path AStar(Node start, Node finish)
{
  //clear everything

  extend.clear();
  extended.clear();
  sorting.clear();
  big.clear();
  winningPath.clear();
  searched = true;
  //startin off with big storing a path with only the starting node
  extend.addToTail(start);
  big.add(extend);
  boolean winner = false;
  while (true) //repeat the process until ideal path is found
  {
    extend = big.pop();//grab the front path form the big to be extended
    if (extend.path.getLast().equals(finish)) //if goal found
    {
      if (!winner) //if first goal found, set winning path
      {
        winner = true;
        winningPath = extend.clone();
      } else { //if winning path already found and the distance of the current path is less the previous winning path then set this path as the winning path  
        if (winningPath.distance > extend.distance)
        {
          winningPath = extend.clone();
        }
      }
      if (big.isEmpty()) //if this extend is the last path then return the winning path
      {
        return winningPath.clone();
      } else {//if not the current extend is useless to us as it cannot be extended since its finished
        extend = big.pop();
      }
    } 

    //if the node has already been checked and is the larger than the smallest to that point then fuck it
    if (!extend.path.getLast().checked || extend.distance < extend.path.getLast().smallestDistToPoint)//checks last node of the path to see if its already been extended if it has then we can ditch it 
    {     
      if (!winner || extend.distance + dist(extend.path.getLast().x, extend.path.getLast().y, end.x, end.y)  < winningPath.distance) //dont look at paths that are longer than a path which has already reached the goal
      {
        //delay(10);

        extend.path.getLast().smallestDistToPoint = extend.distance;

        //move all paths to sorting form big then add the new paths (in the for loop)and sort them back into big.
        sorting = (LinkedList)big.clone();
        Node tempN = new Node(0, 0);
        if (extend.path.size() >1) {
          tempN = extend.path.get(extend.path.size() -2);
        }

        for (int i =0; i< extend.path.getLast().edges.size(); i++) //for each node incident to the final node of the path to be extended 
        {
          if (tempN != extend.path.getLast().edges.get(i))//if not going backwards ,the new node is not the node directly behind it 
          {      
            extended = extend.clone();
            extended.addToTail(extend.path.getLast().edges.get(i));
            sorting.add(extended.clone());//add this extended list to the list of paths to be sorted
          }
        }


        //sorting now contains all the paths form big plus the new paths
        //adding the path which has the higest distance to big first.
        //using selection sort i.e. the easiest and worst sorting algorithm
        big.clear();
        while (!sorting.isEmpty())
        {
          float max = -1;
          int iMax = 0;
          for (int i = 0; i < sorting.size(); i++)
          {
            if (max < sorting.get(i).distance + sorting.get(i).distToFinish)//A*
            {
              iMax = i;
              max = sorting.get(i).distance + sorting.get(i).distToFinish;
            }
          }
          big.addFirst(sorting.remove(iMax).clone());
        }
      }
      extend.path.getLast().checked = true;
    }
    //if no more paths avaliable
    if (big.isEmpty()) {
      if (winner ==false) //FUCKKKK
      {
        Path fucked = new Path();
        //print("FUCK!!!!!!!!!!");
        return fucked;
      } else {//Nice
        return winningPath.clone();
      }
    }
  }
}
  void findPacman(){
      nodes.clear();
      setNodes();
      start = nodes.get(0);
      end = nodes.get(nodes.size()-1);
      bestPath = AStar(start, end);
  }
  