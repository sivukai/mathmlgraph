package learnmath.mathml.graph.screens{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.mathml.graph.*;
import learnmath.mathml.graph.strokes.*;
import learnmath.mathml.graph.coordinates.*;
import learnmath.mathml.graph.util.*;
import learnmath.mathml.formula.*;
import flash.display.*;
import flash.geom.*;
import flash.events.*;

public class Screen{

	public var graphManager:Graph2DManager
	private var shapes:Array;
	
	public var width:int;
	public var height:int;
	public var pannel:Sprite;
	public var needRedraw:Boolean = true;
	
	public function Screen(_graphManager:Graph2DManager, _width:int, _height:int, _pannel:Sprite){
		graphManager = _graphManager;
		width = _width;
		height = _height;
		pannel = _pannel;
		shapes = new Array();
	}

	public function init():void{
		shapes = new Array();
		//clean
		pannel.graphics.clear();
		while (pannel.numChildren){
	  		pannel.removeChildAt(0);
		}		
		needRedraw = true;
	}
	
	public function addShape(shape:Shape2D):void{
		shapes[shapes.length] = shape;
	}

	public function draw():void{
		if(needRedraw){
			for(var i:int =0; i<shapes.length; i++){
				var container:Sprite = new Sprite();
				container.buttonMode = true;
				container.name="Shape" + i;
				
				if(shapes[i] is FunctionShape2D && this is BigScreen){
					var mouseCoordinates:Sprite = new Sprite();
					mouseCoordinates.mouseEnabled = false;
					container.addChild(mouseCoordinates);
					
					var infoCoordinates:Sprite = new Sprite();
					infoCoordinates.mouseEnabled = false;
					infoCoordinates.mouseChildren = false;
					infoCoordinates.visible = false;
					
					container.addChild(shapes[i].mathML);
				}
				
				pannel.addChild(container);
				shapes[i].draw(container);
				if(shapes[i].coordinateSystem!=null){
					shapes[i].coordinateSystem.addClickListenersToShape(container);
				}
				
				if(shapes[i] is FunctionShape2D && this is BigScreen){
					shapes[i].coordinateSystem.addOverListenersToShape(container);
				}
			}
			needRedraw = false;
		}
	}
	
	



	public function toString():String{
		return "Screen !!!";
	}


}
}