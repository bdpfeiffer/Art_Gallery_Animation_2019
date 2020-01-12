

class earTriangulation{
  
  ArrayList<Point> p     = new ArrayList<Point>();
  ArrayList<Edge>  bdry = new ArrayList<Edge>();
  
  earTriangulation( ){ }
  
  void draw(int counter, ArrayList<Edge> edges, ArrayList<Point> points){
    //print("reached");
    p = points;
    //print(edges.size());
    ArrayList<Edge> bdry = edges;
    noFill();
    stroke(100);
    for( Edge e : bdry ){
      e.draw();
    }
     /*
     for(int i = 0, j = 0; i < bdry.size(); i++, j++){
       if(j < counter){
         strokeWeight(8);
         stroke(62, 115, 255);
       }
       else{
         strokeWeight(3);
         stroke(100);
       }
       bdry.get(i).draw();
  
    }*/
  }
  
  void getBoundary(ArrayList<Edge> edges){
   for(int i = 0; i < edges.size(); i++){
     
   }
  }
  
}
