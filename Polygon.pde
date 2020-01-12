

class Polygon {
  
   ArrayList<Point> p     = new ArrayList<Point>();
   ArrayList<Edge>  bdry = new ArrayList<Edge>();
   ArrayList<Point>    newPoints  = new ArrayList<Point>();
   ArrayList<Edge>     newEdges   = new ArrayList<Edge>();
   ArrayList<Triangle> removedEars    = new ArrayList<Triangle>();
   ArrayList<Point>    nodes      = new ArrayList<Point>();
   int counter = 0;
   int counterTracker = 0;
     
   Polygon( ){  }
   
   
   boolean isClosed(){ return p.size()>=3; }
   
   
   boolean isSimple(){
     // TODO: Check the boundary to see if it is simple or not.
     ArrayList<Edge> bdry = getBoundary();
     Edge tempBdry, tempBdry2;
     Boolean flag;
     flag = false;
     if (isClosed()){
        flag = true; 
     }
     for (int i = 0; i < bdry.size(); i++){
       for (int j = i + 1; j < bdry.size(); j++){
         tempBdry = bdry.get(i);
         tempBdry2 = bdry.get(j);
         if (tempBdry.intersectionTest(tempBdry2)){
           flag = false;
         }
       }
     }
     
     if (flag){
       return flag; 
     }
     else{
     return false;
     }
   }
   
   
   boolean pointInPolygon( Point p ){
     // TODO: Check if the point p is inside of the 
     ArrayList<Edge> bdry = getBoundary();
     
     //inside if and only if it makes a non-left turn for every edge (in ccw direction) or vice versa
     Edge tempBdry;
     Triangle tempTri;
     Point p0,p1;
     Point p2 = p;
     int ccwCount = 0;
     int cwCount = 0;
     Point mid, maxup,maxdown;
     Edge ray,ray2;
     float slope;
     maxup = new Point (p.getX(), height);
     maxdown = new Point (p.getX(), 0);
          //slope = 
     ray2 = new Edge(p, maxdown);
     ray = new Edge (p, maxup);
     int count = 0;
     for (int i = 0; i < bdry.size(); i++){
          tempBdry = bdry.get(i);
          if (ray.intersectionTest(tempBdry)){
            count++;
          }
   
     }
     
     if(count == 0){
        for (int i = 0; i < bdry.size(); i++){
          tempBdry = bdry.get(i);
          if (ray2.intersectionTest(tempBdry)){
            count++;
          }
   
     }
     }
     
     if (count%2 == 0){
       return false;
     }
     else if (count%2 != 0){
        return true; 
     }
     else{
      return false; 
     }
     //something is wrong either here or at getDiagonals()
   }
   
   /*
   ArrayList<Edge> getDiagonals(){
     // TODO: Determine which of the potential diagonals are actually diagonals
     ArrayList<Edge> bdry = getBoundary();
     ArrayList<Edge> diag = getPotentialDiagonals();
     ArrayList<Edge> ret  = new ArrayList<Edge>();
 
     ret = diag;
     
     Edge tempBdry, tempBdry2;
     //List nonDiag = new ArrayList();
     Point middle;
 
     for (int i = ret.size() - 1; i >= 0; i--){
       for (int j = 0; j < bdry.size(); j++){
         tempBdry = ret.get(i);
         tempBdry2 = bdry.get(j);
         middle = tempBdry.midpoint(); //|| pointInPolygon(middle)
         if (tempBdry2.intersectionTest(tempBdry)){
          ret.remove(tempBdry);
          break;
         }
         if (!pointInPolygon(middle)){
          ret.remove(tempBdry);
          break;
         }
       }
     }

     return ret;
     //something is wrong either here or at PointInPolygon()
   }
   */
   
   boolean isValidDiagonal(Edge e){
     Point middle = e.midpoint();
     if(!pointInPolygon(middle)){
       //print("returning false");
        return false; 
     }
     for(int i = 0; i < bdry.size(); i++){
       if(bdry.get(i).intersectionTest(e)){ //intersection test returns true if it does intersect
          return false; 
       }       
     }
    return true; //return true if valid diagonal
   }
   
   boolean ccw(){
     // TODO: Determine if the polygon is oriented in a counterclockwise fashion
     if( !isClosed() ) return false;
     if( !isSimple() ) return false;
     
     ArrayList<Edge> bdry = getBoundary();
     Edge tempBdry;
     float x0, x1, y0, y1;
     float sum = 0;
     for (int i = 0; i < bdry.size(); i++){
          tempBdry = bdry.get(i);
          x0 = tempBdry.p0.getX();
          x1 = tempBdry.p1.getX();    
          y0 = tempBdry.p0.getY();
          y1 = tempBdry.p1.getY();
          sum += (x1-x0)*(y1+y0);
     }
     
     if (sum <0){
      return true; 
     }
     else{
     return false;
     }
   }
   
   
   boolean cw(){
     // TODO: Determine if the polygon is oriented in a clockwise fashion
     if( !isClosed() ) return false;
     if( !isSimple() ) return false;
     
     ArrayList<Edge> bdry = getBoundary();
     Edge tempBdry;
     float x0, x1, y0, y1;
     float sum = 0;
     for (int i = 0; i < bdry.size(); i++){
          tempBdry = bdry.get(i);
          x0 = tempBdry.p0.getX();
          x1 = tempBdry.p1.getX();    
          y0 = tempBdry.p0.getY();
          y1 = tempBdry.p1.getY();
          sum += (x1-x0)*(y1+y0);
     }
     
     if (sum >0){
      return true; 
     }
     else{
     return false;
     }
   }
      
   
   
   
   ArrayList<Edge> getBoundary(){
     return bdry;
   }
   
   ArrayList<Edge> getNewEdges(){
     return newEdges; 
   }
   
   ArrayList<Point> getPoints(){
     return p; 
   }
   
   ArrayList<Point> getNewPoints(){
     return newPoints; 
   }

   ArrayList<Edge> getPotentialDiagonals(){
     ArrayList<Edge> ret = new ArrayList<Edge>();
     int N = p.size();
     for(int i = 0; i < N; i++ ){
       int M = (i==0)?(N-1):(N);
       for(int j = i+2; j < M; j++ ){
         ret.add( new Edge( p.get(i), p.get(j) ) );
       }
     }
     return ret;
   }
   
   void readyToBegin(){
     ArrayList<Edge> bdry = getBoundary();
     ArrayList<Edge> newEdges = getNewEdges();
     ArrayList<Point> p = getPoints();
     ArrayList<Point> newPoints = getNewPoints();
     
     for(int i = 0; i < bdry.size(); i++){
        newEdges.add(bdry.get(i));
     }
     for(int i = 0; i < p.size(); i++){
        newPoints.add(p.get(i));
     }
   }

   void triangulation(int polyCounter){
     
     //ArrayList<Edge> diag = getPotentialDiagonals();
     boolean triangulationDone = false;
     int triangulationCounter = 0;
     boolean diagonalDecision = false;
     boolean traversedOnce = false;
     boolean traversed = false;
     Point focalPoint;
     Point tempPoint;
     int timesTraversed = 0;
     //print("\npolyCounter: " + polyCounter);
     //println("\ncounterTracker: " + counterTracker);
     //println("\ncounter: " + counter);
     if(counterTracker != polyCounter){
      counter += 1;
      counterTracker = polyCounter;
     }
     
     for(int i = 0, j = 0; i < newEdges.size() && j < newEdges.size(); i++){
       //if(!traversedOnce){
        //stroke(0);
        //fill(0);
        focalPoint = newEdges.get(newEdges.size()-1).p0; 
        //focalPoint.highlight();
       j = (counter - 1) / 6;
       tempPoint = newEdges.get(j).p1;
       //stroke(255, 178, 246);
       //fill(255, 178, 246);
       //tempPoint.highlight();
       if(tempPoint == focalPoint){
        traversed = true; 
       }
       Edge e;

       /*if(i == 0){
          newEdges.get(i).draw();
          newEdges.get(newEdges.size() - 1).draw();
       }
       else{
          newEdges.get(i).draw();
          newEdges.get(i-1).draw();  
       }*/
       strokeWeight(3);
       stroke(100);
       draw();
       if(removedEars.size() > 0){
          for(int k = 0; k < removedEars.size(); k++){
           strokeWeight(3);
           stroke(100);
           fill(232);
           removedEars.get(k).draw();
           if(removedEars.size() == (newEdges.size() - 2)){
             triangulationDone = true;
           }
          }
       }
         triangulationCounter = ((counter - 1) % 6) + 1;
         if(triangulationCounter == 5){
            triangulationCounter = 4;
            diagonalDecision = true;
         }
         if(j == 0){
           e = new Edge(newEdges.get(newEdges.size()-1).p0, newEdges.get(j).p1);
         }
         else{
           //println("\nJ: " + j);
           e = new Edge(newEdges.get(j-1).p0, newEdges.get(j).p1);
        }
         switch(triangulationCounter){
            case 6: if(isValidDiagonal(e) && j == 0){
                      removeEar(newEdges.get(j).p0, e, j, newEdges.size()-1, newEdges.get(newEdges.size()-1), newEdges.get(j));
                    }
                    else if(isValidDiagonal(e)){
                      removeEar(newEdges.get(j).p0, e, j, j-1, newEdges.get(j-1), newEdges.get(j)); 
                    }
                    break;
            case 4: if(diagonalDecision == true){
                      if(isValidDiagonal(e)){ //returns true if valid
                        fill(16, 255, 5); // GREEN
                        stroke(16, 255, 5);
                      }
                      else{
                        fill(232, 0, 19); // RED
                        stroke(232, 0, 19);
                      }
                      e.draw();
                      diagonalDecision = false;
                    }
                    else {
                      e.drawDotted(); 
                    }
            case 3: stroke(255, 72, 235);
                    fill(255, 72, 235);
                    strokeWeight(8);
                    newEdges.get(j).draw();
            case 2: stroke(255, 72, 235);
                    fill(255, 72, 235);
                    strokeWeight(8);
                    if(j == 0){
                        newEdges.get(newEdges.size() - 1).draw();
                    }
                    else{
                        newEdges.get(j-1).draw();
                    }
            case 1: stroke(72, 255, 223);
                    fill(72, 255, 223);
                    newEdges.get(j).p0.highlight();
                    break;  
            default: break;
         }        
       if(triangulationDone){
        print("\nTRIANGULATION IS DONE!\n"); 
        break;
       }
       if(traversed && (triangulationCounter >= 6)){
         j = 0;
         counter = 1;
         traversed = false;
         print("\nTRAVERSED");
       }
       if(j == (newEdges.size() - 1) && (triangulationCounter >= 0)){
        j = 0; 
        counter = 1;
       }
     }
     
     //Drawing the node Points
     if(triangulationDone){
       stroke(255, 178, 246);
       fill(255, 178, 246);
       println("\nremoved ears: \n" + removedEars);
       for(int i = 0; i < removedEars.size(); i++){
         nodes.add(i, removedEars.get(i).node());
         nodes.get(i).highlight();
       }
       
     }
     
   }
   
   void draw(){
     strokeWeight(3);
     stroke(100);
     for(int i = 0; i < bdry.size(); i++){
       if(i == 0){
         bdry.get(i).draw();
         bdry.get(bdry.size() - 1).draw();
       }
       else{
         bdry.get(i).draw();
         bdry.get(i-1).draw();  
       }       
     }
   }
   
   void removeEar(Point p, Edge e, int j, int k, Edge r1, Edge r2){
     Triangle t = new Triangle(e.p0, p, e.p1);
     boolean flag = false;
     for(int i = 0; i < removedEars.size(); i++){
      if(removedEars.get(i).ifIdentical(t)){
        flag = true;
      }
     }
     
     if(!flag){
       removedEars.add(t);
       Edge leftEdge = newEdges.get(j);
       Edge rightEdge = newEdges.get(k);
       for(int i = 0; i < newEdges.size(); i++){
         //print("\n");
         //println("Compare j, i at " + i + " set to e...  j: " + leftEdge + "  i: " + newEdges.get(i) + "  e: " + e);
         if(leftEdge.ifIdentical(newEdges.get(i))){
           newEdges.set(i, e);
         }
         //println("Compare k, i at " + i + " set to e...  k: " + rightEdge + "  i: " + newEdges.get(i) + "  e: " + e);
         if(rightEdge.ifIdentical(newEdges.get(i))){
           newEdges.set(i, e);
         }
       }
       newEdges.set(k, e);
       newEdges.set(j, e);
     }
   }
   
   void printNewEdges(){
     println("\nedge list: ");
    for(int i = 0; i < newEdges.size(); i++){
     println("edge " + i + ": " + newEdges.get(i)); 
    }
   }
      
   void addPoint( Point _p ){ 
     p.add( _p );
     if( p.size() == 2 ){
       bdry.add( new Edge( p.get(0), p.get(1) ) );
       bdry.add( new Edge( p.get(1), p.get(0) ) );
     }
     if( p.size() > 2 ){
       bdry.set( bdry.size()-1, new Edge( p.get(p.size()-2), p.get(p.size()-1) ) );
       bdry.add( new Edge( p.get(p.size()-1), p.get(0) ) );
     }
   }

}
