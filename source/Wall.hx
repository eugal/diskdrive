package ;

import org.flixel.FlxSprite;

class Wall extends FlxSprite{

	public function new(xPosition:Float, yPosition:Float, wallwidth:Int, wallheight:Int):Void {
		super(xPosition, yPosition);
		makeGraphic(wallwidth, wallheight, 0xFFFF7788);

		visible = false;
	}
	
	override public function update():Void {
		super.update();
	}

}