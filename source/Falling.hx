package ;
 
 import org.flixel.FlxObject;

class Falling extends Platform {

	public function new(xPosition:Float, yPosition:Float, platformWidth:Int, platformHeight:Int):Void {	
		super(xPosition, yPosition, platformWidth, platformHeight);
		makeGraphic(platformWidth, platformHeight, 0xFF0000FF);
		immovable = false;
		allowCollisions = FlxObject.UP;
	}
	
	override public function update():Void{
		super.update();
	}
}
