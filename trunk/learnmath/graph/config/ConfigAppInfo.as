package learnmath.graph.config{
/*-------------------------------------------------------------
	Created by: Ionel Alexandru 
	Mail: ionel.alexandru@gmail.com
	Site: www.learn-math.info
---------------------------------------------------------------*/
import learnmath.graph.coordinates.*;
import learnmath.graph.screens.*;
import learnmath.graph.strokes.*;

public class ConfigAppInfo{

	public var configBigScreen:ConfigScreenInfo;
	public var configLittleScreen:ConfigScreenInfo;
	public var configDefaultFunction:ConfigFunctionInfo;

	public var coordinate:SystemCoordinate;
	
	public var selectionStyle:StrokeStyle;
	public var coordinatesStyle:StrokeStyle;
	
	
	public function ConfigAppInfo():void{
		setDefault();
	}
	
	public function setDefault():void{
		configBigScreen = new ConfigScreenInfo();
		configLittleScreen = new ConfigScreenInfo();
		configDefaultFunction = new ConfigFunctionInfo();
		coordinate = new Cartesian2D();
		
		selectionStyle = new StrokeStyle();
		selectionStyle.thin = 1;
		selectionStyle.color = 0x998888;
		
		coordinatesStyle = new StrokeStyle();
		coordinatesStyle.thin = 1;
		coordinatesStyle.color = 0x222222;
	}


	public function getCoordinateSystem():SystemCoordinate{
		return coordinate;
	}


	public function getStyleForSelection():StrokeStyle{
		return selectionStyle;
	}

	public function getStyleForCoordinates():StrokeStyle{
		return coordinatesStyle;
	}

}
}