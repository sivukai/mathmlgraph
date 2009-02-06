package learnmath.graph.functions{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/

public class Prod extends GraphFunction{

	private var members:Array;
	
	public function Prod(values:Array):void{
		members = values;
		for(var i:int =0; i<members.length;i++){
			getVariablesFrom(members[i]);
		}
	}


	public override function calculate(value:Result):Result{
		if(hasException(value)) return value;

		if(members==null){
			value.exception = "EXCEPTION";
			return value;
		}
		
		var s:Number = 1;
		for(var i:int =0; i<members.length;i++){
			s = s * members[i].calculate(value).calcValue;
		}
		value.calcValue = s;
		return value;
	}
	

	public override function toString():String{
		var s:String = "P{";
		for(var i:int =0; i<members.length;i++){
			s = s + members[i].toString();
		}
		return s+"}";
	}


}
}