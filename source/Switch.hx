package ;

import org.flixel.FlxSprite;

class Switch extends FlxSprite{

	public function new(xPosition:Float, yPosition:Float):Void {
		super(xPosition, yPosition);
		//makeGraphic(32,32, 0xFFFF7788);
		loadGraphic("assets/switchglow.png");

		//visible = false;
	}
	
	override public function update():Void {
		super.update();
	}

}