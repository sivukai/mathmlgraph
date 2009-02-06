package learnmath.graph.parser{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/

public class Operator{

	public var type:OperatorType;	
	
	public function Operator(_type:OperatorType):void{
		type = _type;
	}
	
	public function toString():String{
		return "["+type.value+"]";
	}
	
}
}