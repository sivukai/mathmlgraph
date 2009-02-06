package learnmath.graph.util{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import flash.events.*;
import flash.display.*;
import flash.text.*;
import flash.geom.*;


public class GeomUtil{

	public static function roundPoint(p:Point):Point {
		// round precision is 1000 - the screen doesn't allow more
		p.x = roundNumber(p.x);
		p.y = roundNumber(p.y);
		return p;
     }; 

	public static function roundNumber(n:Number):Number {
		var d:Number = findDecimal(n);
		d  = d * 1000;
		return Math.round(n*d)/d;
     }; 
	 
	 private static function findDecimal(n:Number):Number {
		 var d = 1;
		 if(Math.abs(Math.round(n))>0){
			 while(Math.abs(Math.round(n))>0){
				 d = d/10;
				 n = n/10;
			 }
		 }else{
			 d = d/10;
			 while(Math.round(n)==0){
				 d = d*10;
				 n = n*10;
				 if(d>1000000000) break;
			 }
		 }
		 return d;
	 };

	 public static function findMaxUnit(n:Number):Number {
		 var d = 1;
		 if(Math.abs(int(n))>0){
			 n = n/10;
			 while(Math.abs(int(n))>0){
				 d = d*10;
				 n = n/10;
			 }
		 }else{
			 while(int(n)==0){
				 d = d/10;
				 n = n*10;
				 if(d<0.0000000001) break;
			 }
		 }
		 return d;
	 };

}
}