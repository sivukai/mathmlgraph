package learnmath.mathml.graph.parser{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import flash.xml.*;

public class OperatorsTable{

	public static function isMultiplication(node:XMLNode):Boolean{
		if(node.nodeName=='mo'){
			var op = node.childNodes[0].nodeValue;
			if(op=="*" || op=="&ast;" || op=="&times;"){
				return true;
			}			
		}
		return false;
	}

	public static function isDivision(node:XMLNode):Boolean{
		if(node.nodeName=='mo'){
			var op = node.childNodes[0].nodeValue;
			if(op=="/" || op=="&divide;"){
				return true;
			}			
		}
		return false;
	}

	public static function isAdd(node:XMLNode):Boolean{
		if(node.nodeName=='mo'){
			var op = node.childNodes[0].nodeValue;
			if(op=="+"){
				return true;
			}			
		}
		return false;
	}

	public static function isMinus(node:XMLNode):Boolean{
		if(node.nodeName=='mo'){
			var op = node.childNodes[0].nodeValue;
			if(op=="-"){
				return true;
			}			
		}
		return false;
	}

	public static function isSin(node:XMLNode):Boolean{
		if(node.nodeName=='mo'){
			var op = node.childNodes[0].nodeValue.toLowerCase();
			if(op=="sin"){
				return true;
			}			
		}
		return false;
	}

	public static function isCos(node:XMLNode):Boolean{
		if(node.nodeName=='mo'){
			var op = node.childNodes[0].nodeValue.toLowerCase();
			if(op=="cos"){
				return true;
			}			
		}
		return false;
	}

}
}