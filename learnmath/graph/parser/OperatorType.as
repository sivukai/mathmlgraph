package learnmath.graph.parser{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/

public class OperatorType{

	public static const ADD:OperatorType = new OperatorType("+");
	public static const MINUS:OperatorType = new OperatorType("-");
	public static const MULTIPLICATION:OperatorType = new OperatorType("x");
	public static const DIVISION:OperatorType = new OperatorType("/");


	public var value:String;
	
	public function OperatorType(_value:String):void{
		value = _value;
	}
	
}
}