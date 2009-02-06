package learnmath.graph.parser{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import flash.xml.*;

public class OperatorManager{

	public static function isOperator(node:XMLNode):Boolean{
		if(node.nodeName=='mo'){
			return true;
		}
		return false;		
	}
	
	public static function getOperator(node:XMLNode):Operator{
		if(node.nodeName=='mo'){
			if(OperatorsTable.isMultiplication(node)){
				return new Operator(OperatorType.MULTIPLICATION);
			}else if(OperatorsTable.isDivision(node)){
				return new Operator(OperatorType.DIVISION);
			}else if(OperatorsTable.isAdd(node)){
				return new Operator(OperatorType.ADD);
			}else if(OperatorsTable.isMinus(node)){
				return new Operator(OperatorType.MINUS);
			}
		}
		return null;		
	}
	
}
}