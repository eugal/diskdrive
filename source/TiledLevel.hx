package;

import openfl.Assets;
import haxe.io.Path;
import haxe.xml.Parser;

import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxTilemap;
import org.flixel.FlxObject;
import org.flixel.FlxBasic;

class TiledLevel extends TiledMap {
	// For each "Tile Layer" in the map, you must define a "tileset" property which contains the name of a tile sheet image 
	// used to draw tiles in that layer (without file extension). The image file must be located in the directory specified bellow.
	private inline static var c_PATH_LEVEL_TILESHEETS = "assets/tiled/";
	
	// Array of tilemaps used for collision
	public var foregroundTiles:FlxGroup;
	public var backgroundTiles:FlxGroup;
	private var collidableTileLayers:Array<FlxTilemap>;
	
	public function new(tiledLevel:Dynamic) {
		super(tiledLevel);
		
		// Create groups to hold tile layers
		foregroundTiles = new FlxGroup();
		backgroundTiles = new FlxGroup();

		// camera controls
		FlxG.camera.setBounds(0, 0, fullWidth, fullHeight, true);
		
		// Load Tile Maps
		for ( tileLayer in layers ) {
			// this will look for a layer property name called tileset
			var tileSheetName:String = tileLayer.properties.get("tileset");
			
			//	you need names for your tile layers...
			if (tileSheetName == null)
				throw "'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";
				
			var tileSet:TiledTileSet = null;
			for ( ts in tilesets ){
				if ( ts.name == tileSheetName){
					tileSet = ts;
					break;
				}
			}
			
			if (tileSet == null){
				throw "Tileset '" + tileSheetName + " not found. Did you mispell the 'tilesheet' property in " + tileLayer.name + "' layer?";
			}

			var imagePath 		= new Path(tileSet.imageSource);
			var processedPath 	= c_PATH_LEVEL_TILESHEETS + imagePath.file + "." + imagePath.ext;
			
			var tilemap:FlxTilemap = new FlxTilemap();
			tilemap.widthInTiles = width;
			tilemap.heightInTiles = height;
			tilemap.loadMap(tileLayer.tileArray, processedPath, tileSet.tileWidth, tileSet.tileHeight, 0, 1, 1, 1);
			

			// assumes backgrounds are not meant to be collided with, otherwise it is a foreground item (collidable)
			if (tileLayer.properties.contains("nocollide")){
				backgroundTiles.add(tilemap);
			}
			else {
				if (collidableTileLayers == null){
					collidableTileLayers = new Array<FlxTilemap>();
				}
				foregroundTiles.add(tilemap);
				collidableTileLayers.push(tilemap);
			}
		}
	}

	// load all objects into playstate
	public function loadObjects(state:PlayState){
		for ( group in objectGroups ){
			for ( o in group.objects ){
				loadObject(o, group, state);
			}
		}
	}
	
	// this private function is used internally to parse objects from map and add them to playstate
	private function loadObject(o:TiledObject, g:TiledObjectGroup, state:PlayState) {
		// get the location of the object from tiled. variables created here are "local" to this function and not shared. think: internal use only.
		var x:Int = o.x;
		var y:Int = o.y;
		var width:Int = o.width;
		var height:Int = o.height;
		
		// objects in tiled are aligned bottom-left (top-left in flixel)
		if (o.gid != -1) {
			y -= g.map.getGidOwner(o.gid).tileHeight;
		}
		
		// check the object type from tiled and convert to lowercase. switch and case are just handy ways of doing if statements
		switch (o.type.toLowerCase()){
			
			// if there is something with this type, create a new local player object and add a copy in playstate
			case "player_start":
				var p1 = new Player(x, y, fullWidth, fullHeight, state);
				state.p1 = p1;
				state.add(p1);

			// NEW
			case "killerdoor1":
				var killerDoor1 = new KillerDoor(x, y, width, height);
				state.killerDoor1 = killerDoor1;
				state.add(killerDoor1);

			case "switcher1":
				var switcher1 = new Switch(x, y);
				state.switcher1 = switcher1;
				state.add(switcher1);

			case "killerdoor2":
				var killerDoor2 = new KillerDoor(x, y, width, height);
				state.killerDoor2 = killerDoor2;
				state.add(killerDoor2);

			case "switcher2":
				var switcher2 = new Switch(x, y);
				state.switcher2 = switcher2;
				state.add(switcher2);

			case "killerdoor3":
				var killerDoor3 = new KillerDoor(x, y, width, height);
				state.killerDoor3 = killerDoor3;
				state.add(killerDoor3);

			case "switcher3":
				var switcher3 = new Switch(x, y);
				state.switcher3 = switcher3;
				state.add(switcher3);

			case "killerdoor4":
				var killerDoor4 = new KillerDoor(x, y, width, height);
				state.killerDoor4 = killerDoor4;
				state.add(killerDoor4);

			case "switcher4":
				var switcher4 = new Switch(x, y);
				state.switcher4 = switcher4;
				state.add(switcher4);

			case "killerdoor5":
				var killerDoor5 = new KillerDoor(x, y, width, height);
				state.killerDoor5 = killerDoor5;
				state.add(killerDoor5);

			case "switcher5":
				var switcher5 = new Switch(x, y);
				state.switcher5 = switcher5;
				state.add(switcher5);

			case "exit":
				state.exits.add(new Exit(x, y)); // for a single, generic exit

			case "consumable":
				state.apples.add(new Consumable(x, y));

			case "switch":
				state.switcher.add(new Switch(x,y));

			case "killer":
				state.killer.add(new Killer(x,y, width, height));

			case "killerdoor":
				state.killerdoor.add(new KillerDoor(x,y, width, height));

			case "wall":
				state.wall.add(new Wall(x,y, width, height));

			case "platform":
				// o.custom refers to the custom properties which we can set in tiled for an object
				switch (o.custom.get("platformType")){
					case "normal":
						state.platforms.add(new Platform(x, y, width, height));
					case "falling":
						state.platforms.add(new Falling(x, y, width, height));
					case "oneway":
						state.platforms.add(new OneWay(x, y, width, height));
				}
		}
	}
	
	// Handles collision with layers not set to nocollision = true in tiled
	public function collideWithLevel(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool{
		if (collidableTileLayers != null){
			for ( map in collidableTileLayers){
				// IMPORTANT: Always collide the map with objects, not the other way around. 
				//			  This prevents odd collision errors (collision separation code off by 1 px).
				return FlxG.overlap(map, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate);
			}
		}
		return false;
	}
	// NEW! Handles groups. Improved functionality with notifyCallback
	public function collideGroupWithLevel(ObjectOrGroup1:FlxBasic = null, ?notifyCallback:Dynamic->Dynamic->Void = null, ?processCallback:FlxObject->FlxObject->Bool):Bool{
		if (collidableTileLayers != null){
			for ( map in collidableTileLayers){
				return FlxG.overlap(map, ObjectOrGroup1, notifyCallback, processCallback != null ? processCallback : FlxObject.separate);
			}
		}
		return false;
	}
}