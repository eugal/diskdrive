package ;

import org.flixel.FlxSprite;

class Exit extends FlxSprite{

	public function new(xPosition:Float, yPosition:Float):Void {
		super(xPosition, yPosition);
		makeGraphic(32,64, 0x00000000); // transparent to use background layer from tiled
	}
	
	override public function update():Void {
		super.update();
	}

}