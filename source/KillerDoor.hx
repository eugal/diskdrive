package ;

import org.flixel.FlxSprite;

class KillerDoor extends FlxSprite{

	public var life:Int;
	public var xPosition:Float;
	public var yPosition:Float;

	public function new(xPosition:Float, yPosition:Float, killwidth:Int, killheight:Int):Void {
		super(xPosition, yPosition);
		makeGraphic(killwidth,killheight, 0xFFea2e49);

		//visible = false;
	}
	
	override public function update():Void {
		// life = 0; 
		// if(life == 1){
		// 	kill();
		// }
		super.update();
	}

}