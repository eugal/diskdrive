package;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxSprite;
// import org.flixel.util.FlxTimer;	

class Menu extends FlxState {

	var t:FlxText;
	var t2:FlxText; 
	var title:FlxText; 
	var bgImage:FlxSprite;
	// var timer:FlxTimer;

	override public function create():Void {

		bgImage = new FlxSprite(0,0, "assets/startscreen.png");
		add(bgImage);

		title = new FlxText(20,50,650, "#diskdrive");
		title.size = 40;
		title.alignment = "center";
		add(title);

		t2 = new FlxText(10, 300, 640, "Arrow Keys, Space");
		t2.size = 20;
		t2.alignment = "center";
		add(t2);

		t = new FlxText(10, 400, 640, "Press SPACE to Start");
		t.size = 10;
		t.alignment = "center";
		add(t);

		// timer = new FlxTimer();
		// timer.start(13); 
		
		super.create();

		FlxG.play("Drone");
	}
	
	override public function update():Void {
		// if (timer.finished == true){
		// 	FlxG.switchState(new PlayState());
		// }
		
		if(FlxG.keys.any() == true){
			FlxG.switchState(new PlayState());
			FlxG.play("StartSelect");
		}

		super.update();
	}	
}