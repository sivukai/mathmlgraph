package learnmath.mathml.graph.strokes{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.mathml.graph.animations.*;
import flash.display.*;
import learnmath.mathml.graph.util.*;

public class Stroke{

	/*
	* 	points[0] must be the type of draw
	*	points[0] = 0 --> line
	*	points[0] = 1 --> dotted line for grid
	*	points[0] = 2 --> dotted line 2-2
	*	points[0] = 3 --> dotted line 3-3
	*	...
	*	points[0] = 10 --> dotted line 10-10
	*	points[0] = 11 --> cercle
	*/
	private var groupsOfPoints:Array;
	
	private var style:StrokeStyle;
	private var animation:Animation;
	private var needToDraw:Boolean = true;
	
	
	public function Stroke(){
		groupsOfPoints = new Array();
		style = new StrokeStyle();
	}


	public function addGroupOfPoints(_points:Array):void{
		groupsOfPoints[groupsOfPoints.length] = _points;
	}

	public function draw(pannel:Sprite):void{
		if(!needToDraw) return;
		
		for(var i=0; i<groupsOfPoints.length; i++){
			var points:Array = groupsOfPoints[i];
			
			if(points[0]==0){
				pannel.graphics.lineStyle(style.thin,style.color);
				pannel.graphics.moveTo(points[1].x, points[1].y);
				
				for(var j=2; j<points.length; j++){
					pannel.graphics.lineTo(points[j].x, points[j].y);
				}
			}else if(points[0]==1){
				// draw grid style
				pannel.graphics.lineStyle(style.thin, style.color, 0.15);
				pannel.graphics.moveTo(points[1].x, points[1].y);
				pannel.graphics.lineTo(points[2].x, points[2].y);
			}
			
		}
		needToDraw = false;
		
	}


	public function setAnimation(_animation:Animation):void{
		animation = _animation;
	}
	
	public function getAnimation():Animation{
		return animation;
	}

	public function setStyle(_style:StrokeStyle):void{
		style = _style.copy();
	}
	
	
	public function getStyle():StrokeStyle{
		return style;
	}

	public function toString():String{
		return "Stroke: ";
	}


}
}