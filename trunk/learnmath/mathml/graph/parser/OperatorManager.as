package learnmath.mathml.graph.parser{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import flash.xml.*;
import learnmath.mathml.graph.functions.*;

public class OperatorManager{

	public static function isOperator(node:XMLNode):Boolean{
		if(getOperator(node)!=null){
			return true;
		}
		return false;		
	}
	public static function isFunction(node:XMLNode):Boolean{
		if(OperatorsTable.isSin(node)){
			return true;
		}else if(OperatorsTable.isCos(node)){
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
	
	public static function getFunction(node:XMLNode, child:GraphFunction):GraphFunction{
		if(OperatorsTable.isSin(node)){
			return new Sin(child);
		}else if(OperatorsTable.isCos(node)){
			return new Cos(child);
		}
		return null;		
	}
	
}
}