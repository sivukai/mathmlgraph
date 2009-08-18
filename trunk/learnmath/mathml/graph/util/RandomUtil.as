package learnmath.mathml.graph.util{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import flash.events.*;
import flash.display.*;
import flash.text.*;
import flash.geom.*;


public class RandomUtil{

	var min:Number = 0;
	var max:Number = 1;
	var already:Array = new Array();

	public function RandomUtil(_min:Number, _max:Number){
		if(_min<_max){
			min = _min;
			max = _max;
		}else{
			min = _max;
			max = _min;
		}
		already = new Array();
	}

	public function nextNoRepeat():Number{
		if(min==max) return min;
		
		if(already.length==(max-min)+1){
			already = new Array();
		}
		
		var next:Number = 1;
		while(true){		
			next = Math.floor(Math.random()*(max-min+1)) + min;
			if(!hasNumber(next)){
				break;
			}			
		}
		already[already.length] = next;
		return next;
		
	}

	function hasNumber(n:Number){
		for(var i=0; i<already.length; i++){
			if(already[i]==n){
				return true;
			}
		}
		return false;
	}
}
}