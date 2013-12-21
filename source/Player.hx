package ;
import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxObject;

class Player extends FlxSprite{

	public var canExit:Bool;
	public var maxX:Float;
	public var maxY:Float;
	private var state:PlayState;
	private var EightWayFacing:Int;
	private var speed:Int; 

	public function new(xPosition:Float, yPosition:Float, _maxX:Float, _maxY:Float, _state:PlayState):Void {
		super(xPosition, yPosition);
		//makeGraphic(32, 64, 0xFFFF0000);
		loadGraphic("assets/Guy2.png", true, false, 32, 64);
		maxX = _maxX;
		maxY = _maxY;
		width = 18;
		height = 50;
		offset.x = 5;
		offset.y = 8;
		speed = 200; 
		addAnimation("left", [0,1], 10);
		addAnimation("up", [2,3], 10);
		addAnimation("idle", [4], 10);
		addAnimation("down", [5,6], 10);
		addAnimation("right", [7,8], 10);
		state = _state;

	}

	override public function update():Void {
		velocity.x = 0;
		velocity.y = 0;
		//acceleration.y = 640;

		if (FlxG.keys.LEFT && FlxG.keys.UP){
			velocity.y = -speed;
			velocity.x = -speed;
			EightWayFacing = 7; 
			play("left");
		}
		else if (FlxG.keys.RIGHT && FlxG.keys.UP){
			velocity.y = -speed;
			velocity.x = speed;
			EightWayFacing = 6;
			play("right");
		}
		else if (FlxG.keys.LEFT && FlxG.keys.DOWN){
			velocity.y = speed;
			velocity.x = -speed;
			EightWayFacing = 5;
			play("left");
		}
		else if (FlxG.keys.RIGHT && FlxG.keys.DOWN){
			velocity.y = speed;
			velocity.x = speed;
			EightWayFacing = 4;
			play("right");
		}
		else if (FlxG.keys.LEFT){
			velocity.x = -speed;
			EightWayFacing = 3;
			play("left");
		}
		else if (FlxG.keys.RIGHT){
			velocity.x = speed;
			EightWayFacing = 2;
			play("right");
		}
		else if (FlxG.keys.UP){
			velocity.y = -speed;
			EightWayFacing = 1;
			play("up");
		}
		else if (FlxG.keys.DOWN){
			velocity.y = speed;
			EightWayFacing = 0;
			play("down");
		}
		else{
			play("idle");
		}
		// Fire bullet
		if(FlxG.keys.justPressed("SPACE") == true){
			FlxG.play("Shoot");
			
			// Fire a bullet with bulletManager in the desired direction
			if(EightWayFacing == 7){
				state.bullets.fireBullet(x, y, -1, -1); 
			}
			else if(EightWayFacing == 6){
				state.bullets.fireBullet(x, y, 1, -1); 
			}
			else if(EightWayFacing == 5){
				state.bullets.fireBullet(x, y, -1, 1); 
			}
			else if(EightWayFacing == 4){
				state.bullets.fireBullet(x, y, 1, 1); 
			}
			else if(EightWayFacing == 3){
				state.bullets.fireBullet(x, y, -1, 0); 
			}
			else if(EightWayFacing == 2){
				state.bullets.fireBullet(x, y, 1, 0); 
			}
			else if(EightWayFacing == 1){
				state.bullets.fireBullet(x, y, 0, -1); 
			}
			else if(EightWayFacing == 0){
				state.bullets.fireBullet(x, y, 0, 1); 
			}
		}

		super.update();

		// limit movement to screen
		if (x > maxX - width){
			x = maxX - width;
		}
		else if (x < 0){
			x = 0;
		}
		
		if (y > maxY - height){
			y = maxY - height;
		}
		else if (y < 0){
			y = 0;
		}
	}
}