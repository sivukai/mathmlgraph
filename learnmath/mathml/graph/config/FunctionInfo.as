package learnmath.mathml.graph.config{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.mathml.graph.functions.*;
import learnmath.mathml.graph.strokes.*;

public class FunctionInfo{

	public var id:String = "";
	public var mathML:String;
	public var funct:GraphFunction;
	public var config:ConfigFunctionInfo;
	public var style:StrokeStyle;

	public function FunctionInfo(_id:String, _mathML:String, _funct:GraphFunction, _config:ConfigFunctionInfo, _style:StrokeStyle):void{
		id = _id;
		mathML = _mathML;
		funct = _funct;
		config = _config;
		style = _style;
	}
	
}
}