package learnmath.graph.coordinates{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.graph.screens.*;
import learnmath.graph.strokes.*;
import learnmath.graph.util.*;
import learnmath.graph.*;
import flash.geom.*;

public class Cartesian2D extends SystemCoordinate{

	public function Cartesian2D(){
		super();
		minX = -400;
		maxX = 400
		minY = -400
		maxY = 400;
	}

	public override function drawOnScreen(screen:Screen, style:StrokeStyle):void{
		if(screen is BigScreen){
			drawOnBigScreen(screen, style);
		}else{
			drawOnLittleScreen(screen, style);
		}
		screen.systemCoordinate = this;
	}
	
	// get the center of system coordinate in screen coordinate
	public override function getScreenCenterCoordinate(screen:Screen):Point{
		var factor = 1;
		if(screen is LittleScreen){
			factor = littleScreenFactor * screensFactor;
		}
		var xCenter =  screen.width/2 - absCenterScreenPoint.x/(scaleX*factor);
		var yCenter =  screen.height/2 + absCenterScreenPoint.y/(scaleY*factor);
		return new Point(xCenter, yCenter);
	}
	
	
	public override function getScreenPoint(screen:Screen, x:Number, y:Number):Point{
		if(screen is BigScreen){
			var newX =  (x - minX)/scaleX;
			var newY =  (maxY-y)/scaleY;
			return new Point(newX, newY);
		}
		var factor = littleScreenFactor * screensFactor;
		newX =  (x - minXL)/(scaleX*factor);
		newY =  (maxYL-y)/(scaleY*factor);
		return new Point(newX, newY);
	}
	
	// get absolute coordinates for screen point
	public override function getAbsoluteCoordinate(screen:Screen, screenPoint:Point):Point{
		if(screen is BigScreen){
			var newX =  screenPoint.x * scaleX + minX;
			var newY =  maxY - screenPoint.y * scaleY;
			return new Point(newX, newY);
		}
		var factor = littleScreenFactor * screensFactor;
		newX =  screenPoint.x * scaleX * factor + minXL;
		newY =  maxYL - screenPoint.y * scaleY * factor;
		return new Point(newX, newY);
	}
	
	
	private function drawOnBigScreen(screen:Screen, style:StrokeStyle):void{
		minX = absCenterScreenPoint.x - scaleX*(screen.width/2);
		maxX = absCenterScreenPoint.x + scaleX*(screen.width/2);
		minY = absCenterScreenPoint.y - scaleY*(screen.height/2);
		maxY = absCenterScreenPoint.y + scaleY*(screen.height/2);

		var shape1:Shape2D = new Shape2D();
		if(minX<=0 && maxX>=0){
			//draw Y coordonate
			var xCenter =  screen.width/2 - absCenterScreenPoint.x/scaleX;
			
			var s1:Stroke = new Stroke();
			var line1 = new Array();
			line1[0] = 0;
			if(maxY>0){
				line1[1] = new Point(xCenter, screen.height-1);
				line1[2] = new Point(xCenter, 1);
				line1[3] = new Point(xCenter-3, 11);
				line1[4] = new Point(xCenter, 1);
				line1[5] = new Point(xCenter+3, 11);
			}else{
				line1[1] = new Point(xCenter, 1);
				line1[2] = new Point(xCenter, screen.height-1);
				line1[3] = new Point(xCenter-3, screen.height-11);
				line1[4] = new Point(xCenter, screen.height-1);
				line1[5] = new Point(xCenter+3, screen.height-11);
			}
			s1.addGroupOfPoints(line1);
			s1.setStyle(style);
			shape1.addStroke(s1);
		}
		
		
		if(minY<=0 && maxY>=0){
			//draw X coordonate
			var yCenter =  screen.height/2 + absCenterScreenPoint.y/scaleY;
			
			var s2:Stroke = new Stroke();
			var p1:Point = new Point(1, yCenter );
			var p2:Point = new Point(screen.width-1, yCenter);
			var line2 = new Array();
			line2[0] = 0;
			if(maxX>0){
				line2[1] = new Point(1, yCenter );
				line2[2] = new Point(screen.width-1, yCenter);
				line2[3] = new Point(screen.width-11, yCenter-3);
				line2[4] = new Point(screen.width-1, yCenter);
				line2[5] = new Point(screen.width-11, yCenter+3);
			}else{
				line2[1] = new Point(screen.width-1, yCenter );
				line2[2] = new Point(1, yCenter);
				line2[3] = new Point(11, yCenter-3);
				line2[4] = new Point(1, yCenter);
				line2[5] = new Point(11, yCenter+3);
			}
			s2.addGroupOfPoints(line2);
			s2.setStyle(style);
			shape1.addStroke(s2);
			
		}
		screen.addShape(shape1);
		drawGrid(screen, style);
		
		var t:String = "<b>Domain: X</b> = [<i>"+GeomUtil.roundNumber(minX)+"</i>, <i>" + GeomUtil.roundNumber(maxX) + "</i>]"
		t = t + " <b>Y</b> = [<i>"+GeomUtil.roundNumber(minY)+"</i>, <i>" + GeomUtil.roundNumber(maxY) + "</i>]";
		t = t + "<br><b>Scale: X</b> = ["+GeomUtil.roundNumber(scaleX)+"]";
		t = t + "&nbsp;&nbsp;&nbsp;<b>Y</b> = ["+GeomUtil.roundNumber(scaleY)+"]";
		t = t + "<br><b>Center: X</b> = ["+GeomUtil.roundNumber(absCenterScreenPoint.x)+"]";
		t = t + "&nbsp;&nbsp;&nbsp;<b>Y</b> = ["+GeomUtil.roundNumber(absCenterScreenPoint.y)+"]";
		screen.graphManager.displayText(t);
	}

	private function drawGrid(screen:Screen, style:StrokeStyle):void{
		// add grid multiple of 10
		var shapeGrid:Shape2D = new Shape2D();
		var styleGrid:StrokeStyle = style.copy();
		styleGrid.thin = 0.1;

		var dimX:Number = maxX - minX;
		var dimY:Number = maxY - minY;
		var unitX:Number = GeomUtil.findMaxUnit(dimX);
		var unitY:Number = GeomUtil.findMaxUnit(dimY);
		if(dimX/unitX<2){ unitX = unitX/10;	}
		if(dimY/unitY<2){ unitY = unitY/10;	}
		
		var nbGridsX = int(dimX/unitX);
		var sGridX:Stroke = new Stroke();
		var startPointX = int(minX/unitX)*unitX;
		for(var j=0; j<nbGridsX; j++){
			var lineX = new Array();
			lineX[0] = 1;
			lineX[1] = getScreenPoint(screen, startPointX + j*unitX, minY);
			lineX[2] = getScreenPoint(screen, startPointX + j*unitX, maxY);
			sGridX.addGroupOfPoints(lineX);

			DrawUtil.drawText(screen.pannel, style.color, lineX[1].x + 5 , (lineX[1].y - 20), "" + GeomUtil.roundNumber(startPointX + j*unitX), 'left', 10);
			DrawUtil.drawText(screen.pannel, style.color, lineX[1].x + 5, (lineX[2].y + 10), "" + GeomUtil.roundNumber(startPointX + j*unitX), 'left', 10);
		}
		sGridX.setStyle(styleGrid);
		shapeGrid.addStroke(sGridX);

		var nbGridsY = int(dimY/unitY);
		var sGridY:Stroke = new Stroke();
		var startPointY = int(minY/unitY)*unitY;
		for(j=0; j<nbGridsY; j++){
			var lineY = new Array();
			lineY[0] = 1;
			lineY[1] = getScreenPoint(screen, minX, startPointY + j*unitY);
			lineY[2] = getScreenPoint(screen, maxX, startPointY + j*unitY);
			sGridY.addGroupOfPoints(lineY);

			DrawUtil.drawText(screen.pannel, style.color, lineY[1].x + 5 , (lineY[1].y - 20), "" + GeomUtil.roundNumber(startPointY + j*unitY), 'left', 10);
			DrawUtil.drawText(screen.pannel, style.color, lineY[2].x - 5, (lineY[1].y - 20), "" + GeomUtil.roundNumber(startPointY + j*unitY), 'right', 10);
		}
		sGridY.setStyle(styleGrid);
		shapeGrid.addStroke(sGridY);

		screen.addShape(shapeGrid);
	}

	private function drawOnLittleScreen(screen:Screen, style:StrokeStyle):void{
		var factor = littleScreenFactor * screensFactor;
		
		minXL = absCenterScreenPoint.x - scaleX*factor*(screen.width/2);
		maxXL = absCenterScreenPoint.x + scaleX*factor*(screen.width/2);
		minYL = absCenterScreenPoint.y - scaleY*factor*(screen.height/2);
		maxYL = absCenterScreenPoint.y + scaleY*factor*(screen.height/2);


		var ss:StrokeStyle = style.copy();
		ss.thin = ss.thin*140/800;
		var shape1:Shape2D = new Shape2D();
		
		if(minXL<=0 && maxXL>=0){
			//draw Y coordonate
			var xCenter =  screen.width/2 - absCenterScreenPoint.x/(scaleX*factor);
			
			var s1:Stroke = new Stroke();
			var line1 = new Array();
			line1[0] = 0;
			if(maxYL>0){
				line1[1] = new Point(xCenter, screen.height-1);
				line1[2] = new Point(xCenter, 1);
				line1[3] = new Point(xCenter-3, 11);
				line1[4] = new Point(xCenter, 1);
				line1[5] = new Point(xCenter+3, 11);
			}else{
				line1[1] = new Point(xCenter, 1);
				line1[2] = new Point(xCenter, screen.height-1);
				line1[3] = new Point(xCenter-3, screen.height-11);
				line1[4] = new Point(xCenter, screen.height-1);
				line1[5] = new Point(xCenter+3, screen.height-11);
			}
			s1.addGroupOfPoints(line1);
			s1.setStyle(ss);
			shape1.addStroke(s1);
		}
		
		
		if(minYL<=0 && maxYL>=0){
			//draw X coordonate
			var shape2:Shape2D = new Shape2D();
			var yCenter =  screen.height/2 + absCenterScreenPoint.y/(scaleY*factor);
			
			var s2:Stroke = new Stroke();
			var p1:Point = new Point(1, yCenter );
			var p2:Point = new Point(screen.width-1, yCenter);
			var line2 = new Array();
			line2[0] = 0;
			if(maxXL>0){
				line2[1] = new Point(1, yCenter );
				line2[2] = new Point(screen.width-1, yCenter);
				line2[3] = new Point(screen.width-11, yCenter-3);
				line2[4] = new Point(screen.width-1, yCenter);
				line2[5] = new Point(screen.width-11, yCenter+3);
			}else{
				line2[1] = new Point(screen.width-1, yCenter );
				line2[2] = new Point(1, yCenter);
				line2[3] = new Point(11, yCenter-3);
				line2[4] = new Point(1, yCenter);
				line2[5] = new Point(11, yCenter+3);
			}
			s2.addGroupOfPoints(line2);
			s2.setStyle(ss);
			shape1.addStroke(s2);
		}
		screen.addShape(shape1);
		
		DrawUtil.drawText(screen.pannel, style.color, 5 , screen.height - 20, "x "+ littleScreenFactor);
	}

	public override function moveTheZoomImpl():Boolean{
		var changes:Boolean = false;
		if(centerMoves.length>0){
			absCenterScreenPoint = centerMoves[0];
			centerMoves = centerMoves.slice(1, centerMoves.length);
			changes = true;
		}
		if(zoomMoves.length>0){
			scaleX = zoomMoves[0]["scaleX"];
			scaleY = zoomMoves[0]["scaleY"];
			zoomMoves = zoomMoves.slice(1, zoomMoves.length);
			
			absCenterScreenPoint = GeomUtil.roundPoint(absCenterScreenPoint);
	
			scaleX = GeomUtil.roundNumber(scaleX);
			scaleY = GeomUtil.roundNumber(scaleY);
			changes = true;
		}
		return changes;
	}


	public override function zoomOutTheDomain():void{
		var step:Number = (littleScreenFactor-1)/zoomAnimationConst;
		for(var i=1; i<=zoomAnimationConst; i++){
			zoomMoves[i-1] = {scaleX: (scaleX + (scaleX*i*step)), scaleY: (scaleY + (scaleY*i*step))};
		}
	}
	

	public override function zoomInTheDomain(absBeginPoint:Point, absEndPoint:Point):void{
		if(absBeginPoint==null || absEndPoint==null) return;
		
		var newScaleX:Number = scaleX;
		var newScaleY:Number = scaleY;
		var newAbsCenterScreenPoint:Point = new Point();
		
		if(absBeginPoint.x<absEndPoint.x){
			newScaleX = (absEndPoint.x-absBeginPoint.x)/800;
			newAbsCenterScreenPoint.x = absBeginPoint.x + (absEndPoint.x-absBeginPoint.x)/2
		}else{
			newScaleX = (absBeginPoint.x-absEndPoint.x)/800;
			newAbsCenterScreenPoint.x = absEndPoint.x + (absBeginPoint.x-absEndPoint.x)/2
		}
		if(absBeginPoint.y<absEndPoint.y){
			newScaleY = (absEndPoint.y-absBeginPoint.y)/800;
			newAbsCenterScreenPoint.y = absBeginPoint.y + (absEndPoint.y-absBeginPoint.y)/2
		}else{
			newScaleY = (absBeginPoint.y-absEndPoint.y)/800;
			newAbsCenterScreenPoint.y = absEndPoint.y + (absBeginPoint.y-absEndPoint.y)/2
		}

		centerMoves = new Array();
		zoomMoves = new Array();
		
		// move the center
		var stepX:Number =( newAbsCenterScreenPoint.x - absCenterScreenPoint.x)/zoomAnimationConst;
		var stepY:Number =( newAbsCenterScreenPoint.y - absCenterScreenPoint.y)/zoomAnimationConst;
		for(var i=1; i<=zoomAnimationConst; i++){
			centerMoves[i-1] = new Point(absCenterScreenPoint.x + i*stepX, absCenterScreenPoint.y + i*stepY);
		}
		
		
		//zoom in
		stepX =( scaleX - newScaleX)/zoomAnimationConst;
		stepY =( scaleY - newScaleY)/zoomAnimationConst;
		for(i=1; i<=zoomAnimationConst; i++){
			zoomMoves[i-1] = {scaleX: (scaleX-i*stepX), scaleY: (scaleY-i*stepY)};
		}

	}



}
}