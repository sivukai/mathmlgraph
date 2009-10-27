package learnmath.mathml.graph.strokes{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.mathml.graph.animations.*;
import learnmath.mathml.graph.coordinates.*;
import flash.display.*;
import learnmath.mathml.graph.screens.*;

public class Shape2D{

	public var mathML:Sprite;
	private var groupsOfStrokes:Array;
	private var label:String = "";
	public var coordinateSystem:SystemCoordinate
	
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