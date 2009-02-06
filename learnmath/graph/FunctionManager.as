package learnmath.graph{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.graph.config.*;
import learnmath.graph.screens.*;
import learnmath.graph.coordinates.*;
import learnmath.graph.strokes.*;
import learnmath.graph.parser.*;
import learnmath.graph.functions.*;
import flash.geom.*;

public class FunctionManager{

	public var functions:Array;
	public var configDefaultFunction:ConfigFunctionInfo;

	public static function init():FunctionManager{
		var f:FunctionManager = new FunctionManager();
		return f;
	}

	public function FunctionManager(){
		functions = new Array();
		configDefaultFunction = new ConfigFunctionInfo();
	}
	
	
	public function addFunction(mathML:String):String{
		return addFunctionConfig(mathML, configDefaultFunction.getCopy());
	}
	
	public function addFunctionConfig(mathML:String, config:ConfigFunctionInfo):String{
		var id = "id"+functions.length;
		var	funct:GraphFunction = ParserManager.getGraphFunction(mathML);
		var style:StrokeStyle = new StrokeStyle();
		style.thin = 2;
		style.setRandomColor();
		
		var f:FunctionInfo = new FunctionInfo(id, mathML, funct, config, style);
		functions[functions.length] = f;
		return id;
	}

	public function removeFunction(id:String){
		for(var i=0; i<functions.length; i++){
			var f:FunctionInfo = functions[i];
			if(f.id==id){
				functions[i] = null;
				break;
			}
		}
	}


	public function calculatePoints(configAppInfo:ConfigAppInfo):void{
	}

	public function drawOnScreen(screen:Screen):void{
		if(screen is BigScreen){
			draw(screen, 800, 1, screen.systemCoordinate.minX);
		}else{
			var factor = screen.systemCoordinate.littleScreenFactor * screen.systemCoordinate.screensFactor;
			draw(screen, 140, factor, screen.systemCoordinate.minXL);
		}
	}

	public function draw(screen:Screen, nb:Number, factor:Number, minX:Number):void{
		for(var i=0; i<functions.length; i++){
			var f:FunctionInfo = functions[i];
			var listVars = f.funct.getVariables();
			
			var style = f.style.copy();
			style.thin = style.thin/factor;
			if(listVars!=null && listVars.length>0){
				var variable = listVars[0];

				var line1 = new Array();
				for(var j=1; j<nb; j++){
					var x = minX + screen.systemCoordinate.scaleX*factor*j; // real x
					variable.setValue(x);
					var y = f.funct.calculateValue().calcValue; 	//real y
					line1[line1.length] = screen.systemCoordinate.getScreenPoint(screen, x, y);
				}
				displayOnlyThePointsInside(line1, screen, style);
			}else{
				//is constant 
				y = f.funct.calculateValue().calcValue;
				line1 = new Array();
				for(j=1; j<nb; j++){
					x = minX + screen.systemCoordinate.scaleX*factor*j; // real x
					line1[line1.length] = screen.systemCoordinate.getScreenPoint(screen, x, y);
				}
				displayOnlyThePointsInside(line1, screen, style);
			}
		}
	}

	
	public function displayOnlyThePointsInside(points:Array, screen:Screen, style:StrokeStyle):void{
		var r:Rectangle = new Rectangle(0, 0, screen.width, screen.height);
		var shape:FunctionShape2D = new FunctionShape2D();
		var s:Stroke = new Stroke();
		var line:Array = new Array();
		var isStartedTheline:Boolean = false;
		
		for(var i=0; i<points.length; i++){
			var p = points[i];
			if(r.containsPoint(p)){
				if(!isStartedTheline){
					line = new Array();
					line[0] = 0;
					line[line.length] = p;
					isStartedTheline = true;
				}else{
					line[line.length] = p;
				}
			}else{
				if(isStartedTheline){
					s.addGroupOfPoints(line);
					isStartedTheline = false;
				}
			}
		}
		if(line.length>0){
			s.addGroupOfPoints(line);
		}
		s.setStyle(style);
		shape.addStroke(s);
		screen.addShape(shape);
	}
}
}