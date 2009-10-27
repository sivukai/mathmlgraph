package learnmath.mathml.graph2d.utils{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/

import learnmath.mathml.graph.screens.*;
import learnmath.mathml.graph.strokes.*;
import learnmath.mathml.graph.util.*;
import learnmath.mathml.graph.*;
import flash.geom.*;

public class Cartesian3D extends SystemCoordinate{

	public override function drawOnScreen(screen:Screen, style:StrokeStyle):void{
		screen.systemCoordinate = this;
	}
	
	// get the center of system coordinate in screen coordinate
	public override function getScreenCenterCoordinate(screen:Screen):Point{
		return new Point(0,0);
	}
	
	
	public override function getScreenPoint(screen:Screen, x:Number, y:Number):Point{
		return new Point(0,0);
	}
	
	// get absolute coordinates for screen point
	public override function getAbsoluteCoordinate(screen:Screen, screenPoint:Point):Point{
		return new Point(0,0);
	}
	
	
	public override function moveTheZoomImpl():Boolean{
		return true;
	}


	public override function zoomOutTheDomain():void{
	}
	
	public override function zoomInTheDomain1():void{
	}


	public override function zoomInTheDomain(bigScreen:Screen, absBeginPoint:Point, absEndPoint:Point):void{
	}
}
}