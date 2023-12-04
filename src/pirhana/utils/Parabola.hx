package pirhana.utils;

class Parabola{

      /**
       * Generates a parabola function using a starting point, an end point and the highest point
       * @param p1 the starting point
       * @param p2 the ending point
       * @param height the highest point's height
       */
      public static function fromPoints(p1:{x:Float, y:Float}, p2:{x:Float, y:Float}, height:Int){
          return new Parabola(p1.x, p1.y, p2.x, p2.y, p2.x-p1.x, height);
      }
  
      /**
       * Generates a parabola function using a starting object, an end object and the highest point
       * @param o1 the starting object
       * @param o2 the ending object
       * @param hk the highest point (h and k values)
       */
      public static function fromObjects(o1:h2d.Object, o2:h2d.Object, height:Int){
          return new Parabola(o1.x, o1.y, o2.x, o2.y, o2.x-o1.x, height);
      }
  
      var x1 : Float;
      var y1 : Float;
      var x2 : Float;
      var y2 : Float;
      var x3 : Float;
      var y3 : Float;
      var a : Float;
  
      public function new(x1:Float, y1:Float, x2:Float, y2:Float, h:Float, k:Float){
          this.x1 = x1;
          this.y1 = y1;
          this.x2 = x2;
          this.y2 = y2;
          this.x3 = h;
          this.y3 = k;
          calcEquation();
      }
  
      inline function calcEquation(){
          a = (y1-y3)/((x1-x3)*(x1-x3));
      }
  
      inline function gety(x:Float){
          return a*((x-x3)*(x-x3))+y3;
      }
  
      public function getRatio(ratio:Float){
          var x = x1 + (x2-x1) * ratio;
          var y = gety(x);
          return {x:x, y:y};
      }
  }