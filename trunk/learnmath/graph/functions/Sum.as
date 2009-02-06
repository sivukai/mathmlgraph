package learnmath.graph.functions{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/

public class Sum extends GraphFunction{

	private var members:Array;
	
	public function Sum(values:Array):void{
		members = values;
		for(var i:int =0; i<members.length;i++){
			if(members[i]==null) continue;
			getVariablesFrom(members[i]);
		}
	}


	public override function calculate(value:Result):Result{
		if(hasException(value)) return value;
		if(members==null) return value;

		var s:Number = 0;
		for(var i:int =0; i<members.length;i++){
			if(members[i]==null) continue;
			s = s + members[i].calculate(value).calcValue;
		}
		
		value.calcValue = s;
		return value;
	}
	

	public override function toString():String{
		var s:String = "S{";
		for(var i:int =0; i<members.length;i++){
			if(members[i]==null) continue;
			if(i>0){
				s = s + "+";
			}
			s = s + members[i].toString();
		}
		return s + "}";
	}


}
}