package learnmath.mathml.graph.parser{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.mathml.graph.functions.*;
import flash.xml.*;

public class ParserManager{

	public static function getGraphFunction(mathML:String):GraphFunction{
		var xDoc:XMLDocument = new XMLDocument();
		xDoc.ignoreWhite = true;
		xDoc.parseXML(mathML);
		var f:GraphFunction;
		if(xDoc.firstChild.nodeName == "mathml"){
			f = loadFunction(xDoc.firstChild.childNodes[0])
		}else{
			f = loadFunction(xDoc.firstChild);
		}
		trace(f.toString());
		return f;
	}

	public static function loadFunction(node:XMLNode):GraphFunction{
		var variables:Array = new Array();
		return loadNode(node, variables);
	}

	private static function loadNode(node:XMLNode, variables:Array):GraphFunction{
		var name:String = node.nodeName.toLowerCase();
		var f:GraphFunction;
		if(name=='mrow'){
			f = loadMrow(node, variables);
		}else if(name=='msup'){
			f = loadMsup(node, variables);
		}else if(name=='mi'){
			f = loadMi(node, variables);
		}else if(name=='mn'){
			f = loadMn(node, variables);
		}
		return f;
	}
	
	
	private static function loadMrow(node:XMLNode, variables:Array):GraphFunction{
		if(node.childNodes.length==0) return new Sum(new Array());
		
		//trace(node);
		//load all elements
		var elements = new Array();
		for(var i=0; i<node.childNodes.length;i++){
			if(node.childNodes[i].nodeName!=null){
				var n:XMLNode = node.childNodes[i];
				if(OperatorManager.isOperator(n)){
					var o:Operator = OperatorManager.getOperator(n);
					elements[elements.length] = o;
				}else if(OperatorManager.isFunction(n) && node.childNodes.length>(i+1)){
					var child:GraphFunction = loadNode(node.childNodes[i+1], variables);
					var f:GraphFunction = OperatorManager.getFunction(n, child);
					elements[elements.length] = f;
					i++;
				}else{
					var child:GraphFunction = loadNode(node.childNodes[i], variables);
					elements[elements.length] = child
				}
			}
		}
		trace(elements);
		
		// verification don't have 2 operators succesive
		var find:Boolean = false;
		for(i=0; i<elements.length;i++){
			if(elements[i] is Operator){
				if(find){
					return new Sum(children);
				}else{
					find = true;
				}
			}else{
				find = false;
			}
		}
		
		// verify for -X
		if(elements.length>1){
			if(elements[0] is Operator && elements[0].type==OperatorType.MINUS){
				if(!(elements[1] is Operator)){
						var neg:GraphFunction = new Negation(elements[1]);
						elements[1] = neg;
						elements = elements.slice(1,elements.length);
				}
			}
		}
		
		//trace(elements);
		// compress the multiplication and division
		var lastFunction = null;
		var elements2:Array = new Array();
		for(i=0; i<elements.length;i++){
			if(elements[i] is Operator){
				if(lastFunction==null){
					return new Sum(new Array());
				}
				if(i==(elements.length-1) || (elements[i+1] is Operator)){
					return new Sum(new Array());
				}
				if(elements[i].type==OperatorType.MULTIPLICATION){
					var cProd:Array = new Array();
					cProd[0] = lastFunction;
					cProd[1] = elements[i+1];
					var prod:GraphFunction = new Prod(cProd);
					lastFunction = prod;
					i++;
				}else if(elements[i].type==OperatorType.DIVISION){
					var div:GraphFunction = new Div(lastFunction, elements[i+1]);
					lastFunction = div;
					i++;
				}else{
					// it is + or - operator
					elements2[elements2.length] = lastFunction;
					elements2[elements2.length] = elements[i];
					lastFunction=null;
				}
			}else{
				if(lastFunction==null){
					lastFunction = elements[i];
				}else{
					var cProd1:Array = new Array();
					cProd1[0] = lastFunction;
					cProd1[1] = elements[i];
					var prod1:GraphFunction = new Prod(cProd1);
					lastFunction = prod1;
				}
			}
		}
		if(lastFunction!=null){
			elements2[elements2.length] = lastFunction;
		}
		trace(elements2);
		
		// transform elements in functions
		var children = new Array();
		for(i=0; i<elements2.length;i++){
			if(elements2[i] is GraphFunction){
				if(i==0){
					children[children.length] = elements2[i];
				}else{
					var op = elements2[i-1];
					if(op is Operator && op.type==OperatorType.MINUS){
						var neg1:GraphFunction = new Negation(elements2[i]);
						children[children.length] = neg1;
					}else{
						children[children.length] = elements2[i];
					}
				}
			}
		}
		//trace(children);
		
		var f:GraphFunction = new Sum(children);
		return f;
	}

	private static function loadMi(node:XMLNode, variables:Array):GraphFunction{
		var name = node.childNodes[0];
		for(var i=0; i<variables.length;i++){
			if(variables[i].name==name) return variables[i];
		}
		var v = new Variable(node.childNodes[0]);
		variables[variables.length] = v
		return v;
	}

	private static function loadMn(node:XMLNode, variables:Array):GraphFunction{
		return new Const(Number(node.childNodes[0]));
	}

	private static function loadMsup(node:XMLNode, variables:Array):GraphFunction{
		var n:GraphFunction = loadNode(node.childNodes[0], variables);
		var exp:GraphFunction = loadNode(node.childNodes[1], variables);
		return new Power(n, exp);
	}

}
}