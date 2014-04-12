package {
	import flash.geom.*;
    import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.net.*;
	import flash.utils.Timer;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	public class survival extends Sprite {
		//global variables
		public static var environment:environment_mc = new environment_mc();
		public static var intro:intro_mc = new intro_mc();
		public static var player:player_mc = new player_mc();
		public static var door:door_mc = new door_mc();
		public static var door2:door_mc = new door_mc();
		public var pausescreen:pausescreen_mc = new pausescreen_mc();
		public var gameoverscreen:gameoverscreen_mc = new gameoverscreen_mc();
		public var shopscreen:shopscreen_mc = new shopscreen_mc();
		public var light:light_mc= new light_mc();
		public var ground:ground_mc = new ground_mc();
		public var ui:ui_mc = new ui_mc();
		public var deadzombie:deadzombie_mc = new deadzombie_mc();
		
		//items
		public var ammocrate:ammocrate_mc = new ammocrate_mc();
		public var medpack:medpack_mc = new medpack_mc();
		public var speedpack:speedpack_mc = new speedpack_mc();
		
		//weapons
		public var pistol:pistol_mc = new pistol_mc();
		public var uzi:uzi_mc = new uzi_mc();
		public var shotgun:shotgun_mc = new shotgun_mc();
		public var bulletproofvest:bulletproofvest_mc = new bulletproofvest_mc();
		public var flamethrower:flamethrower_mc = new flamethrower_mc();
		public var flamethrowerflames:flamethrowerflames_mc = new flamethrowerflames_mc();
		
		public var playerhitobject:Boolean = false; // has player hit a object
		public var isusingpistol:Boolean = true;//set pistol as default weapon
		
		public var isusinguzi:Boolean = false;
		public var isusingshotgun:Boolean = false;
		public var isusingflamethrower:Boolean = false;
		
		public var ammoempty:Boolean = false;//ammo empty check
		
		public var dooropening:Boolean = false;//door moving check
		public var door2opening:Boolean = false;//door2 moving check
		
		public var stopspawn:Boolean = false;//zombie spawn control
		public var key_pressed:int=0;
		public var radius:int=8;//players "size" (sphere)
		public var up,down,left,right:Boolean=false;
		public var weapon1,weapon2,weapon3,weapon4:Boolean=false;//switch weapon keys 1,2,3
		public var mousePressed:Boolean = false; //keeps track of whether the mouse is currently pressed down
		
		//shooting speed
		public var delayCounter:int = 0; //we use this to add delay between the shots
		public var delayMax:int = 15; //default pistol delay
		//ammo
		public var pistolammo:int;
		public var uziammo:int;
		public var shotgunammo:int;
		public var flamethrowerammo:int;
		
		public var hasarmour:Boolean = true;
		public var armour:int=25;//starting armour
		
		public var health:int=100;//starting health
		
		//zombies
		public var zombieskilled:int;//total zombies killed for current stage
		public var totalzombieskilled:int;//total zombies killed all up
		public var zombiecount:int = 0;// how many zombies created
		public var zombiespawncount:int = 9; // MUST BE 1 LESS than actual count!! used as starting zombie spawn count
		public var totalzomibes:int; // total zombies spawned
		public var zomibeskilled:int; // total zombies killed
		//timers
		public var SecondsElapsed:Number = 1;
		public var Timer10:Timer = new Timer(1000, 10);
		public var collectedSpeedPack:Boolean = false;
		public var level:int = 1;//set start level
		public var currentcash:int = 250;//cash
		//CHEATS AND DEBUG
		public var haspistol:Boolean = false;
		public var hasuzi:Boolean = false;
		public var hasshotgun:Boolean = false;
		public var hasflamethrower:Boolean = true;
		//what stage to start on
		public var currentstage:int = 1;
		//cheats
		public var shootthruwalls:Boolean = false;
		public var walkthruwalls:Boolean = false;
		public var infinteammo:Boolean = false;
		public var infintehealth:Boolean = false;
		public var player_speed:int = 2;//player movement speed (Default is 2)
		public var playerhastorch:Boolean = false;
		
		public var torch:torch_mc= new torch_mc();
		public static var ispaused:Boolean = false;

		//Intilize game code
		public function survival():void {
			addChild(intro);
			intro.startgame.addEventListener(MouseEvent.CLICK, startgame);

		}
		//START GAME
		public function startgame(event:MouseEvent):void {
			intro.startgame.removeEventListener(MouseEvent.CLICK, startgame);
			if (this.contains(intro)){
			removeChild(intro);
			}
			//starting ammo
			pistolammo = 30;
			uziammo = 0;
			shotgunammo = 0;
			flamethrowerammo = 0;
			//environment
			addChild(environment);
			setChildIndex(environment,0);
			environment.x=0;
			environment.y=0;
			environment.gotoAndStop(1);//go to first stage
			
			//Add the background
			addChild(ground);
			setChildIndex(ground,1);//above environment
			ground.x=0;
			ground.y=0;
			ground.gotoAndStop(1);//go to first stage

			//add the player
			addChild(player);
			setChildIndex(player,2);
			player.x = stage.width / 2;
            player.y = stage.height / 2;
			
			//lighting
            addChild(light);
			setChildIndex(player,3);
			var myBlur:BlurFilter = new BlurFilter();
			myBlur.quality = 5;
			myBlur.blurX = 50;
			myBlur.blurY = 50;
			light.filters = [myBlur];
			//add UI
			addChild(ui);
			setChildIndex(ui,4);
			ui.x=322;
			ui.y=350;
			
			
			//add listener to run on every frame
			stage.addEventListener(Event.ENTER_FRAME,mainloop);
			stage.addEventListener(Event.ENTER_FRAME,processScripts);
			//add keyboard listeners
			stage.addEventListener(KeyboardEvent.KEY_DOWN, on_key_down);
			stage.addEventListener(KeyboardEvent.KEY_UP, on_key_up);
			//add mouse listeners
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
			trace ("Game Intialised");
		}
		private function restartGame(event:MouseEvent):void {
   		 var url:String = stage.loaderInfo.url;
  	 	 var request:URLRequest = new URLRequest(url);
   		 navigateToURL(request,"_level0");
		 trace ("Game Restarted");
		}
		public function lighting():void{
			
			if (playerhastorch == true){
			light.x = player.x;
			light.y = player.y;
			light.gotoAndStop(1);
			}
			if (playerhastorch == false){
			light.x = player.x;
			light.y = player.y;
			light.gotoAndStop(2);
			}			
				
		}
		//MAIN GAME LOOP
		public function mainloop(e:Event):void {
			
			var dist_x:Number=player.x-mouseX;
			var dist_y:Number=player.y-mouseY;
			var angle:Number=- Math.atan2(dist_x,dist_y);
			
			
			player.rotation=(to_degrees(angle) -90);
			if (up) {
				player.y-=player_speed;
				light.y-=player_speed;
			}
			if (down) {
				player.y+=player_speed;
				light.y+=player_speed;
			}
			if (left) {
				player.x-=player_speed;
				light.x-=player_speed;
			}
			if (right) {
				player.x+=player_speed;
				light.x+=player_speed;
			}
			//HIT DETECTION
			if (walkthruwalls == false){
				while (environment.hitTestPoint(player.x, player.y+radius, true)) {
					player.y--;
				}
				while (environment.hitTestPoint(player.x, player.y-radius, true)) {
					player.y++;
				}
				while (environment.hitTestPoint(player.x-radius, player.y, true)) {
					player.x++;
				}
				while (environment.hitTestPoint(player.x+radius, player.y, true)) {
					player.x--;
				}
				while ((door.hitTestPoint(player.x, player.y+radius, true))||(door2.hitTestPoint(player.x, player.y+radius, true))) {
					player.y--;
				}
				while ((door.hitTestPoint(player.x, player.y-radius, true))||(door2.hitTestPoint(player.x, player.y-radius, true))) {
					player.y++;
				}
				while ((door.hitTestPoint(player.x-radius, player.y, true))||(door2.hitTestPoint(player.x-radius, player.y, true))) {
					player.x++;
				}
				while ((door.hitTestPoint(player.x+radius, player.y, true))||(door2.hitTestPoint(player.x+radius, player.y, true))) {
					player.x--;
				}
			}
			//SHOOTING
			if(mousePressed == true){
				delayCounter++; //increase the delayCounter by 1
				if(delayCounter == delayMax){
					if ((isusingpistol == true) && (pistolammo >= 1) && (infinteammo == false)){
						pistolammo -= 1;
						shootBullet(); //shoot a bullet
						delayCounter = 0; //reset the delay counter so there is a pause between bullets
					}
					if ((isusingshotgun == true) && (shotgunammo >= 1) && (infinteammo == false)){
						shotgunammo -= 1;
						shootBullet(); //shoot a bullet
						delayCounter = 0; //reset the delay counter so there is a pause between bullets
					}
					if ((isusinguzi == true) && (uziammo >= 1) && (infinteammo == false)){
						uziammo -= 1;
						shootBullet(); //shoot a bullet
						delayCounter = 0; //reset the delay counter so there is a pause between bullets
					}
					if ((isusingflamethrower == true) && (flamethrowerammo >= 1) && (infinteammo == false)){
						delayCounter = 0;
						shootFlames();
						flamethrowerammo -= 1;
					}
				}
			}
			if(bulletList.length > 0){
				for(var ii:int = bulletList.length-1; ii >= 0; ii--){
					bulletList[ii].loop();
				}
			}
		}


///////////////////////////////////////////////////////
//					SCRIPTS / MODULES
///////////////////////////////////////////////////////
		public function processScripts(e:Event):void{
			updatetext();
			checkSpeedPackTimer();
			createZombies();
			checkzombieHit();
			collectItem();
			//openDoor();
			finishlevel();
			playerMoving();
			removeFlames();
			checkhealth();
			checkarmour();
			lighting();
		}

///////////////////////////////////////////////////////
//							PLAYER
///////////////////////////////////////////////////////
		public function on_key_down(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case 65 : // Left Arrow
					left=true;
					playermoving = true;
					break;
				case 87: // Up Arrow
					up=true;
					playermoving = true;
					break;
				case 68 : // Right Arrow
					right=true;
					playermoving = true;
					break;
				case 83 : // Down Arrow
					down=true;
					playermoving = true;
					break;
				case 49 : // 1
					weapon1 = true;
					weapon2 = false;
					weapon3 = false;
					weapon4 = false;
					isusingpistol = true;
					isusinguzi = false;
					isusingshotgun = false;
					isusingflamethrower = false;
					delayMax = 15; //try changing this number to shoot more or less rapidly
					delayCounter = 0;
					trace ("Switched to pistol:" + delayMax);
				break;
				
				case 50 : // 2
				if (hasuzi == true){
					weapon2 = true;
					weapon1 = false;
					weapon3 = false;
					weapon4 = false;
					isusingpistol = false;
					isusinguzi = true;
					isusingshotgun = false;
					isusingflamethrower = false;
					delayMax = 6; //try changing this number to shoot more or less rapidly
					delayCounter = 0;
					trace ("Switched to uzi:" + delayMax);
				}
				break;
				
				case 51 : // 3
				if (hasshotgun == true){
					weapon3 = true;
					weapon1 = false;
					weapon2 = false;
					weapon4 = false;
					isusingpistol = false;
					isusinguzi = false;
					isusingshotgun = true;
					isusingflamethrower = false;
					delayMax = 20; //try changing this number to shoot more or less rapidly
					delayCounter = 0;
					trace ("Switched to shotgun:" + delayMax);
				}
				break;
				case 52 : // 4
				if (hasflamethrower == true){
					weapon3 = false;
					weapon1 = false;
					weapon2 = false;
					weapon4 = true;
					isusingpistol = false;
					isusinguzi = false;
					isusingshotgun = false;
					isusingflamethrower = true;
					delayMax = 2; //try changing this number to shoot more or less rapidly
					delayCounter = 0;
					trace ("Switched to flamethrower:" + delayMax);
				}
				break;
				//PAUSE GAME
				case 80 : // P
				if (ispaused == false){
					ispaused = true;
					stage.removeEventListener(Event.ENTER_FRAME,mainloop);
					stage.removeEventListener(Event.ENTER_FRAME,processScripts);
					trace("GAME PAUSED");
					stage.addChild(pausescreen);
					pausescreen.gotoshop.addEventListener(MouseEvent.CLICK, showshop);
					pausescreen.restartgame.addEventListener(MouseEvent.CLICK, restartGame);
					pausescreen.exitpausescreen.addEventListener(MouseEvent.CLICK, closepausescreen);
					
				}
				else if  (ispaused == true){
					ispaused = false;
					stage.addEventListener(Event.ENTER_FRAME,mainloop);
					stage.addEventListener(Event.ENTER_FRAME,processScripts);
					trace("GAME RESUMED");
					pausescreen.gotoshop.removeEventListener(MouseEvent.CLICK, showshop);
					if(stage.contains(pausescreen)){
						stage.removeChild(pausescreen);
					}
				}
				break;
			}
		}
		public function closepausescreen():void{
			ispaused = false;
					stage.addEventListener(Event.ENTER_FRAME,mainloop);
					stage.addEventListener(Event.ENTER_FRAME,processScripts);
					trace("GAME RESUMED");
					pausescreen.gotoshop.removeEventListener(MouseEvent.CLICK, showshop);
					if(stage.contains(pausescreen)){
						stage.removeChild(pausescreen);
					}
		}
		
		public var playermoving:Boolean = false;
		
		public function playerMoving():void{
			if (playermoving == true){
				player.gotoAndStop(1);
			}else{
				player.gotoAndStop(2);
			}
		}
		public function on_key_up(e:KeyboardEvent):void {
			switch (e.keyCode) {
				case 65 :
					left=false;
					playermoving = false;
					break;
				case 87 :
					up=false;
					playermoving = false;
					break;
				case 68 :
					right=false;
					playermoving = false;
					break;
				case 83 :
					down=false;
					playermoving = false;
					break;
			}
		}
		public function mouseDownHandler(e:MouseEvent):void {
			mousePressed = true; //set mousePressed to true
		}
		public function mouseUpHandler(e:MouseEvent):void {
			mousePressed = false; //reset this to false
		}
		public function checkhealth():void{
			if (health <=0){
				gameover();
			}
		}
		public function checkarmour():void{
			if (armour <=0){
				hasarmour = false;
			}
		}
///////////////////////////////////////////////////////
//						SHOP
///////////////////////////////////////////////////////
		public function showshop(event:MouseEvent):void {
			pausescreen.gotoshop.removeEventListener(MouseEvent.CLICK, showshop);
			pausescreen.addChild(shopscreen);
			shopscreen.buyarmour.addEventListener(MouseEvent.CLICK, buyARMOUR);
			shopscreen.buymedkit.addEventListener(MouseEvent.CLICK, buyMEDKIT);
			
			shopscreen.buyuzi.addEventListener(MouseEvent.CLICK, buyUZI);
			shopscreen.buyshotgun.addEventListener(MouseEvent.CLICK, buySHOTGUN);
			shopscreen.buyflamethrower.addEventListener(MouseEvent.CLICK, buyFLAMETHROWER);
			
			shopscreen.buypistolammo.addEventListener(MouseEvent.CLICK, buyPISTOLAMMO);
			shopscreen.buyuziammo.addEventListener(MouseEvent.CLICK, buyUZIAMMO);
			shopscreen.buyshotgunammo.addEventListener(MouseEvent.CLICK, buySHOTGUNAMMO);
			shopscreen.buyflamethrowerammo.addEventListener(MouseEvent.CLICK, buyFLAMETHROWERAMMO);
			
			shopscreen.exitshop.addEventListener(MouseEvent.CLICK, closeshop);
		}
		public function closeshop(event:MouseEvent):void {
			pausescreen.gotoshop.addEventListener(MouseEvent.CLICK, showshop);
			if(pausescreen.contains(shopscreen)){
				pausescreen.removeChild(shopscreen);
			}
		}
		//WEAPONS
		public function buyUZI(event:MouseEvent):void {
			if (currentcash >= 1000){
			hasuzi = true;
			uziammo = 200;
			currentcash -= 1000;//cost of uzi
			shopscreen.shopmessage.text = "Bought UZI!";//shop message
			}else{
				shopscreen.shopmessage.text = "Not enough cash!";//shop message
			}
		}
		public function buySHOTGUN(event:MouseEvent):void {
			if (currentcash >= 500){
			hasshotgun = true;
			shotgunammo = 200;
			currentcash -= 500;//cost of uzi
			shopscreen.shopmessage.text = "Bought Shotgun!";//shop message
			}else{
				shopscreen.shopmessage.text = "Not enough cash!";//shop message
			}
		}
		public function buyFLAMETHROWER(event:MouseEvent):void {
			if (currentcash >= 2500){
			hasflamethrower = true;
			flamethrowerammo = 300;
			currentcash -= 2500;//cost of uzi
			shopscreen.shopmessage.text = "Bought Flamethrower!";//shop message
			}else{
				shopscreen.shopmessage.text = "Not enough cash!";//shop message
			}
		}
		//ARMOUR
		public function buyARMOUR(event:MouseEvent):void {
			if (currentcash >= 2000){
			hasarmour = true;
			armour += 40;
			currentcash -= 2000;//cost of armour
			updatetext();//update armour display
			shopscreen.shopmessage.text = "Bought Armour!";//shop message
			}else{
				shopscreen.shopmessage.text = "Not enough cash!";//shop message
			}
		}
		//MEDKIT
		public function buyMEDKIT(event:MouseEvent):void {
			if (currentcash >= 1500){
			hasarmour = true;
			collectMedpack();
			currentcash -= 1500;//cost of armour
			updatetext();//update armour display
			shopscreen.shopmessage.text = "Bought Medkit!";//shop message
			}else{
				shopscreen.shopmessage.text = "Not enough cash!";//shop message
			}
		}
		//AMMO
		public function buyPISTOLAMMO(event:MouseEvent):void {
			if (currentcash >= 50){
			pistolammo = 100;
			currentcash -= 50;//cost of uzi
			shopscreen.shopmessage.text = "Bought Pistol Ammo!";//shop message
			}else{
				shopscreen.shopmessage.text = "Not enough cash!";//shop message
			}
		}
		public function buyUZIAMMO(event:MouseEvent):void {
			if (currentcash >= 500){
			uziammo = 350;
			currentcash -= 500;//cost of uzi
			shopscreen.shopmessage.text = "Bought UZI Ammo!";//shop message
			}else{
				shopscreen.shopmessage.text = "Not enough cash!";//shop message
			}
		}
		public function buySHOTGUNAMMO(event:MouseEvent):void {
			if (currentcash >= 150){
			shotgunammo = 50;
			currentcash -= 150;//cost of uzi
			shopscreen.shopmessage.text = "Bought Shotgun Ammo!";//shop message
			}else{
				shopscreen.shopmessage.text = "Not enough cash!";//shop message
			}
		}
		public function buyFLAMETHROWERAMMO(event:MouseEvent):void {
			if (currentcash >= 500){
			flamethrowerammo = 250;
			currentcash -= 500;//cost of uzi
			shopscreen.shopmessage.text = "Bought Flamethrower Ammo!";//shop message
			}else{
				shopscreen.shopmessage.text = "Not enough cash!";//shop message
			}
		}
///////////////////////////////////////////////////////
//						ZOMBIES
///////////////////////////////////////////////////////
		var zombieArray:Array = [];//holds all zombies
		var deadzombieArray:Array = [];//holds all deadzombies

		public function checkzombieHit():void{
			for (var idx:int = zombieArray.length - 1; idx >= 0; idx--){
						var zombie1:Zombie = zombieArray[idx];
						
					//normal push player
					if (zombie1.hitTestPoint(player.x+radius, player.y, true)){
						player.x -= 1;
						zombie1.x += 1;
						if (infintehealth == false){
							if (hasarmour == false){
								health -= zombie1.zombiedamage;
							}else if (hasarmour == true){
								armour -= zombie1.zombiedamage;
							}
						}
					}
					if (zombie1.hitTestPoint(player.x, player.y-radius, true)){
						player.y += 1;
						zombie1.y -= 1;
						if (infintehealth == false){
							if (hasarmour == false){
								health -= zombie1.zombiedamage;
							}else if (hasarmour == true){
								armour -= zombie1.zombiedamage;
							}
						}
					}
					if (zombie1.hitTestPoint(player.x-radius, player.y, true)){
						player.x += 1;
						zombie1.x -= 1;
						if (infintehealth == false){
							if (hasarmour == false){
								health -= zombie1.zombiedamage;
							}else if (hasarmour == true){
								armour -= zombie1.zombiedamage;
							}
						}
					}
					if (zombie1.hitTestPoint(player.x, player.y+radius, true)){
						player.y -= 1;
						zombie1.y += 1;
						if (infintehealth == false){
							if (hasarmour == false){
								health -= zombie1.zombiedamage;
							}else if (hasarmour == true){
								armour -= zombie1.zombiedamage;
							}
						}
					}
					//flamerthrower
					if(flamethrowerflames.hitTestPoint(zombie1.x,zombie1.y, true)){
						if (this.parent.contains(zombie1)){
							zombie1.zombiehitpoints -= 10;
						}
						if(zombie1.zombiehitpoints <= 0){
									var numOfClips:Number = 5;
									var deadzombieArray:Array = new Array();
									
									for(var i=0; i<numOfClips; i++)
									{
									  	var deadzombie:deadzombie_mc = new deadzombie_mc();
										ground.addChild(deadzombie);
										ground.setChildIndex(deadzombie,2);
									 	deadzombieArray.push(deadzombie);
									}
									deadzombie.x = zombie1.x;
									deadzombie.y = zombie1.y;
									deadzombie.gotoAndStop(15);
									ground.removeChild(zombie1);
								}
					}
					//bullets
					for (var bidx:int = bulletList.length - 1; bidx >= 0; bidx--){
						var bullet1:Bullet = bulletList[bidx];
						//check if bullet hits zombie
						
						if (bullet1.hitTestObject(zombie1)){
							if (ground.contains(zombie1)){
								//remove zombie and bullet
								if(isusingshotgun == true){
									zombie1.zombiehitpoints -= 250;
									ground.removeChild(bullet1);
								} else {
									zombie1.zombiehitpoints -= 100;
									ground.removeChild(bullet1);
								}

								if(zombie1.zombiehitpoints <= 0){
									var numOfClips:Number = 5;
									var deadzombieArray:Array = new Array();
									
									for(var i=0; i<numOfClips; i++)
									{
									  var deadzombie:deadzombie_mc = new deadzombie_mc();
									  ground.addChild(deadzombie);
									  ground.setChildIndex(deadzombie,2);
									  deadzombieArray.push(deadzombie);
									}
									deadzombie.x = zombie1.x;
									deadzombie.y = zombie1.y;
									deadzombie.gotoAndStop(15);
									ground.removeChild(zombie1);
								}
								
							}
						}
						
					}
			 }
		}
		//create new zombie from Zombie class and place on stage at spawn point
		public function createZombies():void {
			//check how many zombies have been spawned
			if(zombiecount > zombiespawncount){
				stopspawn = true;
			}else{
				if (stopspawn == false) {
					//check how many zombies on stage
							var zombie:Zombie = new Zombie(stage, Zombie.ZombieX, Zombie.ZombieY);
							//Add event to zombie to remove them from array when removed from stage
							zombie.addEventListener(Event.REMOVED_FROM_STAGE, zombieRemoved, false, 0, true);
							//add zombie to array
							zombieArray.push(zombie);
							//add zombie to stage
							ground.addChild(zombie);
							ground.setChildIndex(zombie,1);
							//increase zombie counters
							zombiecount += 1;
							totalzomibes += 1;
							
				}
			}
		}

		//removes zombie from array
		public function zombieRemoved(ee:Event):void{
			//remove the event listner from current zombie
			ee.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, zombieRemoved);
			//remove current zombie from array
			zombieArray.splice(zombieArray.indexOf(ee.currentTarget),1);
			//remove zombie from count
			zombiecount -= 1;
			//count xombie kill
			zombieskilled += 1;
			//global total zombies
			totalzombieskilled += 1;
			//give cash
			currentcash += 5;
			trace ("Zombie Removed");
		}
		public function deadzombieRemoved(ee:Event):void{
			//remove the event listner from current zombie
			ee.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, deadzombieRemoved);
			//remove current zombie from array
			deadzombieArray.splice(zombieArray.indexOf(ee.currentTarget),1);
			trace ("Dead Zombie Removed");
		}
///////////////////////////////////////////////////////
//						LEVELS
///////////////////////////////////////////////////////
		
		public function finishlevel():void{
			if ((level == 1)&&(zombieskilled >= 10)){
				zombiespawncount = 9; // how many zombies to spawn for level 2 (if you want 10 set it to 9!)
				level += 1;
				stopspawn = false;
				trace ("Level:" + level);
			}
			else if ((level == 2)&&(zombieskilled >= 20)){
				zombiespawncount = 9;
				level += 1;
				stopspawn = false;
				trace ("Level:" + level);
			}
			else if ((level == 3)&&(zombieskilled >= 30)){
				zombiespawncount = 9;
				level += 1;
				stopspawn = false;
				trace ("Level:" + level);
			}
			else if ((level == 4)&&(zombieskilled >= 40)){
				zombiespawncount = 9;
				level += 1;
				stopspawn = false;
				trace ("Level:" + level);
			}
			else if ((level == 5)&&(zombieskilled >= 50)){
				zombiespawncount = 9;
				level += 1;
				stopspawn = false;
				trace ("Level:" + level);
			}
			else if ((level == 6)&&(zombieskilled >= 60)){
				zombiespawncount = 9;
				level += 1;
				stopspawn = false;
				trace ("Level:" + level);
			}
			else if ((level == 7)&&(zombieskilled >= 70)){
				zombiespawncount = 9;
				level += 1;
				stopspawn = false;
				trace ("Level:" + level);
			}
			else if ((level == 8)&&(zombieskilled >= 80)){
				zombiespawncount = 9;
				level += 1;
				stopspawn = false;
				trace ("Level:" + level);
			}
			else if ((level == 9)&&(zombieskilled >= 90)){
				zombiespawncount = 9;
				//level += 1;
				stopspawn = false;
				currentstage += 1;
				//move to  next stage
				nextstage();
			}
		}
		public function nextstage():void{
			if (currentstage == 1){
				trace ("Stage 1");
				environment.gotoAndStop(1);
				ground.gotoAndStop(1);
			}
			else if (currentstage == 2){
				level = 1;
				zombieskilled = 0;
				trace ("Stage 2");
				environment.gotoAndStop(2);
				ground.gotoAndStop(2);
			}
		}

///////////////////////////////////////////////////////
//						WEAPONS
///////////////////////////////////////////////////////
		//create a array to hold all bullets fired
		var bulletList:Array = [];
		public function shootBullet():void {
			//create new bullet based on players X/Y and Rotation
			var bullet:Bullet = new Bullet(stage, player.x, player.y, player.rotation);
			//Add event to bullets to remove them from array when removed from stage
			bullet.addEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved, false, 0, true);
			//add bullet to array
			bulletList.push(bullet);
			//add bullet to stage
			ground.addChild(bullet);
			//reduce ammo by 1
		}
		//removes bullet from array
		public function bulletRemoved(e:Event):void{
			//remove the event listner from current bullet
			e.currentTarget.removeEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved);
			//remove current bullet from array
			bulletList.splice(bulletList.indexOf(e.currentTarget),1);
		}
		public function removeBullets():void{
			for (var bidx:int = bulletList.length - 1; bidx >= 0; bidx--){
				var bullet1:Bullet = bulletList[bidx];
				if(bullet1.x > 800 || bullet1.x < 0 || bullet1.y > 368 || bullet1.y < 0) {
					ground.removeChild(bullet1);
				}
				//SHOOT THRU WALLS CHEAT
				if (shootthruwalls == false){
				//check if bullet hits wall and remove
					if (environment.hitTestPoint(bullet1.x,bullet1.y, true)){
						if (ground.contains(bullet1)){
							ground.removeChild(bullet1);
						}
					}
					//check if bullet hits door
					if ((door.hitTestPoint(bullet1.x,bullet1.y, true))||(door.hitTestPoint(bullet1.x,bullet1.y, true))){
						if (ground.contains(bullet1)){
							ground.removeChild(bullet1);
						}
					}
				}
			}
		}
		public function shootFlames():void{
			if (mousePressed == true){
						flamethrowerflames.rotation=player.rotation;
						addChild(flamethrowerflames);
						flamethrowerflames.x = player.x;
						flamethrowerflames.y = player.y;
			}
		}

		public function removeFlames():void{
			if((this.contains(flamethrowerflames))&&(mousePressed == false)){
				removeChild(flamethrowerflames);
			}
		}
		
///////////////////////////////////////////////////////
//							ITEMS
///////////////////////////////////////////////////////
		//check if player collects an item
		public function collectItem():void{
			//check if player "collects" Ammo
			if (player.hitTestObject(ammocrate)){
				//run colleted ammo function
				collectAmmo();
			}
			//check if player "collects" Medpack
			if (player.hitTestObject(medpack)){
				//run colleted medpack function
				collectMedpack();
			}
			//check if player "collects" Speedpack
			if (player.hitTestObject(speedpack)){
				//run colleted speedpack function
				collectSpeedpack();
			}
			//check if player "collects" Torch
			if (player.hitTestObject(torch)){
				//run colleted medpack function
				collectTorch();
			}
		}
		//torch
		public function collectTorch():void {
			if (this.contains(torch)){
				//remove item from stage
				removeChild(torch);
				playerhastorch = true;
				//update lighting
				lighting();
			}
		}
		//AMMO
		public function collectAmmo():void {
			//check if item exists
			if (this.contains(ammocrate)){
				//remove item from stage
				removeChild(ammocrate);
				//add ammo to current ammo count
				pistolammo += 100;
				uziammo += 100;
				shotgunammo += 100;
				flamethrowerammo += 1000;
				ammoempty = false;
				trace ("Collected Ammo");
			}
		}
		//MEDPACK
		public function collectMedpack():void {
			//check if item exists
			if (this.contains(medpack)){
				//remove item from stage
				removeChild(medpack);
			}
			//Check if health is less than 90
			if (health <= 90){
				//add 10 health to current health count
				health += 50;
			}
			//check if health is greater than 90
			else if(health > 90){
				//set current health to 100
				health = 100;
			}
			trace ("Collected Medpack");
		}
		
		//SPEEDPACK
		public function collectSpeedpack():void {
			if (this.contains(speedpack)){
				//adds timer listener event when speed pack is collected
				addEventListener(TimerEvent.TIMER, checkSpeedPackTimer);
				//check if item exists
				//remove item from stage
				removeChild(speedpack);
				//set player speed to 4
				player_speed = 4;
				//start timer
				Timer10.start();
				//set collected speed pack to true
				collectedSpeedPack = true;
				trace ("Collected Speedpack");
			}
		}
///////////////////////////////////////////////////////
//							ITEM TIMERS
///////////////////////////////////////////////////////
		public function checkSpeedPackTimer():void{
			//check if player has speedpack
			if (collectedSpeedPack == true){
				//increase timer
				SecondsElapsed++;
				//check if timer has "ticked" 500 times
				if (SecondsElapsed >= 500){
					//stop timer
					Timer10.stop();
					//reset timer
					SecondsElapsed = 0;
					//remove timer listen event
					removeEventListener(TimerEvent.TIMER, checkSpeedPackTimer);
					//set collected speedpack back to false
					collectedSpeedPack = false;
					//set player speed back to default
					player_speed = 2;
				}
			}
		}
///////////////////////////////////////////////////////
//							LEVEL ITEMS
///////////////////////////////////////////////////////
		//open door
		public function openDoor():void{
			
			//close door after it opens
			if ((door.y > 284.95)&&(dooropening == false)){
				door.y --;
			}
			if (door.hitTestObject(player)){
				if (door.y <= 350){
					door.y ++;
					dooropening = true;
				}
				trace ("Door Opening");
			}else{
				dooropening = false;
			}
			//close door after it opens
			if ((door2.y > 167.45)&&(door2opening == false)){
				door2.y --;
			}
			if (door2.hitTestObject(player)){
				if (door2.y <= 350){
					door2.y ++;
					door2opening = true;
				}
				trace ("Door Opening");
			}else{
				door2opening = false;
			}
		}
///////////////////////////////////////////////////////
//							GUI/TEXT
///////////////////////////////////////////////////////
		public function updatetext():void{
			if (isusingpistol == true){
				ui.ammotext.text = pistolammo.toString();
			}
			if (isusinguzi == true){
				ui.ammotext.text = uziammo.toString();
			}
			if (isusingshotgun == true){
				ui.ammotext.text = shotgunammo.toString();
			}
			if (isusingflamethrower == true){
				ui.ammotext.text = flamethrowerammo.toString();
			}
			
			ui.healthtext.text = health.toString();
			ui.armourtext.text = armour.toString();
			ui.zombieskilledtext.text = totalzombieskilled.toString();
			ui.cashtext.text = currentcash.toString();
			ui.leveltext.text = level.toString();
			//weapon icon in gui
			//pistol
			if (isusingpistol == true){
				ui.icon_pistol.visible = true;
				ui.icon_uzi.visible = false;
				ui.icon_shotgun.visible = false;
				ui.icon_flamethrower.visible = false;
			}
			//uzi
			if (isusinguzi == true){
				ui.icon_pistol.visible = false;
				ui.icon_uzi.visible = true;
				ui.icon_shotgun.visible = false;
				ui.icon_flamethrower.visible = false;
			}
			//shotgun
			if (isusingshotgun == true){
				ui.icon_pistol.visible = false;
				ui.icon_uzi.visible = false;
				ui.icon_shotgun.visible = true;
				ui.icon_flamethrower.visible = false;
			}
			//flamethrower
			if (isusingflamethrower == true){
				ui.icon_pistol.visible = false;
				ui.icon_uzi.visible = false;
				ui.icon_shotgun.visible = false;
				ui.icon_flamethrower.visible = true;
			}
		}
///////////////////////////////////////////////////////
//							GAMEOVER
///////////////////////////////////////////////////////
	public function gameover():void{
		ispaused = true;
					stage.removeEventListener(Event.ENTER_FRAME,mainloop);
					stage.removeEventListener(Event.ENTER_FRAME,processScripts);
					trace("GAME OVER");
					stage.addChild(gameoverscreen);
					gameoverscreen.restartgame.addEventListener(MouseEvent.CLICK, restartGame);
		
	}
///////////////////////////////////////////////////////
//							MISC
///////////////////////////////////////////////////////
		//converts degrees to radians
		public function to_radians(n:Number):Number {
			return (n*0.0174532925);
		}
		//converts radians to degrees
		public function to_degrees(n:Number):Number {
			return (n*57.2957795);
		}
		//random number generator
		public function randomRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
	}//end class
}//end package