package learnmath.graph.functions{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/

public class GraphFunction{

	private var variables:Array;

	public function calculateValue():Result{
		var value:Result = new Result();
		return calculate(value);
	}
	
	public function calculate(value:Result):Result{
		return value;
	}

	public function hasException(value:Result):Boolean{
		if(value.exception.length>0) return true;
		return false;
	}
	
	public function addVariable(variable:Variable):void{
		if(variables==null){
			variables = new Array();
		}
		variables[variables.length] = variable;
	}

	public function getVariables():Array{
		return variables;
	}


	public function getVariablesFrom(funct:GraphFunction):void{
		if(funct is Variable){
			addVariable( Variable(funct));
		}
		if(funct.getVariables()!=null){
			var vars:Array = funct.getVariables();
			for(var i=0; i<vars.length; i++){
				addVariable(vars[i]);
			}
		}
	}

	public function toString():String{
		return "GraphFunction !!!";
	}


}
}