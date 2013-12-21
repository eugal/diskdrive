package;

import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxGroup;
import org.flixel.FlxText;
import org.flixel.FlxObject;

// NEEDED FOR CAMERA DEADZONE CONTROL
import org.flixel.FlxCamera;
import org.flixel.util.FlxRect;

class PlayState extends FlxState {
	public var p1:Player;
	public var exits:FlxGroup;
	public var apples:FlxGroup;
	public var switcher:FlxGroup;
	public var killer:FlxGroup;
	public var killerdoor:FlxGroup;
	public var wall:FlxGroup; 
	public var platforms:FlxGroup;
	public var oneway:OneWay;
	public var bullets:BulletManager;
	private var level:TiledLevel;
	private var scoreText:FlxText;

	public var switcher1:FlxSprite;
	public var killerDoor1:FlxSprite;
	public var switcher2:FlxSprite;
	public var killerDoor2:FlxSprite;
	public var switcher3:FlxSprite;
	public var killerDoor3:FlxSprite;
	public var switcher4:FlxSprite;
	public var killerDoor4:FlxSprite;
	public var switcher5:FlxSprite;
	public var killerDoor5:FlxSprite;


	override public function create():Void {
		level = new TiledLevel("assets/tiled/GameMap.tmx");
		add(level.backgroundTiles);
		add(level.foregroundTiles);

		platforms = new FlxGroup();
		add(platforms);

		exits = new FlxGroup();
		add(exits);

		apples = new FlxGroup();
		add(apples);

		switcher = new FlxGroup();
		add(switcher);

		killer = new FlxGroup();
		add(killer);

		killerdoor = new FlxGroup();
		add(killerdoor); 

		bullets = new BulletManager(2); // Argument sets max number of bullets on screen at once
		add(bullets);

		wall = new FlxGroup(); 
		add(wall);

		level.loadObjects(this);

		//FlxG.camera.follow(p1,FlxCamera.STYLE_LOCKON); // Default camera
		FlxG.camera.follow(p1,FlxCamera.STYLE_SCREEN_BY_SCREEN); // Shifts screen when you exit through side

		//score
		// scoreText = new FlxText(0, 30, FlxG.width, "Score: " + Std.string(Reg.score) );
		// scoreText.alignment = "center";
		// scoreText.size = 32;
		// scoreText.scrollFactor.x = 0; 
		// scoreText.scrollFactor.y = 0; 
		// scoreText.shadow = 0xff000000;
		// scoreText.useShadow = true;
		// add(scoreText);
		FlxG.fade(0xff000000,.5,true); 
		//FlxG.play("music",5,true);
		FlxG.playMusic("1");
		super.create();
	}
	
	override public function update():Void {
		super.update();
		level.collideWithLevel(p1);
		FlxG.overlap(p1, exits, exitLevel);
		FlxG.overlap(p1, apples, eatApple);
		//FlxG.overlap(p1, switcher, switchHit);
		FlxG.overlap(p1, killer, playerKill);

		FlxG.overlap(p1, killerDoor1, doorKillPlayer1);
		FlxG.overlap(p1, killerDoor2, doorKillPlayer2);
		FlxG.overlap(p1, killerDoor3, doorKillPlayer3);
		FlxG.overlap(p1, killerDoor4, doorKillPlayer4);
		FlxG.overlap(p1, killerDoor5, doorKillPlayer5);

		FlxG.overlap(p1, oneway, killReset);
		FlxG.overlap(bullets, oneway, bulletexitbounce);
		FlxG.overlap(bullets, switcher, bulletSwitch);

		// NEW
		FlxG.overlap(bullets, switcher1, doorKill1);
		FlxG.overlap(bullets, switcher2, doorKill2);
		FlxG.overlap(bullets, switcher3, doorKill3);
		FlxG.overlap(bullets, switcher4, doorKill4);
		FlxG.overlap(bullets, switcher5, doorKill5);

		level.collideGroupWithLevel(bullets, bounceBullet);

		FlxG.collide(p1, platforms);


	}	

	public function exitLevel(p:Player, e:Exit):Void {
		if(p.canExit == true){
			FlxG.switchState(new PlayState()); // switch to a new playstate if space is pressed
		}	
	}

	public function eatApple(p:Player, c:Consumable):Void{
		c.kill();
		Reg.score++;
		scoreText.text = "Score: " + Std.string(Reg.score);
	}
	//public function switchHit(p:Player, s:Switch):Void{
		//p.kill();
	//}

	public function playerKill(p:Player, k:Killer):Void{
		FlxG.play("ended");
		p.kill();
		FlxG.switchState(new EndState());
	}

	// NEW
	public function doorKill1(b:Bullet, s:Switch):Void{
		killerDoor1.kill();
		s.kill();
		FlxG.play("HitSwitch");
	}
	public function doorKill2(b:Bullet, s:Switch):Void{
		killerDoor2.kill();
		s.kill();
		FlxG.play("HitSwitch");
	}
	public function doorKill3(b:Bullet, s:Switch):Void{
		killerDoor3.kill();
		s.kill();
		FlxG.play("HitSwitch");
	}
	public function doorKill4(b:Bullet, s:Switch):Void{
		killerDoor4.kill();
		s.kill();
		FlxG.play("HitSwitch");
	}
		public function doorKill5(b:Bullet, s:Switch):Void{
		killerDoor5.kill();
		s.kill();
		FlxG.play("HitSwitch");
	}
//player kill from door
	public function doorKillPlayer1(p:Player, k:KillerDoor):Void{
		FlxG.play("ended");
		p.kill();
		FlxG.switchState(new EndState());
		FlxG.playMusic("2");
	}
	public function doorKillPlayer2(p:Player, k:KillerDoor):Void{
		FlxG.play("ended");
		p.kill();
		FlxG.switchState(new EndState());
		FlxG.playMusic("3");
	}
	public function doorKillPlayer3(p:Player, k:KillerDoor):Void{
		FlxG.play("ended");
		p.kill();
		FlxG.switchState(new EndState());
	}
	public function doorKillPlayer4(p:Player, k:KillerDoor):Void{
		FlxG.play("ended");
		p.kill();
		FlxG.switchState(new EndState());
		FlxG.playMusic("4");
	}
	public function doorKillPlayer5(p:Player, k:KillerDoor):Void{
		FlxG.play("ended");
		p.kill();
		FlxG.switchState(new EndState());
	}

	public function bulletexitbounce(b:Bullet, o:OneWay):Void{
		b.speedY *= -1;
	}

	public function killReset(p:Player, o:OneWay):Void{
		//hey guys
	}
	public function bulletSwitch(b:Bullet, s:Switch):Void{
		b.kill();
		s.kill();
		FlxG.play("HitSwitch");

	}
	public function bounceBullet(o:FlxObject, b:Bullet):Void {
		if(b.isTouching(FlxObject.WALL)){
			b.speedX *= -1;
		}
		if( b.isTouching(FlxObject.UP) || b.isTouching(FlxObject.DOWN) ){
			b.speedY *= -1;
		}
		b.life--;
		FlxG.play("Bounce");
	}
}