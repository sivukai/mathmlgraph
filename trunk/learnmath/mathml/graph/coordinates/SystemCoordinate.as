package learnmath.mathml.graph.coordinates{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.mathml.graph.screens.*;
import learnmath.mathml.graph.strokes.*;
import learnmath.mathml.graph.*;
import flash.geom.*;
import flash.display.*;
import flash.events.*;
import fl.controls.*;

public class SystemCoordinate{

	// the absolute coordonate for the center of view (center of screen) 
	var absCenterScreenPoint:Point = new Point(0,0);
	public var bigScreen:Screen;
	public var litleScreen:Screen;
	
	public var littleScreenFactor = 5;
	public var screensFactor = 800/140;

	//zoom moving
	var centerMoves:Array = new Array();
	var zoomMoves:Array = new Array();
	
	public var zoomTimerConst:Number = 1;
	public var zoomAnimationConst:Number = 20;
	public var zoomTimer:Number = zoomTimerConst;

	public function setScreens( bScreen:Screen, lScreen:Screen):void{
		bigScreen = bScreen;
		litleScreen = lScreen;
	}

	public function drawOnScreen(screen:Screen, functionManager:FunctionManager, style:StrokeStyle):void{
		if(screen is BigScreen){
			drawCoordonateOnBigScreen(screen, style);
			drawFunctionsOnBigScreen(screen, functionManager);
		}else{
			drawCoordonateOnLittleScreen(screen, style);
			drawFunctionsOnLittleScreen(screen, functionManager);
		}
	}
	public function drawCoordonateOnBigScreen(screen:Screen, style:StrokeStyle):void{
	}
	public function drawCoordonateOnLittleScreen(screen:Screen, style:StrokeStyle):void{
	}
	public function drawFunctionsOnBigScreen(screen:Screen, functionManager:FunctionManager):void{
	}
	public function drawFunctionsOnLittleScreen(screen:Screen, functionManager:FunctionManager):void{
	}

	// get the center of system coordinate in screen coordinate
	public function getScreenCenterCoordinate(screen:Screen):Point{
		return getScreenPoint(screen, absCenterScreenPoint.x, absCenterScreenPoint.y);
	}


	// get absolute coordinates for screen point
	public function getAbsoluteCoordinate(screen:Screen, screenPoint:Point):Point{
		return null;
	}

 	// get screen point from absolute coordinate
	public function getScreenPoint(screen:Screen, x:Number, y:Number):Point{
		return null;
	}

	public function moveToOrigin():void{
	}
	public function moveDomainLeft():void{
	}
	public function moveDomainUp():void{
	}
	public function moveDomainRight():void{
	}
	public function moveDomainDown():void{
	}
	public function moveDomainTo(p:Point):void{
	}

	// used for animation zoom
	public function moveTheZoom():Boolean{
		zoomTimer--;
		if(zoomTimer==0){
			zoomTimer = zoomTimerConst
			return moveTheZoomImpl();		
		}
		return false;
	}
	public function moveTheZoomImpl():Boolean{
		return false;
	}

	public function zoomOutTheDomain():void{
	}
	public function zoomInTheDomain():void{
	}

	public function zoomInSelection(screen:Screen, absBeginPoint:Point, absEndPoint:Point):void{
	}

	function displayOnlyThePointsInside(points:Array, screen:Screen, style:StrokeStyle, mathML:Sprite):void{
		var r:Rectangle = new Rectangle(0, 0, screen.width, screen.height);
		var shape:FunctionShape2D = new FunctionShape2D();
		shape.mathML = mathML;
		var s:Stroke = new Stroke();
		var line:Array = new Array();
		line[0] = 0;
		
		for(var i=0; i<points.length; i++){
			var p = points[i];
			line[line.length] = p;
		}
		s.addGroupOfPoints(line);

		s.setStyle(style);
		shape.addStroke(s);
		shape.coordinateSystem = this;
		screen.addShape(shape);
	}

	public function addClickListenersToShape(container:Sprite):void{
		container.addEventListener(MouseEvent.CLICK, mouseClick);
	}
	
	public function mouseClick(event:MouseEvent):void {
		trace("click on " + event.target.name);
	}
	

	public function addOverListenersToShape(container:Sprite):void{
		container.addEventListener(MouseEvent.MOUSE_OVER, mouseOverCall);
		container.addEventListener(MouseEvent.MOUSE_OUT, mouseOutCall);
	}

	public function mouseOutCall(evt:MouseEvent):void {
		if(!(evt.target.name.indexOf("Shape")==0)) return;
		if(evt.target.numChildren<2) return;
		
		var mouseCoordinates = evt.target.getChildAt(0)
		mouseCoordinates.graphics.clear();
		
		while (mouseCoordinates.numChildren){
	  		mouseCoordinates.removeChildAt(0);
		}	
		var infoCoordinates = evt.target.getChildAt(1);
		infoCoordinates.visible = false;
	}

	public function mouseOverCall(evt:MouseEvent):void {
	}
	
	public function writePosition(oldText:String, point:Point, textScreen:TextArea, bigScreen:Screen):void{
	}

}
}