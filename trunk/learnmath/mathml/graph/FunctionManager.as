package learnmath.mathml.graph{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.mathml.graph.config.*;
import learnmath.mathml.graph.screens.*;
import learnmath.mathml.graph.coordinates.*;
import learnmath.mathml.graph.strokes.*;
import learnmath.mathml.graph.parser.*;
import learnmath.mathml.graph.functions.*;
import learnmath.mathml.formula.*;
import flash.geom.*;
import flash.display.*;

public class FunctionManager{

	public var mathMLs:Array;
	public var functions:Array;
	public var configDefaultFunction:ConfigFunctionInfo;
	var styleFormula:Style = new Style();
	

	public function FunctionManager(){
		functions = new Array();
		mathMLs = new Array();
		configDefaultFunction = new ConfigFunctionInfo();

		styleFormula.font = "times";
		styleFormula.size = 11;
		styleFormula.fontweight = "bold";
		styleFormula.color = "#000000";			
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
		
		var infoCoordinates:Sprite = new Sprite();
		infoCoordinates.mouseEnabled = false;
		infoCoordinates.mouseChildren = false;
		infoCoordinates.visible = false;
		
		var m:MathML = new MathML(new XML(mathML));
		m.drawFormula(infoCoordinates, styleFormula);
		
		mathMLs[mathMLs.length] = infoCoordinates;
		
		return id;
	}

	public function removeFunction(id:String){
		for(var i=0; i<functions.length; i++){
			var f:FunctionInfo = functions[i];
			if(f.id==id){
				functions[i] = null;
				mathMLs[i] = null;
				break;
			}
		}
	}


	public function calculatePoints(configAppInfo:ConfigAppInfo):void{
	}


}
}