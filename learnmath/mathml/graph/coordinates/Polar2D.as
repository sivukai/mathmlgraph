package learnmath.mathml.graph.coordinates{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.mathml.graph.screens.*;
import learnmath.mathml.graph.strokes.*;
import learnmath.mathml.graph.util.*;
import learnmath.mathml.graph.*;
import learnmath.mathml.graph.config.*;
import flash.geom.*;
import flash.display.*;
import flash.events.*;
import fl.controls.*;

public class Polar2D extends SystemCoordinate{

	public var maxR:Number = 400;
	public var intiMaxR:Number = 400;

	public function Polar2D(){
		intiMaxR = maxR = 20;
	}

	public override function drawCoordonateOnBigScreen(screen:Screen, style:StrokeStyle):void{
		var shape1:Shape2D = new Shape2D();
			
			//draw Y coordonate
			var xCenter =  screen.width/2 ;
			
			var s1:Stroke = new Stroke();
			var line1 = new Array();
			line1[0] = 0;
			line1[1] = new Point(xCenter, screen.height-1);
			line1[2] = new Point(xCenter, 1);
			s1.addGroupOfPoints(line1);
			s1.setStyle(style);
			shape1.addStroke(s1);

			//draw X coordonate
			var yCenter =  screen.height/2 ;
			
			var s2:Stroke = new Stroke();
			var p1:Point = new Point(1, yCenter );
			var p2:Point = new Point(screen.width-1, yCenter);
			var line2 = new Array();
			line2[0] = 0;
			line2[1] = new Point(1, yCenter );
			line2[2] = new Point(screen.width-1, yCenter);
			s2.addGroupOfPoints(line2);
			s2.setStyle(style);
			shape1.addStroke(s2);
			
			drawGrid(screen, new Point(xCenter, yCenter), style);
			
		screen.addShape(shape1);
		
		var t:String = "<b>Domain: Radius</b> = [<i>0</i>, <i>" + GeomUtil.roundNumber(maxR) + "</i>]"
		t = t + " <b>\u03c9</b> = [<i>0\u00B0</i>, <i>360\u00B0</i>]";
		screen.graphManager.displayText(t);
		
	}
	
	private function drawGrid(screen:Screen, center:Point, style:StrokeStyle):void{
		// add grid multiple of 10
		var shapeGrid:Shape2D = new Shape2D();
		var styleGrid:StrokeStyle = style.copy();
		styleGrid.thin = 0.1;
	
		var unit:Number = GeomUtil.findMaxUnit(maxR);
		if(maxR/unit<3){ unit = unit/10;	}
		
		var nbGrids = int(maxR/unit);
		var scale = maxR/(screen.width/2);
		trace("unit=" + unit );
	
		var sGrid:Stroke = new Stroke();
		for(var j=1; j<=nbGrids; j++){
			var lineX = new Array();
			lineX[0] = 2;
			lineX[1] = center;
			lineX[2] = j * unit/scale ;
			sGrid.addGroupOfPoints(lineX);
			
			//trace("lineX[2]=" + lineX[2]);
			var text = "" + GeomUtil.roundNumber(j * unit);
			DrawUtil.drawText(screen.pannel, style.color, center.x + (j * unit/scale) , (center.y - 20), text, 'center', 10);
			DrawUtil.drawText(screen.pannel, style.color, center.x - (j * unit/scale) , (center.y - 20), text, 'center', 10);
		}
	
		sGrid.setStyle(styleGrid);
		shapeGrid.addStroke(sGrid);

		screen.addShape(shapeGrid);
	
	}
	
	public override function drawCoordonateOnLittleScreen(screen:Screen, style:StrokeStyle):void{
		var shape1:Shape2D = new Shape2D();
			
			//draw Y coordonate
			var xCenter =  screen.width/2 ;
			
			var s1:Stroke = new Stroke();
			var line1 = new Array();
			line1[0] = 0;
			line1[1] = new Point(xCenter, screen.height-1);
			line1[2] = new Point(xCenter, 1);
			s1.addGroupOfPoints(line1);
			s1.setStyle(style);
			shape1.addStroke(s1);

			//draw X coordonate
			var yCenter =  screen.height/2 ;
			
			var s2:Stroke = new Stroke();
			var p1:Point = new Point(1, yCenter );
			var p2:Point = new Point(screen.width-1, yCenter);
			var line2 = new Array();
			line2[0] = 0;
			line2[1] = new Point(1, yCenter );
			line2[2] = new Point(screen.width-1, yCenter);
			s2.addGroupOfPoints(line2);
			s2.setStyle(style);
			shape1.addStroke(s2);
			
		screen.addShape(shape1);
	}
	public override function drawFunctionsOnBigScreen(screen:Screen, functionManager:FunctionManager):void{
		draw(screen, functionManager, 1);
	}
	
	public override function drawFunctionsOnLittleScreen(screen:Screen, functionManager:FunctionManager):void{
		draw(screen, functionManager, littleScreenFactor);
	}
	

	private function draw(screen:Screen, functionManager:FunctionManager, screenFactor:Number ):void{
		//var r:Rectangle = new Rectangle(0, 0, screen.width, screen.height);
		for(var i=0; i<functionManager.functions.length; i++){
			var f:FunctionInfo = functionManager.functions[i];
			var listVars = f.funct.getVariables();
			
			var style = f.style.copy();
			style.thin = style.thin/screenFactor;
			if(listVars!=null && listVars.length>0){
				var variable = listVars[0];

				var line1 = new Array();
				var teta = 0;
				while(teta<=360){
					variable.setValue(teta*2*Math.PI/360);
					var radius = f.funct.calculateValue().calcValue/screenFactor; 	//real radius
					var p = getScreenPointFromPolar(screen, teta, radius);
					line1[line1.length] = p;
					teta=teta+(3*screenFactor);
				}
				displayOnlyThePointsInside(line1, screen, style, functionManager.mathMLs[i]);
			}else{
				//is constant ???
			}
		}
		
	}



	public function getScreenPointFromPolar(screen:Screen, teta:Number, radius:Number):Point{
		// x = r * cos(teta)
		// y = r * sin(teta)
		
		var x:Number = radius * Math.cos(teta * Math.PI/180);
		var y:Number = radius * Math.sin(teta * Math.PI/180);
		
		return getScreenPoint(screen, x, y);
	}

	
	// get the center of system coordinate in screen coordinate
	public override function getScreenCenterCoordinate(screen:Screen):Point{
		return new Point(0,0);
	}
	
	
	public override function getScreenPoint(screen:Screen, x:Number, y:Number):Point{
		var xCenter =  screen.width/2 ;
		var yCenter =  screen.height/2 ;
		
		var scale = maxR/(screen.width/2);
		return new Point(xCenter+ x/scale, yCenter-y/scale);
	}
	
	// get absolute coordinates for screen point
	public override function getAbsoluteCoordinate(screen:Screen, screenPoint:Point):Point{
		var xCenter =  screen.width/2 ;
		var yCenter =  screen.height/2 ;
		
		var scale = maxR/(screen.width/2);
		return new Point((screenPoint.x-xCenter)*scale, (yCenter-screenPoint.y)*scale);
	}
	
	
	public override function moveTheZoomImpl():Boolean{
		var changes:Boolean = false;
		if(zoomMoves.length>0){
			maxR = zoomMoves[0]["maxR"];
			zoomMoves = zoomMoves.slice(1, zoomMoves.length);
			changes = true;
		}
		return changes;
	}


	public override function zoomOutTheDomain():void{
		var step:Number = (littleScreenFactor-1)/zoomAnimationConst;
		for(var i=1; i<=zoomAnimationConst; i++){
			zoomMoves[i-1] = {maxR: (maxR + (maxR*i*step))};
		}
	}
	
	public override function zoomInTheDomain():void{
		var step:Number = (littleScreenFactor-1)/zoomAnimationConst;
		for(var i=1; i<=zoomAnimationConst; i++){
			zoomMoves[i-1] = {maxR: (maxR /(1 + i*step))};
		}
	}

	public override function moveToOrigin():void{
		zoomMoves = new Array();
		var step =( maxR - intiMaxR)/zoomAnimationConst;
		for(var i=1; i<=zoomAnimationConst; i++){
			zoomMoves[i-1] = {maxR: (maxR-i*step)};
		}
		
	}


	public override function zoomInSelection(bigScreen:Screen, absBeginPoint:Point, absEndPoint:Point):void{
	}
	
	public override function mouseOverCall(evt:MouseEvent):void {
		if(!(evt.target.name.indexOf("Shape")==0)) return;
		if(evt.target.numChildren==0) return;

		var scale = maxR/(bigScreen.width/2);
		var center:Point = getScreenPoint(bigScreen, absCenterScreenPoint.x, absCenterScreenPoint.y);
		var p:Point = new Point(evt.stageX, evt.stageY);
		var screenP = evt.target.parent.globalToLocal(p);
		
		var mouseCoordinates = evt.target.getChildAt(0)
		mouseCoordinates.graphics.clear();
		
		mouseCoordinates.graphics.lineStyle(1,0x998888, 0.7);
		mouseCoordinates.graphics.moveTo(screenP.x, screenP.y);
		mouseCoordinates.graphics.lineTo(center.x, center.y);
		var radius = Math.sqrt( Math.pow(screenP.x -center.x,2)  + Math.pow(screenP.y -center.y,2) );
		mouseCoordinates.graphics.drawCircle(center.x, center.y, radius);
		
		
		while (mouseCoordinates.numChildren){
	  		mouseCoordinates.removeChildAt(0);
		}		
		
		var text = "" + GeomUtil.roundNumber(radius*scale);
		DrawUtil.drawText(mouseCoordinates, 0x332222, center.x , center.y - radius -20, text, 'left', 10);
		
		var infoCoordinates = evt.target.getChildAt(1);
		infoCoordinates.visible = true;
		infoCoordinates.x = screenP.x - infoCoordinates.width/2;
		infoCoordinates.y = screenP.y - 18 - infoCoordinates.height/2;

	}
	
	public override function writePosition(oldText:String, point:Point, textScreen:TextArea, bigScreen:Screen):void{
		var p:Point = getAbsoluteCoordinate(bigScreen, point);
		var radius = Math.sqrt( Math.pow(p.x,2)  + Math.pow(p.y,2) );
		var teta = Math.atan(Math.abs(p.y)/Math.abs(p.x))*180/Math.PI;
		if(p.x>0){
			if(p.y>0){
			}else{
				teta = 360 - teta;
			}
		}else{
			if(p.y>=0){
				teta = 180 - teta;
			}else{
				teta = 180 + teta;
			}
		}
		//trace(p.x + " " + p.y);
		var t:String = oldText;
		t = t +"<br><b>Position: Radius</b> = [<i>"+GeomUtil.roundNumber(radius)+"</i>]";
		t = t + "&nbsp;&nbsp;&nbsp;<b>\u03c9</b> = [<i>"+GeomUtil.roundNumber(teta)+"\u00B0</i>]";
		textScreen.htmlText = t;
	}
	
}
}