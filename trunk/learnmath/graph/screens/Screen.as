package learnmath.graph.screens{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.graph.*;
import learnmath.graph.strokes.*;
import learnmath.graph.coordinates.*;
import learnmath.graph.util.*;
import flash.display.*;
import flash.geom.*;
import flash.events.*;

public class Screen{

	public var graphManager:Graph2DManager
	private var shapes:Array;
	
	public var width:int;
	public var height:int;
	public var pannel:Sprite;
	public var systemCoordinate;
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
					var mouseCoordinates:Sprite = mouseCoordinates = new Sprite();
					container.addChild(mouseCoordinates);
				}
				
				pannel.addChild(container);
				shapes[i].draw(container);
				container.addEventListener(MouseEvent.CLICK, mouseClick);
				
				if(shapes[i] is FunctionShape2D && this is BigScreen){
					container.addEventListener(MouseEvent.MOUSE_OVER, mouseOverCall);
					//container.addEventListener(MouseEvent.MOUSE_OUT, mouseOutCall);
				}
			}
			needRedraw = false;
		}
	}
	
	public function mouseClick(event:MouseEvent):void {
		trace("click on " + event.target.name);
	}

	public function mouseOverCall(evt:MouseEvent):void {
		if(!(evt.target.name.indexOf("Shape")==0)) return;
		if(evt.target.numChildren==0) return;

		var center:Point = graphManager.getScreenCenterCoordinate();
		var p:Point = new Point(evt.stageX, evt.stageY);
		p = graphManager.graphWorkspace.containerSelection.globalToLocal(p);
		
		var mouseCoordinates = evt.target.getChildAt(0)
		mouseCoordinates.graphics.clear();
		
		mouseCoordinates.graphics.lineStyle(1,0x998888, 0.4);
		mouseCoordinates.graphics.moveTo(p.x, p.y);
		mouseCoordinates.graphics.lineTo(center.x, p.y);
		mouseCoordinates.graphics.moveTo(p.x, p.y);
		mouseCoordinates.graphics.lineTo(p.x, center.y);
		
		while (mouseCoordinates.numChildren){
	  		mouseCoordinates.removeChildAt(0);
		}		
		var rp:Point = graphManager.getAbsoluteCoordinate(this, p);
		DrawUtil.drawText(mouseCoordinates, 0x998888, p.x + 5 , p.y -5, "(" + GeomUtil.roundNumber(rp.x) + ", " + GeomUtil.roundNumber(rp.y) + ")", 'left', 10);
	}



	public function toString():String{
		return "Screen !!!";
	}


}
}