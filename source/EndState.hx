// Basic timed end screen

package;

import org.flixel.FlxG;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxSprite;
import org.flixel.util.FlxTimer;	

class EndState extends FlxState {

	var t:FlxText;
	var end:FlxText;
	var timer:FlxTimer;
	var bgImage:FlxSprite;

	override public function create():Void {

		bgImage = new FlxSprite(0,0, "assets/endscreen.png");
		add(bgImage);

		end = new FlxText(10,100,640, "The End");
		end.size = 30;
		end.alignment = "center";
		add(end);

		t = new FlxText(10, 400, 640, "\n\n\nPress SPACE to restart");
		t.size = 10;
		t.alignment = "center";
		add(t);

		timer = new FlxTimer();
		timer.start(13);
		
		super.create();

		FlxG.play("Drone");
	}
	
	override public function update():Void {
		if (timer.finished == true){
			FlxG.switchState(new PlayState());
			FlxG.play("StartSelect");
		}
		
		if(FlxG.keys.justPressed("SPACE") == true){
			FlxG.switchState(new PlayState());
			FlxG.play("StartSelect");
		}

		super.update();
	}	
}