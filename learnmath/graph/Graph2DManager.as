package learnmath.graph{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.graph.config.*;
import learnmath.graph.screens.*;
import learnmath.graph.coordinates.*;
import learnmath.graph.util.*;
import flash.display.*;
import flash.geom.*;
import fl.controls.*;


public class Graph2DManager{

	public static var configAppInfo:ConfigAppInfo;
	public static var coordinateScreen:SystemCoordinate;
	public static var bigScreen:Screen;
	public static var littleScreen:Screen;
	public static var textScreen:TextArea;
	public static var oldText:String;
	
	public static var functionManager:FunctionManager;
	
	public static var selection:SelectionDomain;
	

	public static function init():void{
		configAppInfo = ConfigurationManager.getConfig();
		functionManager = FunctionManager.init();
		selection = new SelectionDomain(ConfigurationManager.getStyleForSelection());
	}

	public static function initBigScreen(maxWidth:int, maxHeight:int, pannel:Sprite):void{
		var w = configAppInfo.configBigScreen.width;
		var h = configAppInfo.configBigScreen.height;
		if(w>0){
			bigScreen = new BigScreen(w, h, pannel);
		}else{
			bigScreen = new BigScreen(maxWidth, maxHeight, pannel);
		}
	}

	public static function initTextScreen(_textScreen:TextArea):void{
		textScreen = _textScreen;
	}

	public static function initLittleScreen(width:int, height:int, pannel:Sprite):void{
		littleScreen = new LittleScreen(width, height, pannel);
	}


	public static function drawInit():void{
		functionManager.calculatePoints(configAppInfo);
		coordinateScreen = configAppInfo.getCoordinateSystem();

		littleScreen.init();
		bigScreen.init();

		coordinateScreen.drawOnScreen(littleScreen, configAppInfo.getStyleForCoordinates());
		coordinateScreen.drawOnScreen(bigScreen, configAppInfo.getStyleForCoordinates());
		functionManager.drawOnScreen(littleScreen);
		functionManager.drawOnScreen(bigScreen);
	}

	public static function drawOnFrame():void{
		if(coordinateScreen.moveTheZoom()){
			drawInit();
		}
		littleScreen.draw();
		bigScreen.draw();
	}
	
	public static function getScreenCenterCoordinate():Point{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		return coordinateScreen.getScreenCenterCoordinate(bigScreen);
	}

	public static function getAbsoluteCoordinate(screen:Screen, screenPoint:Point):Point{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		return coordinateScreen.getAbsoluteCoordinate(screen, screenPoint);
	}


	public static function drawSelection(sprite:Sprite, beginPoint:Point, endPoint:Point ):void{
		selection.drawSelection(sprite, beginPoint, endPoint);
	}

	public static function writePosition(point:Point ):void{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		var p:Point = coordinateScreen.getAbsoluteCoordinate(bigScreen, point);
		var t:String = oldText;
		t = t +"<br><b>Position: X</b> = ["+GeomUtil.roundNumber(p.x)+"]";
		t = t + "&nbsp;&nbsp;&nbsp;<b>Y</b> = ["+GeomUtil.roundNumber(p.y)+"]";
		textScreen.htmlText = t;
	}

	public static function zoomOutTheDomain():void{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		coordinateScreen.zoomOutTheDomain();
		drawInit();
	}

	public static function zoomInTheDomain():void{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		coordinateScreen.zoomInTheDomain(selection.absBeginPoint, selection.absEndPoint);
		drawInit();
		
		selection.absBeginPoint = null;
		selection.absEndPoint = null
	}

	public static function resetZoom():void{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		coordinateScreen.resetZoom();
		drawInit();
	}

	public static function moveDomainTo(p:Point):void{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		var point:Point = coordinateScreen.getAbsoluteCoordinate(bigScreen, p);
		coordinateScreen.moveDomainTo(point);
		drawInit();
	}
	
	public static function moveDomain(key:uint):void{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		if(key==37){
			coordinateScreen.moveDomainLeft();
		}else if(key==38){
			coordinateScreen.moveDomainUp();
		}else if(key==39){
			coordinateScreen.moveDomainRight();
		}else if(key==40){
			coordinateScreen.moveDomainDown();
		}
		if(key>36 && key<41){
			drawInit();
		}
	}

	public static function displayText(htmlText:String):void{
		textScreen.htmlText = htmlText;
		oldText = htmlText;
	}

	public static function clearText():void{
		textScreen.htmlText = "";
		oldText = "";
	}

	public static function addText(htmlText:String):void{
		textScreen.htmlText = textScreen.htmlText + htmlText;
		oldText = textScreen.htmlText;
	}

	public static function addFunction(mathML:String):String{
		return functionManager.addFunction(mathML);
	}

}
}