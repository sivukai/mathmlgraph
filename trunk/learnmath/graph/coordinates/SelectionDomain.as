package learnmath.graph.coordinates{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.graph.*;
import learnmath.graph.screens.*;
import learnmath.graph.strokes.*;
import learnmath.graph.util.*;
import flash.geom.*;
import flash.display.*;

public class SelectionDomain{

	public var style:StrokeStyle;
	public var absBeginPoint:Point;
	public var absEndPoint:Point;
	
	public function SelectionDomain(_style:StrokeStyle){
		style = _style;
	}
	
	
	public function drawSelection(sprite:Sprite, beginPoint:Point, endPoint:Point ):void{
		if(Math.abs(beginPoint.x-endPoint.x)<20) return;
		if(Math.abs(beginPoint.y-endPoint.y)<20) return;
		
		sprite.graphics.lineStyle(1,0xbbbbbb);
		var center:Point = Graph2DManager.getScreenCenterCoordinate();
		
		absBeginPoint = Graph2DManager.getAbsoluteCoordinate(Graph2DManager.bigScreen, beginPoint);
		absEndPoint = Graph2DManager.getAbsoluteCoordinate(Graph2DManager.bigScreen, endPoint);


		DrawUtil.dashLine(sprite, beginPoint.x, beginPoint.y, center.x, beginPoint.y);
		if(beginPoint.x>center.x){
			DrawUtil.drawText(sprite, style.color, center.x - 5, beginPoint.y-20, GeomUtil.roundNumber(absBeginPoint.y)+"", 'right');
		}else{
			DrawUtil.drawText(sprite, style.color, center.x + 5, beginPoint.y-20, GeomUtil.roundNumber(absBeginPoint.y)+"");
		}
		DrawUtil.dashLine(sprite, beginPoint.x, beginPoint.y, beginPoint.x, center.y);
		if(beginPoint.y>center.y){
			DrawUtil.drawText(sprite, style.color, beginPoint.x-20, center.y - 18, GeomUtil.roundNumber(absBeginPoint.x)+"");
		}else{
			DrawUtil.drawText(sprite, style.color, beginPoint.x-20, center.y + 2, GeomUtil.roundNumber(absBeginPoint.x)+"");
		}
		DrawUtil.dashLine(sprite, endPoint.x, endPoint.y, center.x, endPoint.y);
		if(beginPoint.x>center.x){
			DrawUtil.drawText(sprite, style.color, center.x - 5, endPoint.y-20, GeomUtil.roundNumber(absEndPoint.y)+"", 'right');
		}else{
			DrawUtil.drawText(sprite, style.color, center.x + 5, endPoint.y-20, GeomUtil.roundNumber(absEndPoint.y)+"");
		}
		DrawUtil.dashLine(sprite, endPoint.x, endPoint.y, endPoint.x, center.y);
		if(beginPoint.y>center.y){
			DrawUtil.drawText(sprite, style.color, endPoint.x-20, center.y - 18, GeomUtil.roundNumber(absEndPoint.x)+"");
		}else{
			DrawUtil.drawText(sprite, style.color, endPoint.x-20, center.y + 2, GeomUtil.roundNumber(absEndPoint.x)+"");
		}

		sprite.graphics.lineStyle(style.thin, style.color);
		sprite.graphics.drawRect(beginPoint.x, beginPoint.y, endPoint.x-beginPoint.x, endPoint.y-beginPoint.y);   
		
	}
	

}
}