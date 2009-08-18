package learnmath.graph.coordinates{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.graph.screens.*;
import learnmath.graph.strokes.*;
import flash.geom.*;

public class SystemCoordinate{

	// the absolute coordonate for the center of view (center of screen) 
	var absCenterScreenPoint:Point = new Point(0,0);
	
	// absolute coordinate of min, max for x and y
	public var minX:Number;
	public var maxX:Number;
	public var minY:Number;
	public var maxY:Number;
	public var confScaleX:Number = 0.01;
	public var confScaleY:Number = 0.05;
	public var scaleX:Number = confScaleX;
	public var scaleY:Number = confScaleY;

	public var minXL:Number;
	public var maxXL:Number;
	public var minYL:Number;
	public var maxYL:Number;

	public var littleScreenFactor = 5;
	public var screensFactor = 800/140;

	//zoom moving
	var centerMoves:Array = new Array();
	var zoomMoves:Array = new Array();
	
	public var zoomTimerConst:Number = 1;
	public var zoomAnimationConst:Number = 20;
	public var zoomTimer:Number = zoomTimerConst;
	
	public function drawOnScreen(screen:Screen, style:StrokeStyle):void{
		
	}

	// get the center of system coordinate in screen coordinate
	public function getScreenCenterCoordinate(screen:Screen):Point{
		return null;
	}


	// get absolute coordinates for screen point
	public function getAbsoluteCoordinate(screen:Screen, screenPoint:Point):Point{
		return null;
	}

	public function getScreenPoint(screen:Screen, x:Number, y:Number):Point{
		return null;
	}

	public function resetZoom():void{
		centerMoves = new Array();
		zoomMoves = new Array();
		
		// move the center
		var stepX:Number =( - absCenterScreenPoint.x)/zoomAnimationConst;
		var stepY:Number =( - absCenterScreenPoint.y)/zoomAnimationConst;
		for(var i=1; i<=zoomAnimationConst; i++){
			centerMoves[i-1] = new Point(absCenterScreenPoint.x + i*stepX, absCenterScreenPoint.y + i*stepY);
		}
		
		
		//zoom in
		stepX =( scaleX - confScaleX)/zoomAnimationConst;
		stepY =( scaleY - confScaleY)/zoomAnimationConst;
		for(i=1; i<=zoomAnimationConst; i++){
			zoomMoves[i-1] = {scaleX: (scaleX-i*stepX), scaleY: (scaleY-i*stepY)};
		}
	}

	public function moveDomainLeft():void{
		absCenterScreenPoint.x = absCenterScreenPoint.x - 50*scaleX;
	}
	public function moveDomainUp():void{
		absCenterScreenPoint.y = absCenterScreenPoint.y + 50*scaleY;
	}
	public function moveDomainRight():void{
		absCenterScreenPoint.x = absCenterScreenPoint.x + 50*scaleX;
	}
	public function moveDomainDown():void{
		absCenterScreenPoint.y = absCenterScreenPoint.y - 50*scaleY;
	}

	public function moveDomainTo(p:Point):void{
		centerMoves = new Array();
		zoomMoves = new Array();
		
		// move the center
		var stepX:Number =( p.x - absCenterScreenPoint.x)/zoomAnimationConst;
		var stepY:Number =( p.y - absCenterScreenPoint.y)/zoomAnimationConst;
		for(var i=1; i<=zoomAnimationConst; i++){
			centerMoves[i-1] = new Point(absCenterScreenPoint.x + i*stepX, absCenterScreenPoint.y + i*stepY);
		}

	}

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

	public function zoomInTheDomain(absBeginPoint:Point, absEndPoint:Point):void{
	}

}
}