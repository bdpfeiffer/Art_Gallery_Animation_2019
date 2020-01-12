

class Triangle {
  
   Point p0,p1,p2;
     
   Triangle(Point _p0, Point _p1, Point _p2 ){
     p0 = _p0; p1 = _p1; p2 = _p2;
   }
   
   void draw(){
    triangle(  p0.p.x, p0.p.y, 
               p1.p.x, p1.p.y,
               p2.p.x, p2.p.y );   
   }
   
   Point node(){
    float xValue = ((max(p0.getX(), p1.getX()) - min(p0.getX(), p1.getX())) * (2.0 / 3.0)) + min(p0.getX(), p1.getX());
    float yValue = ((max(p0.getY(), p1.getY()) - min(p0.getY(), p1.getY())) * (2.0 / 3.0)) + min(p0.getY(), p1.getY());
    
    float X = ((max(xValue, p2.getX()) - min(xValue, p2.getX())) * (1.0 / 3.0)) + min(xValue, p2.getX());
    float Y = ((max(yValue, p2.getY()) - min(yValue, p2.getY())) * (1.0 / 3.0)) + min(yValue, p2.getY());
    
    //Play with the X and Y numbers to get better results
    Point node = new Point(X, Y);
    return node;     
   }
   
   boolean ifIdentical(Triangle X){
     /*print("\nx and po: " + X.p0 + " " + p0);
     print("\nx and p1: " + X.p1 + " " + p1);
     println("\nx and p2: " + X.p2 + " " + p2);*/
     if((X.p0 == p0 || X.p0 == p1 || X.p0 == p2) && (X.p1 == p0 || X.p1 == p1 || X.p1 == p2) && (X.p2 == p0 || X.p2 == p1 || X.p2 == p2)){
       return true;
     }
     if((X.p0 == p0) && (X.p1 == p1) && (X.p2 == p2)){
       return true;
     }
    return false; 
   }
   
   boolean ccw(){
     PVector v1 = PVector.sub( p1.p, p0.p );
     PVector v2 = PVector.sub( p2.p, p0.p );
     float z = v1.cross(v2).z;
     return z > 0;
   }
   
   boolean cw(){
     PVector v1 = PVector.sub( p1.p, p0.p );
     PVector v2 = PVector.sub( p2.p, p0.p );
     float z = v1.cross(v2).z;
     return z < 0;
   }
   
   
}
