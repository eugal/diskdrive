package ;

import org.flixel.FlxG;
import org.flixel.FlxSprite;

class Bullet extends FlxSprite {

	private var startX:Float;
	private var startY:Float;
	public var speedX:Float;
	public var speedY:Float;
	// private var originX:Float;
	// private var originY:Float;
	public var life:Int;


	public function new():Void {
		super(0, 0); // Position temporarily until used
		exists = false;	// Bullet does not exist at first
		//makeGraphic(20, 20, 0xffffff00);
		loadGraphic("assets/disk.png");
	}

	override public function update():Void {
		velocity.x = speedX;
		velocity.y = speedY;

		// When bullet is out of view, kill it. This signals that it is ready for recycling by bulletManager
		//if ( (y < -height || y > FlxG.height) || (x < -width|| x > FlxG.width) ){
			//trace("killed");
			//kill();
		//}
		// kills the bullet after moving 200
		// if ( (Math.abs(originX-x) > 200) || (Math.abs(originY-y) > 200) ){
		// 	kill();
		// }
		if(life == 0){
			kill();
		}
		
		super.update();
	}

	// This function sets a killed object to a new starting position, sets velocities, and brings it back to life.
	public function fire(startX:Float, startY:Float, xDirection:Float, yDirection:Float){
		x = startX;
		y = startY;
		// originX = startX;
		// originY = startY;
		speedX = 300 * xDirection;
		speedY = 300 * yDirection;
		exists = true;
		life = 3; // 3 bounces
	}
}
