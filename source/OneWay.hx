package ;
 
 import org.flixel.FlxObject;

class OneWay extends Platform {

	public function new(xPosition:Float, yPosition:Float, platformWidth:Int, platformHeight:Int):Void {	
		super(xPosition, yPosition, platformWidth, platformHeight);
		makeGraphic(platformWidth, platformHeight, 0x00000000); // transparent to used background image from tiled
		allowCollisions = FlxObject.UP;
	}
	
	override public function update():Void{
		super.update();
	}
}
