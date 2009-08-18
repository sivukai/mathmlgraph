package learnmath.mathml.graph.strokes{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.mathml.graph.animations.*;
import flash.display.*;

public class Shape2D{


	private var groupsOfStrokes:Array;
	private var label:String = "";
	
	public function Shape2D(){
		groupsOfStrokes = new Array();
	}

	public function addStroke(stroke:Stroke):void{
		groupsOfStrokes[groupsOfStrokes.length] = stroke;
	}


	public function draw(pannel:Sprite):void{
		for(var i:int =0; i<groupsOfStrokes.length; i++){
			groupsOfStrokes[i].draw(pannel);
		}
		
	}

	public function setLabel(_label:String):void{
		label = _label;
	}
	
	public function getLabel():String{
		return label;
	}

	public function toString():String{
		return "Shape";
	}

}
}