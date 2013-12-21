package ;

import org.flixel.FlxSprite;

class Killer extends FlxSprite{

	public function new(xPosition:Float, yPosition:Float, killwidth:Int, killheight:Int):Void {
		super(xPosition, yPosition);
		makeGraphic(killwidth,killheight, 0xFFFF7788);

		visible = false;
	}
	
	override public function update():Void {
		super.update();
	}

}