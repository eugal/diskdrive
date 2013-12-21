package ;

import org.flixel.FlxGroup;

class BulletManager extends FlxGroup{

    public function new(bulletCount:Int = 40){
        super();

        //	Create only a limited amount of Bullets to allow on the screen at once (but can be reused!)
        for (i in 0...bulletCount) {
            var bullet = new Bullet();
            add(bullet);
        }

    }

    // Fires bullets when they become available
    public function fireBullet(startX:Float, startY:Float, xDirection:Float, yDirection:Float):Void {
        // Bullet from this group available?
        if (getFirstAvailable() != null){
            var b = cast ( getFirstAvailable(), Bullet );
            b.fire(startX, startY, xDirection, yDirection); // Fire it1
        }
    }

}

