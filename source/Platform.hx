package ;
import org.flixel.FlxSprite;
import org.flixel.FlxObject;
 
class Platform extends FlxSprite {

	public function new(xPosition:Float, yPosition:Float, platformWidth:Int, platformHeight:Int):Void {	
		super(xPosition, yPosition);
		immovable=true;	// don't move when collided with
		makeGraphic(platformWidth, platformHeight, 0xFF000000);
		
		//visible = false; // still there! you just can't see it... how is this different from setting opacity to 00?
	}
	
	override public function update():Void{
		super.update();
	}
}
