package ;

import org.flixel.FlxSprite;

class Consumable extends FlxSprite{

	public function new(xPosition:Float, yPosition:Float):Void {
		super(xPosition, yPosition);
		makeGraphic(32,32, 0xFFFF7700);
	}
	
	override public function update():Void {
		super.update();
	}

}