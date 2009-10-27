package learnmath.mathml.graph{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.mathml.graph.config.*;
import learnmath.mathml.graph.screens.*;
import learnmath.mathml.graph.coordinates.*;
import learnmath.mathml.graph.util.*;
import flash.display.*;
import flash.geom.*;
import fl.controls.*;


public class Graph2DManager{

	public var graphWorkspace:GraphWorkspace;
	public var configAppInfo:ConfigAppInfo;
	public var coordinateScreen:SystemCoordinate;
	public var bigScreen:Screen;
	public var littleScreen:Screen;
	public var textScreen:TextArea;
	public var oldText:String;
	
	public var functionManager:FunctionManager;
	
	public var selection:SelectionDomain;
	public var drawLittleScreen:Boolean = false;
	
	public function Graph2DManager(_graphWorkspace:GraphWorkspace){
		graphWorkspace = _graphWorkspace;
	}

	public function init():void{
		configAppInfo = ConfigurationManager.getConfig();
		functionManager = new FunctionManager();
		selection = new SelectionDomain(this, configAppInfo.getStyleForSelection());
	}

	public function initBigScreen(maxWidth:int, maxHeight:int, pannel:Sprite):void{
		bigScreen = new BigScreen(this, maxWidth, maxHeight, pannel);
	}

	public function initTextScreen(_textScreen:TextArea):void{
		textScreen = _textScreen;
	}

	public function initLittleScreen(width:int, height:int, pannel:Sprite):void{
		littleScreen = new LittleScreen(this, width, height, pannel);
	}


	public function drawInit():void{
		functionManager.calculatePoints(configAppInfo);
		coordinateScreen = configAppInfo.getCoordinateSystem();
		coordinateScreen.setScreens(bigScreen, littleScreen);

		littleScreen.init();
		bigScreen.init();

		coordinateScreen.drawOnScreen(littleScreen, functionManager, configAppInfo.getStyleForCoordinates());
		coordinateScreen.drawOnScreen(bigScreen, functionManager, configAppInfo.getStyleForCoordinates());
	}
	
	public function drawInitB():void{
		functionManager.calculatePoints(configAppInfo);
		coordinateScreen = configAppInfo.getCoordinateSystem();
		bigScreen.init();
		coordinateScreen.drawOnScreen(bigScreen, functionManager, configAppInfo.getStyleForCoordinates());
	}

	public function drawInitL():void{
		littleScreen.init();
		coordinateScreen.drawOnScreen(littleScreen, functionManager, configAppInfo.getStyleForCoordinates());
	}


	public function drawOnFrame():void{
		if(coordinateScreen.moveTheZoom()){
			drawInitB();
			drawLittleScreen = true;
		}else{
			if(drawLittleScreen){
				drawInitL();
				drawLittleScreen = false;
			}
		}
		littleScreen.draw();
		bigScreen.draw();
	}
	
	public function getScreenCenterCoordinate():Point{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		return coordinateScreen.getScreenCenterCoordinate(bigScreen);
	}

	public function getAbsoluteCoordinate(screen:Screen, screenPoint:Point):Point{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		return coordinateScreen.getAbsoluteCoordinate(screen, screenPoint);
	}


	public function drawSelection(sprite:Sprite, beginPoint:Point, endPoint:Point ):void{
		selection.drawSelection(sprite, beginPoint, endPoint);
	}

	public function writePosition(point:Point ):void{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		coordinateScreen.writePosition(oldText, point, textScreen, bigScreen);
	}

	public function zoomOutTheDomain():void{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		coordinateScreen.zoomOutTheDomain();
		drawInit();
	}

	public function zoomInTheDomain():void{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		coordinateScreen.zoomInTheDomain();
		drawInit();
	}

	public function zoomInSelection():void{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		coordinateScreen.zoomInSelection(bigScreen, selection.absBeginPoint, selection.absEndPoint);
		drawInit();
		
		selection.absBeginPoint = null;
		selection.absEndPoint = null
	}

	public function moveToOrigin():void{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		coordinateScreen.moveToOrigin();
		drawInit();
	}
	
	public function setCoordinate(newCoordinate:SystemCoordinate):void{
		configAppInfo.coordinate = newCoordinate;
		drawInit();
	}
	
	public function moveDomainTo(p:Point):void{
		coordinateScreen = configAppInfo.getCoordinateSystem();
		var point:Point = coordinateScreen.getAbsoluteCoordinate(bigScreen, p);
		coordinateScreen.moveDomainTo(point);
		drawInit();
	}
	
	public function moveDomain(key:uint):void{
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

	public function displayText(htmlText:String):void{
		textScreen.htmlText = htmlText;
		oldText = htmlText;
	}

	public function clearText():void{
		textScreen.htmlText = "";
		oldText = "";
	}

	public function addText(htmlText:String):void{
		textScreen.htmlText = textScreen.htmlText + htmlText;
		oldText = textScreen.htmlText;
	}

	public function addFunction(mathML:String):String{
		return functionManager.addFunction(mathML);
	}



}
}