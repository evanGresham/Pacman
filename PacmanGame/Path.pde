class Path {
  LinkedList<Node> path = new LinkedList<Node>();
  float distance = 0;
  float distToFinish =0;

  Path() {
  }

  void addToTail(Node n)
  {
    if (!path.isEmpty())
    {
      distance += dist(path.getLast().x, path.getLast().y, n.x, n.y);
    }

    path.add(n);
    distToFinish = dist(path.getLast().x,path.getLast().y,end.x, end.y);
  }

  Path clone()
  {
    Path temp = new Path();
    temp.path = (LinkedList)path.clone();
    temp.distance = distance;
    temp.distToFinish = distToFinish;
    return temp;
  }
  void clear()
  {
    distance =0;
    distToFinish = 0;
    path.clear();
  }
  
  
  void show(){
    stroke(200);
   for(int i = 0; i< path.size()-1;i++){
    line(path.get(i).x*16 +8 ,path.get(i).y*16 +8 ,path.get(i+1).x*16 +8, path.get(i+1).y*16 +8);// path.get(i).x 
     
   }
    
   //println("from 4 -> 16:");
   //for(int i = 0; i< path.size();i++){
   //  println(path.get(i).x, path.get(i).y); 
     
   //}
    
  }
}