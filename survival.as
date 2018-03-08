package {
	import flash.geom.*;
    import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.net.*;
	import flash.utils.*;
	import flash.system.System;
	
	public class survival extends Sprite {

public static var traceoutput:Boolean = false;

	public var cheatscreen:cheatscreen_mc = new cheatscreen_mc();
	public var confirmsavescreen:confirmsavescreen_mc = new confirmsavescreen_mc();
	public var gameoverdeath:Boolean = false;
	public var hascheated:Boolean = false;
	
		//global variables
		public static var environment:environment_mc = new environment_mc();
		public static var intro:intro_mc = new intro_mc();
		public static var player:player_mc = new player_mc();
		public static var door:door_mc = new door_mc();
		public static var door2:door_mc = new door_mc();
		
		public var pausescreen:pausescreen_mc = new pausescreen_mc();
		public var gameoverscreen:gameoverscreen_mc = new gameoverscreen_mc();
		public var rankscreen:rankscreen_mc = new rankscreen_mc();
		public var confirmrestartgame:confirmrestartgame_mc = new confirmrestartgame_mc();
		public var achivementscreen:achivementscreen_mc = new achivementscreen_mc();
		public var shopscreen:shopscreen_mc = new shopscreen_mc();
		public var statsscreen:statsscreen_mc = new statsscreen_mc();
		public var confirmsave:confirmsave_mc = new confirmsave_mc();
		
		public var light:light_mc= new light_mc();
		public var ground:ground_mc = new ground_mc();
		public var groundtop:groundtop_mc = new groundtop_mc();
		public var ui:ui_mc = new ui_mc();
		public var deadzombie:deadzombie_mc = new deadzombie_mc();
		public static var enemycontainer:enemycontainer_mc = new enemycontainer_mc();
		//items
		public static var ammocrate:ammocrate_mc = new ammocrate_mc();
		public static var medpack:medpack_mc = new medpack_mc();
		public static var speedpack:speedpack_mc = new speedpack_mc();
		public static var torch:torch_mc= new torch_mc();
		//weapons
		public var pistol:pistol_mc = new pistol_mc();
		public var chaingun:chaingun_mc = new chaingun_mc();
		public var uzi:uzi_mc = new uzi_mc();
		public var shotgun:shotgun_mc = new shotgun_mc();
		public var bulletproofvest:bulletproofvest_mc = new bulletproofvest_mc();
		public var flamethrower:flamethrower_mc = new flamethrower_mc();
		
		public var flamethrowerflames:flamethrowerflames_mc = new flamethrowerflames_mc();
		
		public var isusingpistol:Boolean = true;
		public var isusinguzi:Boolean = false;
		public var isusingshotgun:Boolean = false;
		public var isusingflamethrower:Boolean = false;
		public var isusingchaingun:Boolean = false;
		
		public var haschaingun:Boolean = false;
		public var haspistol:Boolean = true;
		public var hasuzi:Boolean = false;
		public var hasshotgun:Boolean = false;
		public var hasflamethrower:Boolean = false;
		
		public var ammoempty:Boolean;//ammo empty check
		public var dooropening:Boolean = false;//door moving check
		public var playerhitobject:Boolean = false; // has player hit a object
		public var door2opening:Boolean = false;//door2 moving check
		public var stopspawn:Boolean= false;//zombie spawn control
		
		public var key_pressed:int=0;
		public var radius:int=8;//players "size" (sphere)
		public var up,down,left,right:Boolean=false;
		public var weapon1,weapon2,weapon3,weapon4,weapon5:Boolean=false;//switch weapon keys 1,2,3
		public var mousePressed:Boolean = false; //keeps track of whether the mouse is currently pressed down
		//shooting speed
		public var delayCounter:int = 0; //we use this to add delay between the shots
		public var delayMax:int = 15; //default pistol delay
		//ammo
		public var pistolammo:int = 200;//starting pistol ammo
		public var uziammo:int = 0;
		public var shotgunammo:int = 0;
		public var flamethrowerammo:int = 0;
		public var chaingunammo:int = 0;
		
		public var hasarmour:Boolean = true;
		public var armour:int = 0;//starting armour
		public var health:int = 100;//starting health
		
		
		//zombies
		public var Zombiesspawnedtotal:int = 0;
		public var zombieskilled:int = 0;//total zombies killed for current stage
		public var totalzombieskilled:int = 0;//total zombies killed all up
		public var zombiecount:int = 0;// how many zombies created
		public var zombiespawncount:int = 19; // MUST BE 1 LESS than actual count!! used as starting zombie spawn count
		public var totalzomibes:int = 0; // total zombies spawned
		public var zomibeskilled:int = 0; // total zombies killed
		
		public static var bossspawn:Boolean = false; // spawn boss
		
		//timers
		public var SecondsElapsed:Number = 1;
		public var SecondsElapsedRANK:Number = 1;
		public var UiSecondsElapsed:Number = 1;
		public var Timer10:Timer = new Timer(1000, 10);
		public var UiTimer10:Timer = new Timer(1000, 10);
		
		public var collectedSpeedPack:Boolean = false;
		
		public var level:int = 1;//set start level 5 is boss
		public static var currentcash:int = 0;//cash
		public var deaths:int = 0;

		//what stage to start on
		public var currentstage:int = 1; 
		//cheats
		public var shootthruwalls:Boolean = false;
		public var walkthruwalls:Boolean = false;
		public var infintehealth:Boolean = false;
		public var nofogcheat:Boolean = false;
		public var maxlight:Boolean = false;
		public var infinteammo:Boolean = false;

		public var player_speed:int = 2;//player movement speed (Default is 2)
		public var playerhastorch:Boolean = false;
		
		public static var ispaused:Boolean = false;
		public var currentrank:int = 0;
		public static var experience:int = 1;		
		
		//ranks
		public var Rankedup:Boolean = false;
		public var rankupshown:Boolean = false;
		public static var rankup:rankup_mc = new rankup_mc();
		
		public static var rank0:rank0_mc = new rank0_mc();
		public static var rank1:rank1_mc = new rank1_mc();
		public static var rank2:rank2_mc = new rank2_mc();
		public static var rank3:rank3_mc = new rank3_mc();
		public static var rank4:rank4_mc = new rank4_mc();
		public static var rank5:rank5_mc = new rank5_mc();
		public static var rank6:rank6_mc = new rank6_mc();
		public static var rank7:rank7_mc = new rank7_mc();
		public static var rank8:rank8_mc = new rank8_mc();
		public static var rank9:rank9_mc = new rank9_mc();
		public static var rank10:rank10_mc = new rank10_mc();
		public static var rank11:rank11_mc = new rank11_mc();
		public static var rank12:rank12_mc = new rank12_mc();
		public static var rank13:rank13_mc = new rank13_mc();
		public static var rank14:rank14_mc = new rank14_mc();
		public static var rank15:rank15_mc = new rank15_mc();
		public static var rank16:rank16_mc = new rank16_mc();
		public static var rank17:rank17_mc = new rank17_mc();
		public static var rank18:rank18_mc = new rank18_mc();
		public static var rank19:rank19_mc = new rank19_mc();

		public var s1:fogbg_mc = new fogbg_mc();
		
		public static var dropmed:Boolean = false;
		public static var dropammo:Boolean = false;
		
		var frames:int=0;
		var FPS:int=0;
		var prevTimer:Number=0;
		var curTimer:Number=0;
		
		//Intilize game code
		public function survival():void {
			addChild(intro);
			intro.startgame.addEventListener(MouseEvent.CLICK, startgame);
		}
		public function debugstuff():void {
			frames+=1;
			curTimer=getTimer();
				if(curTimer-prevTimer>=1000){
					FPS = Math.round(frames*1000/(curTimer-prevTimer));
					
					prevTimer=curTimer;
					frames=0;
				}
			debugmemorytext.text = ((System.totalMemory / 1024 / 1024).toFixed(2)).toString() + "MB";
			debugfpstext.text = FPS.toString();
			debugtotalzombies.text = Zombiesspawnedtotal.toString();
		}
		//START GAME
		public function startgame(event:MouseEvent):void {
			intro.startgame.removeEventListener(MouseEvent.CLICK, startgame);
			if (this.contains(intro)){
			removeChild(intro);
			}
			stopspawn = false;//zombie spawn control
			
			//Timer
			timer.start();
			timer.addEventListener(TimerEvent.TIMER, timerTickHandler);
			
			
			//load achivement data
			loadachiveData();
			ProcessXP(); //setup rank
			processfog(); //start fog

			//environment
			addChild(environment);
			setChildIndex(environment,0);
			environment.x=0;
			environment.y=0;
			environment.gotoAndStop(1);//go to first stage
			

			//Add action enemycontainer
			addChild(enemycontainer);
			setChildIndex(enemycontainer,1)
			enemycontainer.x=0;
			enemycontainer.y=0;
			
										
			//Add the background
			enemycontainer.addChild(ground);
			enemycontainer.setChildIndex(ground,0);
			ground.x=0;
			ground.y=0;
			ground.gotoAndStop(1);//go to first stage
			
			addChild(groundtop);
			setChildIndex(groundtop,2);
			groundtop.x=0;
			groundtop.y=0;
			groundtop.gotoAndStop(1);//go to first stage
			
			//add the player
			addChild(player);
			setChildIndex(player,2);
			player.x = 400;
            player.y = 200;
			
			//lighting
            addChild(light);
			setChildIndex(light,4);
			var myBlur:BlurFilter = new BlurFilter();
			myBlur.quality = 5;
			myBlur.blurX = 50;
			myBlur.blurY = 50;
			light.filters = [myBlur];
			//set up light
			light.x = player.x;
			light.y = player.y;
			light.gotoAndStop(2);
			
			//add UI
			addChild(ui);
			setChildIndex(ui,5);
			ui.x=315;
			ui.y=346;
			
			//add listener to run on every frame
			stage.addEventListener(Event.ENTER_FRAME,mainloop);
			stage.addEventListener(Event.ENTER_FRAME,processScripts);
			//add keyboard listeners
			stage.addEventListener(KeyboardEvent.KEY_DOWN, on_key_down);
			stage.addEventListener(KeyboardEvent.KEY_UP, on_key_up);
			//add mouse listeners
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
			if(traceoutput == true){
				trace ("Game Intialised");
			}
			
		}
		//MAIN GAME LOOP
		public function mainloop(e:Event):void {
			//debug fps + mem
			debugstuff();
			processfog();
			
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
					playerMoving();
					light.y--;
				}
				while (environment.hitTestPoint(player.x, player.y-radius, true)) {
					player.y++;
					playerMoving();
					light.y++;
				}
				while (environment.hitTestPoint(player.x-radius, player.y, true)) {
					player.x++;
					playerMoving();
					light.x++;
				}
				while (environment.hitTestPoint(player.x+radius, player.y, true)) {
					player.x--;
					playerMoving();
					light.x--;
				}
				/* TEMP DISABLE DOOR CODE TILL NEEDED
				while ((door.hitTestPoint(player.x, player.y+radius, true))||(door2.hitTestPoint(player.x, player.y+radius, true))) {
					player.y--;
					playerMoving();
				}
				while ((door.hitTestPoint(player.x, player.y-radius, true))||(door2.hitTestPoint(player.x, player.y-radius, true))) {
					player.y++;
					playerMoving();
				}
				while ((door.hitTestPoint(player.x-radius, player.y, true))||(door2.hitTestPoint(player.x-radius, player.y, true))) {
					player.x++;
					playerMoving();
				}
				while ((door.hitTestPoint(player.x+radius, player.y, true))||(door2.hitTestPoint(player.x+radius, player.y, true))) {
					player.x--;
					playerMoving();
				}
				*/
			}
			//SHOOTING
			if(mousePressed == true){
				delayCounter++; //increase the delayCounter by 1
				if(delayCounter == delayMax){
					if ((isusingpistol == true) && (pistolammo >= 1)){
						if(infinteammo == false){
							pistolammo -= 1;
						}
						globalpistolbullets += 1;
						shootBullet(); //shoot a bullet
						delayCounter = 0; //reset the delay counter so there is a pause between bullets
					}
					if ((isusingshotgun == true) && (shotgunammo >= 1)){
						if(infinteammo == false){
							shotgunammo -= 1;
						}
						globalshotgunbullets += 1;
						shootShotgun(); //shoot a bullet
						delayCounter = 0; //reset the delay counter so there is a pause between bullets
					}
					if ((isusinguzi == true) && (uziammo >= 1)){
						if(infinteammo == false){
							uziammo -= 1;
						}
						globaluzibullets += 1;
						shootBullet(); //shoot a bullet
						delayCounter = 0; //reset the delay counter so there is a pause between bullets
					}
					if ((isusingflamethrower == true) && (flamethrowerammo >= 1)){
						delayCounter = 0;
						shootFlames();
						if(infinteammo == false){
							flamethrowerammo -= 1;
						}
						globalflamethrowerbullets += 1;
					}
					if ((isusingchaingun == true) && (chaingunammo >= 1)){
						if(infinteammo == false){
							chaingunammo -= 2;
						}
						globalchaingunbullets += 2;
						shootChaingunBullet(); //shoot a bullet
						delayCounter = 0; //reset the delay counter so there is a pause between bullets
					}
				}
			}
			if(bulletList.length > 0){
				for(var ii:int = bulletList.length-1; ii >= 0; ii--){
					bulletList[ii].loop();
				}
			}
		}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//					SCRIPTS / MODULES
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function processScripts(e:Event):void{
			updatetext();
			checkSpeedPackTimer();
			createZombies();
			checkzombieHit();
			//openDoor();
			lighting();
			playerMoving();
			//remove flame thrower flames
			removeFlames();
			//dont save every frame need tofigure out when to save
			//saveachiveData();// save achivement data to disk
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							Time Played
//////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		public var timer:Timer = new Timer(60);
		public var timerCount:int = 0;
		public var globaltimerCount:int = 0;
		
		public function timerTickHandler(Event:TimerEvent):void
		{
			timerCount += 60;
			globaltimerCount += 60;
			timePlayed(timerCount);
		}
		
		public var currentseconds:int;
		public var currentminutes:int;
		public var currenthours:int;
		public var globalseconds:int;
		public var globalminutes:int;
		public var globalhours:int;
		public var totalTimeplayed:int;
		
		public function timePlayed(milliseconds:int):void{
			var time:Date = new Date(milliseconds);
			var minutes:int = time.minutes;
			var seconds:int = time.seconds;
			var hours:int = time.hours;
			var displayhours:String = hours.toString();
			var displayminutes:String = minutes.toString();
			var displayseconds:String = seconds.toString();
			
			var displayglobalhours:String = globalhours.toString();
			var displayglobalminutes:String = globalminutes.toString();
			var displayglobalseconds:String = globalseconds.toString();
			
			displayglobalseconds = ((globaltimerCount /1000).toFixed(0)).toString();
			displayglobalminutes = (globalminutes).toString();
			displayglobalhours = (globalhours).toString();
			
			displayhours = (displayhours.length != 2) ? '0'+displayhours : displayhours;
			displayminutes = (displayminutes.length != 2) ? '0'+displayminutes : displayminutes;
			displayseconds = (displayseconds.length != 2) ? '0'+displayseconds : displayseconds;
			
			displayglobalhours = (displayglobalhours.length != 2) ? '0'+displayglobalhours : displayglobalhours;
			displayglobalminutes = (displayglobalminutes.length != 2) ? '0'+displayglobalminutes : displayglobalminutes;
			displayglobalseconds = (displayglobalseconds.length != 2) ? '0'+displayglobalseconds : displayglobalseconds;
			
			statsscreen.currenttimeplayedtext.text = displayglobalhours + ":" +displayglobalminutes + ":" + displayglobalseconds;//current time played
			statsscreen.timeplayedtext.text = displayhours + ":" +displayminutes + ":" + displayseconds; //toatal time played
			totalTimeplayed = minutes;
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							STATS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		public function showstatsscreen(event:MouseEvent):void {
			pausescreen.addChild(statsscreen);
			statsscreen.exitstatsscreen.addEventListener(MouseEvent.CLICK, closestatsscreen);
			updateStats();
		}
		public function closestatsscreen(event:MouseEvent):void {
			pausescreen.gotostatsscreen.addEventListener(MouseEvent.CLICK, showstatsscreen);
			if(pausescreen.contains(statsscreen)){
				pausescreen.removeChild(statsscreen);
			}
		}
		public function updateStats():void{
			statsscreen.globalcashearnttext.text = ("$" + globalcashearnt.toString());
			statsscreen.globalcashspenttext.text = ("$" + globalcashspent.toString());
			
			statsscreen.globalzombiekillstext.text = globalzombiekills.toString();
			
			statsscreen.globalpistolbulletstext.text = globalpistolbullets.toString();
			statsscreen.globaluzibulletstext.text = globaluzibullets.toString();
			statsscreen.globalshotgunbulletstext.text = globalshotgunbullets.toString();
			statsscreen.globalflamethrowerbulletstext.text = globalflamethrowerbullets.toString();
			statsscreen.globalchaingunbulletstext.text = globalchaingunbullets.toString();
			statsscreen.deathstext.text = deaths.toString();
		}
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							ACHIVEMENTS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		public function showachivementscreen(event:MouseEvent):void {
			pausescreen.addChild(achivementscreen);
			achivementscreen.exitachivementscreen.addEventListener(MouseEvent.CLICK, closeachivementscreen);
			//updateachivementtext();
			showAchivements();
		}
		public function closeachivementscreen(event:MouseEvent):void {
			pausescreen.gotoachivementscreen.addEventListener(MouseEvent.CLICK, showachivementscreen);
			if(pausescreen.contains(achivementscreen)){
				pausescreen.removeChild(achivementscreen);
			}
		}
		
		public var saveAchivementDataObject:SharedObject;
		//ADD NEW ACHIVES TO BOTTOM !!
		//cash
		public static var globalcashearnt:int;
		public var globalcashspent:int;
		
		//weapons
		public var globalpistolbullets:int;
		public var globaluzibullets:int;
		public var globalshotgunbullets:int;
		public var globalflamethrowerbullets:int;
		public var globalchaingunbullets:int;
				
		//zombies
		public var globalzombiekills:int;
		
		//achivements
		public var achive1,achive2,achive3,achive4,achive5,achive6,achive7,achive8,achive9,achive10:Boolean;
		public var achive11,achive12,achive13,achive14,achive15,achive16,achive17,achive18,achive19,achive20:Boolean;
		public var achive21,achive22,achive23,achive24,achive25,achive26,achive27,achive28,achive29,achive30:Boolean;
		public var achive31,achive32,achive33,achive34,achive35,achive36,achive37,achive38,achive39,achive40:Boolean;
		public var achive41,achive42,achive43,achive44,achive45,achive46,achive47,achive48,achive49,achive50:Boolean;
		
		public function showAchivements():void{
			//cash earnt
			if (achive1 == true){
				achivementscreen.cashearnt1.visible = true;
			} else {
				achivementscreen.cashearnt1.visible = false;
			}
			if (achive2 == true){
				achivementscreen.cashearnt2.visible = true;
			} else {
				achivementscreen.cashearnt2.visible = false;
			}
			if (achive3 == true){
				achivementscreen.cashearnt3.visible = true;
			} else {
				achivementscreen.cashearnt3.visible = false;
			}
			if (achive4 == true){
				achivementscreen.cashearnt4.visible = true;
			} else {
				achivementscreen.cashearnt4.visible = false;
			}
			if (achive5 == true){
				achivementscreen.cashearnt5.visible = true;
			} else {
				achivementscreen.cashearnt5.visible = false;
			}
			//cash spent
			if (achive6 == true){
				achivementscreen.cashspent1.visible = true;
			} else {
				achivementscreen.cashspent1.visible = false;
			}
			if (achive7 == true){
				achivementscreen.cashspent2.visible = true;
			} else {
				achivementscreen.cashspent2.visible = false;
			}
			if (achive8 == true){
				achivementscreen.cashspent3.visible = true;
			} else {
				achivementscreen.cashspent3.visible = false;
			}
			if (achive9 == true){
				achivementscreen.cashspent4.visible = true;
			} else {
				achivementscreen.cashspent4.visible = false;
			}
			if (achive10 == true){
				achivementscreen.cashspent5.visible = true;
			} else {
				achivementscreen.cashspent5.visible = false;
			}
			//zombie kills
			if (achive11 == true){
				achivementscreen.zombiekills1.visible = true;
			} else {
				achivementscreen.zombiekills1.visible = false;
			}
			if (achive12 == true){
				achivementscreen.zombiekills2.visible = true;
			} else {
				achivementscreen.zombiekills2.visible = false;
			}
			if (achive13 == true){
				achivementscreen.zombiekills3.visible = true;
			} else {
				achivementscreen.zombiekills3.visible = false;
			}
			if (achive14 == true){
				achivementscreen.zombiekills4.visible = true;
			} else {
				achivementscreen.zombiekills4.visible = false;
			}
			if (achive15 == true){
				achivementscreen.zombiekills5.visible = true;
			} else {
				achivementscreen.zombiekills5.visible = false;
			}
			//pistol bullets
			if (achive16 == true){
				achivementscreen.pistolbullets1.visible = true;
			} else {
				achivementscreen.pistolbullets1.visible = false;
			}
			if (achive17 == true){
				achivementscreen.pistolbullets2.visible = true;
			} else {
				achivementscreen.pistolbullets2.visible = false;
			}
			if (achive18 == true){
				achivementscreen.pistolbullets3.visible = true;
			} else {
				achivementscreen.pistolbullets3.visible = false;
			}
			if (achive19 == true){
				achivementscreen.pistolbullets4.visible = true;
			} else {
				achivementscreen.pistolbullets4.visible = false;
			}
			if (achive20 == true){
				achivementscreen.pistolbullets5.visible = true;
			} else {
				achivementscreen.pistolbullets5.visible = false;
			}
			
			//uzi bullets
			if (achive21 == true){
				achivementscreen.uzibullets1.visible = true;
			} else {
				achivementscreen.uzibullets1.visible = false;
			}
			if (achive22 == true){
				achivementscreen.uzibullets2.visible = true;
			} else {
				achivementscreen.uzibullets2.visible = false;
			}
			if (achive23 == true){
				achivementscreen.uzibullets3.visible = true;
			} else {
				achivementscreen.uzibullets3.visible = false;
			}
			if (achive24 == true){
				achivementscreen.uzibullets4.visible = true;
			} else {
				achivementscreen.uzibullets4.visible = false;
			}
			if (achive25 == true){
				achivementscreen.uzibullets5.visible = true;
			} else {
				achivementscreen.uzibullets5.visible = false;
			}
			//shotgun bullets
			if (achive26 == true){
				achivementscreen.shotgunbullets1.visible = true;
			} else {
				achivementscreen.shotgunbullets1.visible = false;
			}
			if (achive27 == true){
				achivementscreen.shotgunbullets2.visible = true;
			} else {
				achivementscreen.shotgunbullets2.visible = false;
			}
			if (achive28 == true){
				achivementscreen.shotgunbullets3.visible = true;
			} else {
				achivementscreen.shotgunbullets3.visible = false;
			}
			if (achive29 == true){
				achivementscreen.shotgunbullets4.visible = true;
			} else {
				achivementscreen.shotgunbullets4.visible = false;
			}
			if (achive30 == true){
				achivementscreen.shotgunbullets5.visible = true;
			} else {
				achivementscreen.shotgunbullets5.visible = false;
			}
			//flamethrower bullets
			if (achive31 == true){
				achivementscreen.flamethrowerbullets1.visible = true;
			} else {
				achivementscreen.flamethrowerbullets1.visible = false;
			}
			if (achive32 == true){
				achivementscreen.flamethrowerbullets2.visible = true;
			} else {
				achivementscreen.flamethrowerbullets2.visible = false;
			}
			if (achive33 == true){
				achivementscreen.flamethrowerbullets3.visible = true;
			} else {
				achivementscreen.flamethrowerbullets3.visible = false;
			}
			if (achive34 == true){
				achivementscreen.flamethrowerbullets4.visible = true;
			} else {
				achivementscreen.flamethrowerbullets4.visible = false;
			}
			if (achive35 == true){
				achivementscreen.flamethrowerbullets5.visible = true;
			} else {
				achivementscreen.flamethrowerbullets5.visible = false;
			}
			//chaingun bullets
			if (achive36 == true){
				achivementscreen.chaingunbullets1.visible = true;
			} else {
				achivementscreen.chaingunbullets1.visible = false;
			}
			if (achive37 == true){
				achivementscreen.chaingunbullets2.visible = true;
			} else {
				achivementscreen.chaingunbullets2.visible = false;
			}
			if (achive38 == true){
				achivementscreen.chaingunbullets3.visible = true;
			} else {
				achivementscreen.chaingunbullets3.visible = false;
			}
			if (achive39 == true){
				achivementscreen.chaingunbullets4.visible = true;
			} else {
				achivementscreen.chaingunbullets4.visible = false;
			}
			if (achive40 == true){
				achivementscreen.chaingunbullets5.visible = true;
			} else {
				achivementscreen.chaingunbullets5.visible = false;
			}
			//deaths
			if (achive41 == true){
				achivementscreen.deaths1.visible = true;
			} else {
				achivementscreen.deaths1.visible = false;
			}
			if (achive42 == true){
				achivementscreen.deaths2.visible = true;
			} else {
				achivementscreen.deaths2.visible = false;
			}
			if (achive43 == true){
				achivementscreen.deaths3.visible = true;
			} else {
				achivementscreen.deaths3.visible = false;
			}
			if (achive44 == true){
				achivementscreen.deaths4.visible = true;
			} else {
				achivementscreen.deaths4.visible = false;
			}
			if (achive45 == true){
				achivementscreen.deaths5.visible = true;
			} else {
				achivementscreen.deaths5.visible = false;
			}
			//timeplayed
			if (achive46 == true){
				achivementscreen.time1.visible = true;
			} else {
				achivementscreen.time1.visible = false;
			}
			if (achive47 == true){
				achivementscreen.time2.visible = true;
			} else {
				achivementscreen.time2.visible = false;
			}
			if (achive48 == true){
				achivementscreen.time3.visible = true;
			} else {
				achivementscreen.time3.visible = false;
			}
			if (achive49 == true){
				achivementscreen.time4.visible = true;
			} else {
				achivementscreen.time4.visible = false;
			}
			if (achive50 == true){
				achivementscreen.time5.visible = true;
			} else {
				achivementscreen.time5.visible = false;
			}
		}
		
		public function processAchivements():void{
		if(hascheated == false){
			//CASH EARNT
			if( globalcashearnt >= 1000){
				achive1 = true;
			}
			if( globalcashearnt >= 5000){
				achive2 = true;
			}
			if( globalcashearnt >= 10000){
				achive3 = true;
			}
			if( globalcashearnt >= 100000){
				achive4 = true;
			}
			if( globalcashearnt >= 1000000){
				achive5 = true;
			}
			//CASH SPENT
			if( globalcashspent>= 1000){
				achive6 = true;
			}
			if( globalcashspent >= 5000){
				achive7 = true;
			}
			if( globalcashspent >= 10000){
				achive8 = true;
			}
			if( globalcashspent >= 100000){
				achive9 = true;
			}
			if( globalcashspent >= 1000000){
				achive10 = true;
			}
			//ZOMBIES KILLED
			if( globalzombiekills >= 1000){
				achive11 = true;
			}
			if( globalzombiekills >= 5000){
				achive12 = true;
			}
			if( globalzombiekills >= 10000){
				achive13 = true;
			}
			if( globalzombiekills >= 100000){
				achive14 = true;
			}
			if( globalzombiekills >= 1000000){
				achive15 = true;
			}
			//PISTOL
			if( globalpistolbullets >= 1000){
				achive16 = true;
			}
			if( globalpistolbullets >= 5000){
				achive17 = true;
			}
			if( globalpistolbullets >= 10000){
				achive18 = true;
			}
			if( globalpistolbullets >= 100000){
				achive19 = true;
			}
			if( globalpistolbullets >= 1000000){
				achive20 = true;
			}
			//UZI
			if( globaluzibullets >= 1000){
				achive21 = true;
			}
			if( globaluzibullets >= 5000){
				achive22 = true;
			}
			if( globaluzibullets >= 10000){
				achive23 = true;
			}
			if( globaluzibullets >= 100000){
				achive24 = true;
			}
			if( globaluzibullets >= 1000000){
				achive25 = true;
			}
			//SHOTGUN
	
			if( globalshotgunbullets >= 1000){
				achive26 = true;
			}
			if( globalshotgunbullets >= 5000){
				achive27 = true;
			}
			if( globalshotgunbullets >= 10000){
				achive28 = true;
			}
			if( globalshotgunbullets >= 100000){
				achive29 = true;
			}
			if( globalshotgunbullets >= 1000000){
				achive30 = true;
			}
			//FLAMETHROWER
			
			if( globalflamethrowerbullets >= 1000){
				achive31 = true;
			}
			if( globalflamethrowerbullets >= 5000){
				achive32 = true;
			}
			if( globalflamethrowerbullets >= 10000){
				achive33 = true;
			}
			if( globalflamethrowerbullets >= 100000){
				achive34 = true;
			}
			if( globalflamethrowerbullets >= 1000000){
				achive35 = true;
			}
			//CHAINGUN
			
			if( globalchaingunbullets >= 1000){
				achive36 = true;
			}
			if( globalchaingunbullets >= 5000){
				achive37 = true;
			}
			if( globalchaingunbullets >= 10000){
				achive38 = true;
			}
			if( globalchaingunbullets >= 100000){
				achive39 = true;
			}
			if( globalchaingunbullets >= 1000000){
				achive40 = true;
			}
			//DEATHS
			if( deaths >= 100){
				achive41 = true;
			}
			if( deaths >= 1000){
				achive42 = true;
			}
			if( deaths >= 2000){
				achive43 = true;
			}
			if( deaths >= 5000){
				achive44 = true;
			}
			if( deaths >= 10000){
				achive45 = true;
			}
			//DEATHS
			if( totalTimeplayed >= 1){
				achive46 = true;
			}
			if( totalTimeplayed >= 60){
				achive47 = true;
			}
			if( totalTimeplayed >= 120){
				achive48 = true;
			}
			if( totalTimeplayed >= 300){
				achive49 = true;
			}
			if( totalTimeplayed >= 600){
				achive50 = true;
			}
		}
		}
		public function saveachiveData():void{
			if(hascheated == false){
				saveAchivementDataObject = SharedObject.getLocal("achivements"); 
				saveAchivementDataObject.data.savedglobalcashearnt = globalcashearnt;
				saveAchivementDataObject.data.savedsglobalcashspent = globalcashspent;
				saveAchivementDataObject.data.savedglobalpistolbullets = globalpistolbullets;
				saveAchivementDataObject.data.savedglobaluzibullets = globaluzibullets;
				saveAchivementDataObject.data.savedglobalshotgunbullets = globalshotgunbullets;
				saveAchivementDataObject.data.savedglobalflamethrowerbullets = globalflamethrowerbullets;
				saveAchivementDataObject.data.savedglobalchaingunbullets = globalchaingunbullets;
				saveAchivementDataObject.data.savedglobalzombiekills = globalzombiekills;
				saveAchivementDataObject.data.saveddeaths = deaths;
				saveAchivementDataObject.data.savedtimerCount = timerCount;
				saveAchivementDataObject.data.savedglobalseconds = globalseconds;
				saveAchivementDataObject.data.savedglobalminutes = globalminutes;
				
				saveAchivementDataObject.flush(); // immediately save to the local drive
			}
		}
		public function loadachiveData():void{
			saveAchivementDataObject = SharedObject.getLocal("achivements"); 
			
			globalcashearnt = saveAchivementDataObject.data.savedglobalcashearnt;
			globalcashspent = saveAchivementDataObject.data.savedsglobalcashspent;
			globalpistolbullets = saveAchivementDataObject.data.savedglobalpistolbullets;
			globaluzibullets = saveAchivementDataObject.data.savedglobaluzibullets;
			globalshotgunbullets = saveAchivementDataObject.data.savedglobalshotgunbullets;
			globalflamethrowerbullets = saveAchivementDataObject.data.savedglobalflamethrowerbullets;
			globalchaingunbullets = saveAchivementDataObject.data.savedglobalchaingunbullets;
			globalzombiekills = saveAchivementDataObject.data.savedglobalzombiekills;
			deaths = saveAchivementDataObject.data.saveddeaths;
			timerCount = saveAchivementDataObject.data.savedtimerCount;
			globalseconds = saveAchivementDataObject.data.savedglobalseconds;
			globalminutes = saveAchivementDataObject.data.savedglobalminutes;
		}
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							PAUSE GAME
//////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		public function gamepause():void{
			//process achivements
			saveachiveData();
			processAchivements();
			
			ispaused = true;
			stage.removeEventListener(Event.ENTER_FRAME,mainloop);
			stage.removeEventListener(Event.ENTER_FRAME,processScripts);
			if(traceoutput == true){
				trace("GAME PAUSED");
			}
		}
		public function gameunpause():void{
			//process achivements
			processAchivements();
			saveachiveData();
			
			ispaused = false;
			stage.addEventListener(Event.ENTER_FRAME,mainloop);
			stage.addEventListener(Event.ENTER_FRAME,processScripts);
			if(traceoutput == true){
				trace("GAME RESUMED");
			}
		}
		
		public function openpausescreen(e:MouseEvent):void{
					//process achivements
					saveachiveData();
					processAchivements();
					gamepause();
					stage.addChild(pausescreen);
					pausescreen.gotoshop.addEventListener(MouseEvent.CLICK, showshop);
					pausescreen.gotorankscreen.addEventListener(MouseEvent.CLICK, showrankscreen);
					pausescreen.gotoachivementscreen.addEventListener(MouseEvent.CLICK, showachivementscreen);
					pausescreen.restartgame.addEventListener(MouseEvent.CLICK, restartGame);
					pausescreen.exitpausescreen.addEventListener(MouseEvent.CLICK, closepausescreen);
					pausescreen.savegamebutton.addEventListener(MouseEvent.CLICK, savegamestate);
					pausescreen.savegamebutton.addEventListener(MouseEvent.CLICK, confirmsavegame);
					pausescreen.loadgamebutton.addEventListener(MouseEvent.CLICK, loadgame);
					pausescreen.gotostatsscreen.addEventListener(MouseEvent.CLICK, showstatsscreen);
		}
		public function closepausescreen(e:MouseEvent):void{
					gameunpause();
					// remove event listners from pause screen
					pausescreen.gotoshop.removeEventListener(MouseEvent.CLICK, showshop);
					pausescreen.gotorankscreen.removeEventListener(MouseEvent.CLICK, showrankscreen);
					pausescreen.gotoachivementscreen.removeEventListener(MouseEvent.CLICK, showachivementscreen);
					pausescreen.restartgame.removeEventListener(MouseEvent.CLICK, restartGame);
					pausescreen.exitpausescreen.removeEventListener(MouseEvent.CLICK, closepausescreen);
					pausescreen.savegamebutton.removeEventListener(MouseEvent.CLICK, savegamestate);
					pausescreen.loadgamebutton.removeEventListener(MouseEvent.CLICK, loadgame);
					pausescreen.gotostatsscreen.removeEventListener(MouseEvent.CLICK, showstatsscreen);
					//remove pause screen
					if(stage.contains(pausescreen)){
						stage.removeChild(pausescreen);
					}
		}
		//Confirm save game
		public function confirmsavegame(e:MouseEvent):void{
					pausescreen.addChild(confirmsave);
					confirmsave.savegameYes.addEventListener(MouseEvent.CLICK, savegameYes);
					confirmsave.savegameNo.addEventListener(MouseEvent.CLICK, savegameNo);
		}
		public function savegameYes(e:MouseEvent):void{
					saveData();
					processAchivements();
					saveachiveData();
					confirmsave.savegameYes.removeEventListener(MouseEvent.CLICK, saveData);
					confirmsave.savegameNo.removeEventListener(MouseEvent.CLICK, savegameNo);
					pausescreen.removeChild(confirmsave);
					if(traceoutput == true){
						trace("GAME SAVED");
					}
		}
		public function savegameNo(e:MouseEvent):void{
					confirmsave.savegameYes.removeEventListener(MouseEvent.CLICK, saveData);
					confirmsave.savegameNo.removeEventListener(MouseEvent.CLICK, savegameNo);
					pausescreen.removeChild(confirmsave);
					if(traceoutput == true){
						trace("SAVE ABORTED");
					}
		}
		
		

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							PLAYER
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
					weapon5 = false;
					isusingchaingun = false;
					isusingpistol = true;
					isusinguzi = false;
					isusingshotgun = false;
					isusingflamethrower = false;
					delayMax = 15; //try changing this number to shoot more or less rapidly
					delayCounter = 0;
					if(traceoutput == true){
						trace ("Switched to pistol:" + delayMax);
					}
				break;
				
				case 50 : // 2
				if (hasuzi == true){
					weapon2 = true;
					weapon1 = false;
					weapon3 = false;
					weapon4 = false;
					weapon5 = false;
					isusingchaingun = false;
					isusingpistol = false;
					isusinguzi = true;
					isusingshotgun = false;
					isusingflamethrower = false;
					delayMax = 6; //try changing this number to shoot more or less rapidly
					delayCounter = 0;
					if(traceoutput == true){
						trace ("Switched to uzi:" + delayMax);
					}
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
					weapon5 = false;
					isusingchaingun = false;
					delayMax = 20; //try changing this number to shoot more or less rapidly
					delayCounter = 0;
					if(traceoutput == true){
						trace ("Switched to shotgun:" + delayMax);
					}
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
					weapon5 = false;
					isusingchaingun = false;
					delayMax = 2; //try changing this number to shoot more or less rapidly
					delayCounter = 0;
					if(traceoutput == true){
						trace ("Switched to flamethrower:" + delayMax);
					}
				}
				break;
				case 53 : // 5
				if (haschaingun == true){
					weapon3 = false;
					weapon1 = false;
					weapon2 = false;
					weapon4 = false;
					isusingpistol = false;
					isusinguzi = false;
					isusingshotgun = false;
					isusingflamethrower = false;
					weapon5 = true;
					isusingchaingun = true;
					delayMax = 2; //try changing this number to shoot more or less rapidly
					delayCounter = 0;
					if(traceoutput == true){
						trace ("Switched to chaingun:" + delayMax);
					}
				}
				break;
				case 54 : // 6
					//cheatmenuopen();
					createBoss();
				break;
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
				
				saveachiveData();
			}
		}
		public function checkarmour():void{
			if (armour <=0){
				hasarmour = false;
				saveachiveData();
			}
		}
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//						CHEATS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function cheatmenuopen():void{
			//show cheat menu
			addChild(cheatscreen);
			//pause game
			gamepause();
			cheatscreen.infiniteammoon.addEventListener(MouseEvent.CLICK,cheatammoon);
			cheatscreen.infiniteammooff.addEventListener(MouseEvent.CLICK,cheatammooff);
			cheatscreen.infinitehealthon.addEventListener(MouseEvent.CLICK,cheathealthon);
			cheatscreen.infinitehealthoff.addEventListener(MouseEvent.CLICK,cheathealthoff);
			cheatscreen.shootthruwallson.addEventListener(MouseEvent.CLICK,cheatshootwallon);
			cheatscreen.shootthruwallsoff.addEventListener(MouseEvent.CLICK,cheatshootwalloff);
			cheatscreen.walkthruwallson.addEventListener(MouseEvent.CLICK,cheatnoclipon);
			cheatscreen.walkthruwallsoff.addEventListener(MouseEvent.CLICK,cheatnoclipoff);
			cheatscreen.nofogon.addEventListener(MouseEvent.CLICK,cheatfogon);
			cheatscreen.nofogoff.addEventListener(MouseEvent.CLICK,cheatfogoff);
			cheatscreen.exitcheatmenu.addEventListener(MouseEvent.CLICK,cheatmenuclose);
			if(traceoutput == true){
				trace ("Cheat Menu Opened");
			}
		}
		public function cheatmenuclose(event:MouseEvent):void{
			//remove cheat menu
			if(stage.contains(cheatscreen)){
				removeChild(cheatscreen);
			}
			//pause game
			gameunpause();
			cheatscreen.infiniteammoon.removeEventListener(MouseEvent.CLICK,cheatammoon);
			cheatscreen.infiniteammooff.removeEventListener(MouseEvent.CLICK,cheatammooff);
			cheatscreen.infinitehealthon.removeEventListener(MouseEvent.CLICK,cheathealthon);
			cheatscreen.infinitehealthoff.removeEventListener(MouseEvent.CLICK,cheathealthoff);
			cheatscreen.shootthruwallson.removeEventListener(MouseEvent.CLICK,cheatshootwallon);
			cheatscreen.shootthruwallsoff.removeEventListener(MouseEvent.CLICK,cheatshootwalloff);
			cheatscreen.walkthruwallson.removeEventListener(MouseEvent.CLICK,cheatnoclipon);
			cheatscreen.walkthruwallsoff.removeEventListener(MouseEvent.CLICK,cheatnoclipoff);
			cheatscreen.nofogon.removeEventListener(MouseEvent.CLICK,cheatfogon);
			cheatscreen.nofogoff.removeEventListener(MouseEvent.CLICK,cheatfogoff);
			cheatscreen.exitcheatmenu.removeEventListener(MouseEvent.CLICK,cheatmenuclose);
			if(traceoutput == true){
				trace ("Cheat Menu Closed");
			}
		}
		public function cheatammoon(event:MouseEvent):void{
			cheatscreen.infiteammotext.text = "On";
			infinteammo = true;
			hascheated = true;
		}
		public function cheatammooff(event:MouseEvent):void{
			cheatscreen.infiteammotext.text = "Off";
			infinteammo = false;
		}
		public function cheathealthon(event:MouseEvent):void{
			cheatscreen.infinitehealthtext.text = "On";
			infintehealth = true;
			hascheated = true;
		}
		public function cheathealthoff(event:MouseEvent):void{
			cheatscreen.infinitehealthtext.text = "Off";
			infintehealth = false;
		}
		public function cheatshootwallon(event:MouseEvent):void{
			cheatscreen.shootthruwallstext.text = "On";
			shootthruwalls = true;
			hascheated = true;
		}
		public function cheatshootwalloff(event:MouseEvent):void{
			cheatscreen.shootthruwallstext.text = "Off";
			shootthruwalls = false;
		}
		public function cheatnoclipon(event:MouseEvent):void{
			cheatscreen.walkthruwallstext.text = "On";
			walkthruwalls = true;
			hascheated = true;
		}
		public function cheatnoclipoff(event:MouseEvent):void{
			cheatscreen.walkthruwallstext.text = "Off";
			walkthruwalls = false;
		}
		public function cheatfogon(event:MouseEvent):void{
			cheatscreen.nofogtext.text = "On";
			nofogcheat = true;
			hascheated = true;
		}
		public function cheatfogoff(event:MouseEvent):void{
			cheatscreen.nofogtext.text = "Off";
			nofogcheat = false;
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//						SHOP
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

public var itemname:String;

		public function showshop(event:MouseEvent):void {
			pausescreen.gotoshop.removeEventListener(MouseEvent.CLICK, showshop);
			pausescreen.addChild(shopscreen);
			shopscreen.buytorch.addEventListener(MouseEvent.CLICK, buyTORCH);
			shopscreen.buyarmour.addEventListener(MouseEvent.CLICK, buyARMOUR);
			shopscreen.buymedkit.addEventListener(MouseEvent.CLICK, buyMEDKIT);
			
			shopscreen.buyuzi.addEventListener(MouseEvent.CLICK, buyUZI);
			shopscreen.buyshotgun.addEventListener(MouseEvent.CLICK, buySHOTGUN);
			shopscreen.buyflamethrower.addEventListener(MouseEvent.CLICK, buyFLAMETHROWER);
			shopscreen.buychaingun.addEventListener(MouseEvent.CLICK, buyCHAINGUN);
			
			shopscreen.buypistolammo.addEventListener(MouseEvent.CLICK, buyPISTOLAMMO);
			shopscreen.buyuziammo.addEventListener(MouseEvent.CLICK, buyUZIAMMO);
			shopscreen.buyshotgunammo.addEventListener(MouseEvent.CLICK, buySHOTGUNAMMO);
			shopscreen.buyflamethrowerammo.addEventListener(MouseEvent.CLICK, buyFLAMETHROWERAMMO);
			shopscreen.buymedshot.addEventListener(MouseEvent.CLICK, buyMEDSHOT);
			shopscreen.buyspeedboost.addEventListener(MouseEvent.CLICK, buySPEEDBOOST);
			
			shopscreen.exitshop.addEventListener(MouseEvent.CLICK, closeshop);
			shopscreen.shopcash.text = ("$"+currentcash.toString());
			shopscreen.shopmessage.text = "";//shop message
			
		}
		public function closeshop(event:MouseEvent):void {
			pausescreen.gotoshop.addEventListener(MouseEvent.CLICK, showshop);
			if(pausescreen.contains(shopscreen)){
				pausescreen.removeChild(shopscreen);
			}
				//save achive data
				saveachiveData();
		}
		public var confirmpistolammo:confirmpistolammo_mc = new confirmpistolammo_mc();
		public var confirmshotgun:confirmshotgun_mc = new confirmshotgun_mc();
		public var confirmshotgunammo:confirmshotgunammo_mc = new confirmshotgunammo_mc();
		public var confirmuzi:confirmuzi_mc = new confirmuzi_mc();
		public var confirmuziammo:confirmuziammo_mc = new confirmuziammo_mc();
		public var confirmflamethrower:confirmflamethrower_mc = new confirmflamethrower_mc();
		public var confirmflamethrowerammo:confirmflamethrowerammo_mc = new confirmflamethrowerammo_mc();
		public var confirmmedkit:confirmmedkit_mc = new confirmmedkit_mc();
		public var confirmarmour:confirmarmour_mc = new confirmarmour_mc();
		public var confirmtorch:confirmtorch_mc = new confirmtorch_mc();
		public var confirmspeedboost:confirmspeedboost_mc = new confirmspeedboost_mc();
		public var confirmmedshot:confirmmedshot_mc = new confirmmedshot_mc();
		public var confirmchaingun:confirmchaingun_mc = new confirmchaingun_mc();

		//WEAPONS
		public function buyCHAINGUN(event:MouseEvent):void {
				shopscreen.addChild(confirmchaingun);
				confirmchaingun.yesuzi.addEventListener(MouseEvent.CLICK, confirmBUYCHAINGUN);
				confirmchaingun.nouzi.addEventListener(MouseEvent.CLICK, cancelBUYCHAINGUN);
		}
		public function cancelBUYCHAINGUN(event:MouseEvent):void {
			if(shopscreen.contains(confirmchaingun)){
				shopscreen.removeChild(confirmchaingun);
			}
		}
		public function confirmBUYCHAINGUN(event:MouseEvent):void {
			itemname = "ChainGun";
			if (currentrank < 5){
				shopscreen.shopmessage.text = "You Must be Rank 5 to purchase " + itemname +"!";//shop message
				if(shopscreen.contains(confirmchaingun)){
					shopscreen.removeChild(confirmchaingun);
				}
			}else{
				if (currentcash >= 5000){
				haschaingun = true;
				chaingunammo = 1500;
				currentcash -= 5000;//cost of uzi
				globalcashspent += 5000;
				updatetext();//update cash display
				shopscreen.shopmessage.text = "Bought CHAINGUN!";//shop message
				}else{
					shopscreen.shopmessage.text = "Not enough cash!";//shop message
				}
				if(shopscreen.contains(confirmchaingun)){
					shopscreen.removeChild(confirmchaingun);
				}
			}
		}
		public function buyUZI(event:MouseEvent):void {
			shopscreen.addChild(confirmuzi);
			confirmuzi.yesuzi.addEventListener(MouseEvent.CLICK, confirmBUYUZI);
			confirmuzi.nouzi.addEventListener(MouseEvent.CLICK, cancelBUYUZI);
		}
		public function cancelBUYUZI(event:MouseEvent):void {
			if(shopscreen.contains(confirmuzi)){
				shopscreen.removeChild(confirmuzi);
			}
		}
		public function confirmBUYUZI(event:MouseEvent):void {
			itemname = "UZI";
			if (currentrank < 5){
				shopscreen.shopmessage.text = "You Must be Rank 5 to purchase " + itemname +"!";//shop message
				if(shopscreen.contains(confirmuzi)){
					shopscreen.removeChild(confirmuzi);
				}
			}else{
				if (currentcash >= 1000){
				hasuzi = true;
				uziammo = 200;
				currentcash -= 1000;//cost of uzi
				globalcashspent += 1000;
				updatetext();//update cash display
				shopscreen.shopmessage.text = "Bought UZI!";//shop message
				}else{
					shopscreen.shopmessage.text = "Not enough cash!";//shop message
				}
				if(shopscreen.contains(confirmuzi)){
					shopscreen.removeChild(confirmuzi);
				}
			}
		}
		public function buySHOTGUN(event:MouseEvent):void {
			shopscreen.addChild(confirmshotgun);
			confirmshotgun.yesshotgun.addEventListener(MouseEvent.CLICK, confirmBUYSHOTGUN);
			confirmshotgun.noshotgun.addEventListener(MouseEvent.CLICK, cancelBUYSHOTGUN);
		}
		public function cancelBUYSHOTGUN(event:MouseEvent):void {
			if(shopscreen.contains(confirmshotgun)){
				shopscreen.removeChild(confirmshotgun);
			}
		}
		public function confirmBUYSHOTGUN(event:MouseEvent):void {
			itemname = "ShotGun";
			if (currentrank < 5){
				shopscreen.shopmessage.text = "You Must be Rank 5 to purchase " + itemname +"!";//shop message
				if(shopscreen.contains(confirmshotgun)){
					shopscreen.removeChild(confirmshotgun);
				}
			}else{
				if (currentcash >= 500){
				hasshotgun = true;
				shotgunammo = 200;
				currentcash -= 500;//cost of uzi
				globalcashspent += 500;
				updatetext();//update cash display
				shopscreen.shopmessage.text = "Bought Shotgun!";//shop message
				}else{
					shopscreen.shopmessage.text = "Not enough cash!";//shop message
				}
				if(shopscreen.contains(confirmshotgun)){
					shopscreen.removeChild(confirmshotgun);
				}
			}
		}
		public function buyFLAMETHROWER(event:MouseEvent):void {
			shopscreen.addChild(confirmflamethrower);
			confirmflamethrower.yesflamethrower.addEventListener(MouseEvent.CLICK, confirmBUYFLAMETHROWER);
			confirmflamethrower.noflamethrower.addEventListener(MouseEvent.CLICK, cancelBUYFLAMETHROWER);
		}
		public function cancelBUYFLAMETHROWER(event:MouseEvent):void {
			if(shopscreen.contains(confirmflamethrower)){
				shopscreen.removeChild(confirmflamethrower);
			}
		}
		public function confirmBUYFLAMETHROWER(event:MouseEvent):void {
			itemname = "Flame Thrower";
			if (currentrank < 5){
				shopscreen.shopmessage.text = "You Must be Rank 5 to purchase " + itemname +"!";//shop message
				if(shopscreen.contains(confirmflamethrower)){
					shopscreen.removeChild(confirmflamethrower);
				}
			}else{
				if (currentcash >= 2500){
				hasflamethrower = true;
				flamethrowerammo = 300;
				currentcash -= 2500;//cost of uzi
				globalcashspent += 2500;
				updatetext();//update cash display
				shopscreen.shopmessage.text = "Bought Flamethrower!";//shop message
				}else{
					shopscreen.shopmessage.text = "Not enough cash!";//shop message
				}
				if(shopscreen.contains(confirmflamethrower)){
					shopscreen.removeChild(confirmflamethrower);
				}
			}
		}
		//ARMOUR
		public function buyARMOUR(event:MouseEvent):void {
			shopscreen.addChild(confirmarmour);
			confirmarmour.yesarmour.addEventListener(MouseEvent.CLICK, confirmBUYARMOUR);
			confirmarmour.noarmour.addEventListener(MouseEvent.CLICK, cancelBUYARMOUR);
		}
		public function cancelBUYARMOUR(event:MouseEvent):void {
			if(shopscreen.contains(confirmarmour)){
				shopscreen.removeChild(confirmarmour);
			}
		}
		public function confirmBUYARMOUR(event:MouseEvent):void {
			itemname = "Armour";
			if (currentrank < 5){
				shopscreen.shopmessage.text = "You Must be Rank 5 to purchase " + itemname +"!";//shop message
			if(shopscreen.contains(confirmarmour)){
				shopscreen.removeChild(confirmarmour);
			}
			}else{
				if (currentcash >= 2000){
				hasarmour = true;
				armour += 40;
				currentcash -= 2000;//cost of armour
				globalcashspent += 2000;
				updatetext();//update cash display
				updatetext();//update armour display
				shopscreen.shopmessage.text = "Bought Armour!";//shop message
				}else{
					shopscreen.shopmessage.text = "Not enough cash!";//shop message
				}
				if(shopscreen.contains(confirmarmour)){
					shopscreen.removeChild(confirmarmour);
				}
			}
		}
		//MEDSHOT
		public function buyMEDSHOT(event:MouseEvent):void {
			shopscreen.addChild(confirmmedshot);
			confirmmedshot.yesmedshot.addEventListener(MouseEvent.CLICK, confirmBUYMEDSHOT);
			confirmmedshot.nomedshot.addEventListener(MouseEvent.CLICK, cancelBUYMEDSHOT);
		}
		public function cancelBUYMEDSHOT(event:MouseEvent):void {
			if(shopscreen.contains(confirmmedshot)){
				shopscreen.removeChild(confirmmedshot);
			}
		}
		public function confirmBUYMEDSHOT(event:MouseEvent):void {
			itemname = "MedShot";
			if (currentrank < 5){
				shopscreen.shopmessage.text = "You Must be Rank 5 to purchase " + itemname +"!";//shop message
			if(shopscreen.contains(confirmmedshot)){
				shopscreen.removeChild(confirmmedshot);
			}
			}else{
				if (currentcash >= 1500){
				hasarmour = true;
				collectMedshot();
				currentcash -= 1500;//cost of medshot
				globalcashspent += 1500;
				updatetext();//update cash display
				updatetext();//update display
				shopscreen.shopmessage.text = "Bought Medkit!";//shop message
				}else{
					shopscreen.shopmessage.text = "Not enough cash!";//shop message
				}
				if(shopscreen.contains(confirmmedshot)){
					shopscreen.removeChild(confirmmedshot);
				}
			}
		}
		//MEDKIT
		public function buyMEDKIT(event:MouseEvent):void {
			shopscreen.addChild(confirmmedkit);
			confirmmedkit.yesmedkit.addEventListener(MouseEvent.CLICK, confirmBUYMEDKIT);
			confirmmedkit.nomedkit.addEventListener(MouseEvent.CLICK, cancelBUYMEDKIT);
		}
		public function cancelBUYMEDKIT(event:MouseEvent):void {
			if(shopscreen.contains(confirmmedkit)){
				shopscreen.removeChild(confirmmedkit);
			}
		}
		public function confirmBUYMEDKIT(event:MouseEvent):void {
			itemname = "MedKit";
			if (currentrank < 5){
				shopscreen.shopmessage.text = "You Must be Rank 5 to purchase " + itemname +"!";//shop message
			if(shopscreen.contains(confirmmedkit)){
				shopscreen.removeChild(confirmmedkit);
			}
			}else{
				if (currentcash >= 2500){
				hasarmour = true;
				collectMedpack();
				currentcash -= 2500;//cost of medkit
				globalcashspent += 2500;
				updatetext();//update cash display
				updatetext();//update display
				shopscreen.shopmessage.text = "Bought Medkit!";//shop message
				}else{
					shopscreen.shopmessage.text = "Not enough cash!";//shop message
				}
				if(shopscreen.contains(confirmmedkit)){
					shopscreen.removeChild(confirmmedkit);
				}
			}
		}
		//TORCH
		public function buyTORCH(event:MouseEvent):void {
			shopscreen.addChild(confirmtorch);
			confirmtorch.yestorch.addEventListener(MouseEvent.CLICK, confirmBUYTORCH);
			confirmtorch.notorch.addEventListener(MouseEvent.CLICK, cancelBUYTORCH);
		}
		public function cancelBUYTORCH(event:MouseEvent):void {
			if(shopscreen.contains(confirmtorch)){
				shopscreen.removeChild(confirmtorch);
			}
		}
		public function confirmBUYTORCH(event:MouseEvent):void {
			itemname = "Torch";
			if (currentrank < 5){
				shopscreen.shopmessage.text = "You Must be Rank 5 to purchase " + itemname +"!";//shop message
			if(shopscreen.contains(confirmtorch)){
				shopscreen.removeChild(confirmtorch);
			}
			}else{
				if (currentcash >= 2500){
				collectTorch();
				currentcash -= 2500;//cost of torch
				globalcashspent += 2500;
				updatetext();//update cash display
				shopscreen.shopmessage.text = "Bought Torch!";//shop message
				}else{
					shopscreen.shopmessage.text = "Not enough cash!";//shop message
				}
				if(shopscreen.contains(confirmtorch)){
					shopscreen.removeChild(confirmtorch);
				}
			}
		}
		//AMMO
		public function buyPISTOLAMMO(event:MouseEvent):void {
			shopscreen.addChild(confirmpistolammo);
			confirmpistolammo.yespistolammo.addEventListener(MouseEvent.CLICK, confirmBUYPISTOLAMMO);
			confirmpistolammo.nopistolammo.addEventListener(MouseEvent.CLICK, cancelBUYPISTOLAMMO);
		}
		public function cancelBUYPISTOLAMMO(event:MouseEvent):void {
			if(shopscreen.contains(confirmpistolammo)){
				shopscreen.removeChild(confirmpistolammo);
			}
		}
		public function confirmBUYPISTOLAMMO(event:MouseEvent):void {
			itemname = "Pistol";
			if (currentrank < 5){
				shopscreen.shopmessage.text = "You Must be Rank 5 to purchase " + itemname +"!";//shop message
			if(shopscreen.contains(confirmpistolammo)){
				shopscreen.removeChild(confirmpistolammo);
			}
			}else{
				if (currentcash >= 50){
				pistolammo = 100;
				currentcash -= 50;//cost of uzi
				globalcashspent += 50;
				updatetext();//update cash display
				shopscreen.shopmessage.text = "Bought Pistol Ammo!";//shop message
				}else{
					shopscreen.shopmessage.text = "Not enough cash!";//shop message
				}
				if(shopscreen.contains(confirmpistolammo)){
					shopscreen.removeChild(confirmpistolammo);
				}
			}
		}
		public function buyUZIAMMO(event:MouseEvent):void {
			shopscreen.addChild(confirmuziammo);
			confirmuziammo.yesuziammo.addEventListener(MouseEvent.CLICK, confirmBUYUZIAMMO);
			confirmuziammo.nouziammo.addEventListener(MouseEvent.CLICK, cancelBUYUZIAMMO);
		}
		public function cancelBUYUZIAMMO(event:MouseEvent):void {
			if(shopscreen.contains(confirmuziammo)){
				shopscreen.removeChild(confirmuziammo);
			}
		}
		public function confirmBUYUZIAMMO(event:MouseEvent):void {
			itemname = "AMMO: UZI";
			if (currentrank < 5){
				shopscreen.shopmessage.text = "You Must be Rank 5 to purchase " + itemname +"!";//shop message
			if(shopscreen.contains(confirmuziammo)){
				shopscreen.removeChild(confirmuziammo);
			}
			}else{
				if (currentcash >= 500){
				uziammo = 500;
				currentcash -= 500;//cost of uzi
				globalcashspent += 500;
				updatetext();//update cash display
				shopscreen.shopmessage.text = "Bought UZI Ammo!";//shop message
				}else{
					shopscreen.shopmessage.text = "Not enough cash!";//shop message
				}
				if(shopscreen.contains(confirmuziammo)){
					shopscreen.removeChild(confirmuziammo);
				}
			}
		}public function buySHOTGUNAMMO(event:MouseEvent):void {
			shopscreen.addChild(confirmshotgunammo);
			confirmshotgunammo.yesshotgunammo.addEventListener(MouseEvent.CLICK, confirmSHOTGUNAMMO);
			confirmshotgunammo.noshotgunammo.addEventListener(MouseEvent.CLICK, cancelBUYSHOTGUNAMMO);
		}
		public function cancelBUYSHOTGUNAMMO(event:MouseEvent):void {
			if(shopscreen.contains(confirmshotgunammo)){
				shopscreen.removeChild(confirmshotgunammo);
			}
		}
		public function confirmSHOTGUNAMMO(event:MouseEvent):void {
			itemname = "AMMO: SHOTGUN";
			if (currentrank < 5){
				shopscreen.shopmessage.text = "You Must be Rank 5 to purchase " + itemname +"!";//shop message
			if(shopscreen.contains(confirmshotgunammo)){
				shopscreen.removeChild(confirmshotgunammo);
			}
			}else{
				if (currentcash >= 150){
				shotgunammo = 50;
				currentcash -= 150;//cost of shotgun ammo
				globalcashspent += 150;
				updatetext();//update cash display
				shopscreen.shopmessage.text = "Bought Shotgun Ammo!";//shop message
				}else{
					shopscreen.shopmessage.text = "Not enough cash!";//shop message
				}
				if(shopscreen.contains(confirmshotgunammo)){
					shopscreen.removeChild(confirmshotgunammo);
				}
			}
		}
		public function buyFLAMETHROWERAMMO(event:MouseEvent):void {
			shopscreen.addChild(confirmflamethrowerammo);
			confirmflamethrowerammo.yesflamethrowerammo.addEventListener(MouseEvent.CLICK, confirmBUYFLAMETHROWERAMMO);
			confirmflamethrowerammo.noflamethrowerammo.addEventListener(MouseEvent.CLICK, cancelBUYFLAMETHROWERAMMO);
		}
		public function cancelBUYFLAMETHROWERAMMO(event:MouseEvent):void {
			if(shopscreen.contains(confirmflamethrowerammo)){
				shopscreen.removeChild(confirmflamethrowerammo);
			}
		}
		public function confirmBUYFLAMETHROWERAMMO(event:MouseEvent):void {
			itemname = "AMMO: Flame Thrower";
			if (currentrank < 5){
				shopscreen.shopmessage.text = "You Must be Rank 5 to purchase " + itemname +"!";//shop message
			if(shopscreen.contains(confirmflamethrowerammo)){
				shopscreen.removeChild(confirmflamethrowerammo);
			}
			}else{
				if (currentcash >= 500){
				flamethrowerammo = 250;
				currentcash -= 500;//cost of flaethrower ammo
				globalcashspent += 500;
				updatetext();//update cash display
				shopscreen.shopmessage.text = "Bought Flamethrower Ammo!";//shop message
				}else{
					shopscreen.shopmessage.text = "Not enough cash!";//shop message
				}
				if(shopscreen.contains(confirmflamethrowerammo)){
					shopscreen.removeChild(confirmflamethrowerammo);
				}
			}
		}
		public function buySPEEDBOOST(event:MouseEvent):void {
			shopscreen.addChild(confirmspeedboost);
			confirmspeedboost.yesspeedboost.addEventListener(MouseEvent.CLICK, confirmSPEEDBOOST);
			confirmspeedboost.nospeedboost.addEventListener(MouseEvent.CLICK, cancelSPEEDBOOST);
		}
		public function cancelSPEEDBOOST(event:MouseEvent):void {
			if(shopscreen.contains(confirmspeedboost)){
				shopscreen.removeChild(confirmspeedboost);
			}
		}
		//Speed boost
		public function confirmSPEEDBOOST(event:MouseEvent):void {
			itemname = "SpeedBoost";
			if (currentrank < 5){
				shopscreen.shopmessage.text = "You Must be Rank 5 to purchase " + itemname +"!";//shop message
			if(shopscreen.contains(confirmspeedboost)){
				shopscreen.removeChild(confirmspeedboost);
			}
			}else{
				if (currentcash >= 1000){
				collectSpeedpack();// turn speed boost on
				currentcash -= 1000;//cost of speedboost
				globalcashspent += 1000;
				updatetext();//update cash display
				shopscreen.shopmessage.text = "Bought Speed Boost!";//shop message
				}else{
					shopscreen.shopmessage.text = "Not enough cash!";//shop message
				}
				if(shopscreen.contains(confirmspeedboost)){
					shopscreen.removeChild(confirmspeedboost);
				}
			}
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//						ZOMBIES
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		var zombieArray:Array = [];//holds zombies
		var deadzombieArray:Array = [];//holds all deadzombies
		//create new zombie from Zombie class and place on stage at spawn point
		var ranspawn:int;
		
		public function createBoss():void{
			 if(bossspawn == true){
					var zombieBoss:BossZombie = new BossZombie(stage, BossZombie.BossZombieX, BossZombie.BossZombieY);
					//Add event to zombie to remove them from array when removed from stage
					zombieBoss.addEventListener(Event.REMOVED_FROM_STAGE, zombieRemoved, false, 0, true);
					//add zombie to array
					zombieArray.push(zombieBoss);
					//add zombie to stage
					enemycontainer.addChild(zombieBoss);
					//increase zombie counters
					zombiecount += 1;
					totalzomibes += 1;
					Zombiesspawnedtotal += 1;
					bossspawn = false;
					if(traceoutput == true){
						trace("Boss zombie spawned!")
					}
			}
		}
		public function createZombies():void {
 			if((zombiecount > zombiespawncount)){
				stopspawn = true;
			}else if (stopspawn == false) {
				ranspawn = randomRange(0,10);
				//check how many zombies on stage
				if(ranspawn <= 9){
					var zombie:Zombie = new Zombie(stage, Zombie.ZombieX, Zombie.ZombieY);
					//Add event to zombie to remove them from array when removed from stage
					zombie.addEventListener(Event.REMOVED_FROM_STAGE, zombieRemoved, false, 0, true);
					//add zombie to array
					zombieArray.push(zombie);
					//add zombie to stage
					enemycontainer.addChild(zombie);
					//increase zombie counters
					zombiecount += 1;
					totalzomibes += 1;
					Zombiesspawnedtotal += 1;
				}else if (ranspawn == 10){
					var zombieBig:BigZombie = new BigZombie(stage, BigZombie.BigZombieX, BigZombie.BigZombieY);
					//Add event to zombie to remove them from array when removed from stage
					zombieBig.addEventListener(Event.REMOVED_FROM_STAGE, zombieRemoved, false, 0, true);
					//add zombie to array
					zombieArray.push(zombieBig);
					//add zombie to stage
					enemycontainer.addChild(zombieBig);
					//increase zombie counters
					zombiecount += 1;
					totalzomibes += 1;
					Zombiesspawnedtotal += 1;
				}
			}
		}
		
		public function playerDamaged():void{
			hasbeenhit = true;
			//TImer
			hasbeenhittimer.start();
			hasbeenhittimer.addEventListener(TimerEvent.TIMER, hasbeenhittimerTickHandler);
		}
		public var hasbeenhittimer:Timer = new Timer(100);
		public var hasbeenhittimerCount:int = 0;
		public var hasbeenhit:Boolean;
		
		public function hasbeenhittimerTickHandler(Event:TimerEvent):void
		{
			hasbeenhittimerCount += 100;
		}

		public static var currentdead:int;
		
		
		public function checkzombieHit():void{
			for (var idx:int = zombieArray.length - 1; idx >= 0; idx--){
					var zombie1:Zombie = zombieArray[idx];
					//normal push player
					if (zombie1.hitTestPoint(player.x+radius, player.y, true)){
						player.x -= 1;
						zombie1.x += 1;
						playerDamaged();
					}
					if (zombie1.hitTestPoint(player.x, player.y-radius, true)){
						player.y += 1;
						zombie1.y -= 1;
						playerDamaged();
					}
					if (zombie1.hitTestPoint(player.x-radius, player.y, true)){
						player.x += 1;
						zombie1.x -= 1;
						playerDamaged();
					}
					if (zombie1.hitTestPoint(player.x, player.y+radius, true)){
						player.y -= 1;
						zombie1.y += 1;
						playerDamaged();
					}
					
					if ((infintehealth == false)&&(hasbeenhit == true)){
						if(hasbeenhittimerCount >=100){
							checkhealth();
							checkarmour();
							hasbeenhittimerCount = 0;
							hasbeenhittimer.stop();
							hasbeenhittimer.removeEventListener(TimerEvent.TIMER, hasbeenhittimerTickHandler);
							if (hasarmour == false){
								health -= zombie1.zombiedamage;
							}else if (hasarmour == true){
								armour -= zombie1.zombiedamage;
							}
							if(traceoutput == true){
								trace("player hit");
							}
						}else{
							hasbeenhit = false;
						}
					}

					//flamerthrower
					if(flamethrowerflames.hitTestPoint(zombie1.x,zombie1.y, true)){
						if (this.contains(zombie1)){
							zombie1.zombiehitpoints -= 1;// damage per second (roughly)
						}
					}
					//bullets
					for (var bidx:int = bulletList.length - 1; bidx >= 0; bidx--){
						var bullet1:Bullet = bulletList[bidx];
						//check if bullet hits zombie
						
						if (bullet1.hitTestObject(zombie1)){
							if (enemycontainer.contains(zombie1)){
								//remove zombie and bullet
								if(isusingshotgun == true){
									zombie1.zombiehitpoints -= 10;// damage per pellet
									enemycontainer.removeChild(bullet1);
								} else {
									zombie1.zombiehitpoints -= 5;//damage per bullet
									enemycontainer.removeChild(bullet1);
								}
								
							}
						}
						
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
			//total zombies
			totalzombieskilled += 1;
			//globalzombiekills
			globalzombiekills +=1;
			//Process XP
			ProcessXP();
			//check next level requirments
			finishlevel();
				//save achive
				saveachiveData();
				if(traceoutput == true){
					trace ("Zombie Removed");
				}
		}
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//						LEVELS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function finishlevel():void{
			if ((level == 1)&&(zombieskilled >= 10)){
				zombiespawncount = 19; // how many zombies to spawn for level 2 (if you want 10 set it to 9!)
				level += 1;
				stopspawn = false;
				if(traceoutput == true){
					trace ("Level:" + level);
				}
			}
			else if ((level == 2)&&(zombieskilled >= 30)){
				zombiespawncount = 19;
				level += 1;
				stopspawn = false;
				if(traceoutput == true){
					trace ("Level:" + level);
				}
			}
			else if ((level == 3)&&(zombieskilled >= 50)){
				zombiespawncount = 19;
				level += 1;
				stopspawn = false;
				if(traceoutput == true){
					trace ("Level:" + level);
				}
			}
			else if ((level == 4)&&(zombieskilled >= 70)){
				zombiespawncount = 19;
				level += 1;
				stopspawn = false;
				if(traceoutput == true){
				trace ("Level:" + level);
				}
			}
			else if ((level == 5)&&(zombieskilled >= 90)){
				zombiespawncount = 19;
				level += 1;
				stopspawn = false;
				if(traceoutput == true){
				trace ("Level:" + level);
				}
			}
			else if ((level == 6)&&(zombieskilled >= 110)){
				zombiespawncount = 19;
				level += 1;
				stopspawn = false;
				if(traceoutput == true){
				trace ("Level:" + level);
				}
			}
			else if ((level == 7)&&(zombieskilled >= 130)){
				zombiespawncount = 19;
				level += 1;
				stopspawn = false;
				if(traceoutput == true){
				trace ("Level:" + level);
				}
			}
			else if ((level == 8)&&(zombieskilled >= 150)){
				zombiespawncount = 19;
				level += 1;
				stopspawn = false;
				if(traceoutput == true){
				trace ("Level:" + level);
				}
			}
			else if ((level == 9)&&(zombieskilled >= 170)){
				zombiespawncount = 19;
				//level += 1;
				stopspawn = false;
				currentstage += 1;
				//move to  next stage
				nextstage();
			}
		}
		public function nextstage():void{
			if (currentstage == 1){
				if(traceoutput == true){
				trace ("Stage 1");
				}
				environment.gotoAndStop(1);
				ground.gotoAndStop(1);
			}
			if (currentstage == 2){
				level = 1;
				zombieskilled = 0;
				if(traceoutput == true){
				trace ("Stage 2");
				}
				environment.gotoAndStop(2);
				ground.gotoAndStop(2);
			}
			if (currentstage == 3){
				level = 1;
				zombieskilled = 0;
				endfog();//stop fog
				if(traceoutput == true){
				trace ("Stage 3");
				}
				environment.gotoAndStop(3);
				ground.gotoAndStop(3);
			}
			if (currentstage == 4){
				level = 1;
				zombieskilled = 0;
				if(traceoutput == true){
				trace ("Stage 4");
				}
				environment.gotoAndStop(4);
				ground.gotoAndStop(4);
			}
			//BOSS STAGE 1
			if (currentstage == 5){
				level = 1;
				zombieskilled = 0;
				if(traceoutput == true){
				trace ("Stage 5");
				}
				processfog();
				environment.gotoAndStop(5);
				ground.gotoAndStop(5);
				bossspawn = true;
				createBoss(); // create boss
			}
		}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//						WEAPONS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//create a array to hold all bullets fired
		public var bulletList:Array = [];
		public function shootBullet():void {
			//create new bullet based on players X/Y and Rotation
			var bullet:Bullet = new Bullet(stage, player.x, player.y, player.rotation);
			//Add event to bullets to remove them from array when removed from stage
			bullet.addEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved, false, 0, true);
			//add bullet to array
			bulletList.push(bullet);
			//add bullet to stage
			enemycontainer.addChild(bullet);
			//reduce ammo by 1
		}
		var chaingunRandom:int;
		
		public function shootChaingunBullet():void {
			chaingunRandom = randomRange(0,25);
			//create new bullet based on players X/Y and Rotation
			var bullet:Bullet = new Bullet(stage, player.x, player.y, player.rotation - chaingunRandom);
			//Add event to bullets to remove them from array when removed from stage
			bullet.addEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved, false, 0, true);
			//add bullet to array
			bulletList.push(bullet);
			//add bullet to stage
			enemycontainer.addChild(bullet);
			
			var bullet1:Bullet = new Bullet(stage, player.x, player.y, player.rotation + chaingunRandom);
			//Add event to bullets to remove them from array when removed from stage
			bullet1.addEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved, false, 0, true);
			//add bullet to array
			bulletList.push(bullet1);
			//add bullet to stage
			enemycontainer.addChild(bullet1);
			//reduce ammo by 1
		}
		public function shootShotgun():void {
			//create new bullet based on players X/Y and Rotation
			var bullet:Bullet = new Bullet(stage, player.x, player.y, player.rotation - 10);
			var bullet1:Bullet = new Bullet(stage, player.x, player.y, player.rotation + 10);
			var bullet2:Bullet = new Bullet(stage, player.x, player.y, player.rotation);
			var bullet3:Bullet = new Bullet(stage, player.x, player.y, player.rotation + 20);
			var bullet4:Bullet = new Bullet(stage, player.x, player.y, player.rotation - 20);
			//Add event to bullets to remove them from array when removed from stage
			bullet.addEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved, false, 0, true);
			bullet1.addEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved, false, 0, true);
			bullet2.addEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved, false, 0, true);
			bullet3.addEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved, false, 0, true);
			bullet4.addEventListener(Event.REMOVED_FROM_STAGE, bulletRemoved, false, 0, true);
			//add bullet to array
			bulletList.push(bullet);
			bulletList.push(bullet1);
			bulletList.push(bullet2);
			bulletList.push(bullet3);
			bulletList.push(bullet4);
			//add bullet to stage
			enemycontainer.addChild(bullet);
			enemycontainer.addChild(bullet1);
			enemycontainer.addChild(bullet2);
			enemycontainer.addChild(bullet3);
			enemycontainer.addChild(bullet4);
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
					enemycontainer.removeChild(bullet1);
				}
				//SHOOT THRU WALLS CHEAT
				if (shootthruwalls == false){
				//check if bullet hits wall and remove
					if (environment.hitTestPoint(bullet1.x,bullet1.y, true)){
						if (enemycontainer.contains(bullet1)){
							enemycontainer.removeChild(bullet1);
						}
					}
					//check if bullet hits door
					if ((door.hitTestPoint(bullet1.x,bullet1.y, true))||(door.hitTestPoint(bullet1.x,bullet1.y, true))){
						if (enemycontainer.contains(bullet1)){
							enemycontainer.removeChild(bullet1);
						}
					}
				}
			}
		}
		public function shootFlames():void{
			if (mousePressed == true){
						flamethrowerflames.rotation=player.rotation;
						enemycontainer.addChild(flamethrowerflames);
						flamethrowerflames.x = player.x;
						flamethrowerflames.y = player.y;
			}
		}

		public function removeFlames():void{
			if(mousePressed == false){
				if(enemycontainer.contains(flamethrowerflames)){
					enemycontainer.removeChild(flamethrowerflames);
				}
				
			}
		}
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							ITEMS 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//torch
		public function collectTorch():void {
				playerhastorch = true;
				//update lighting
				//update lighting
				if(maxlight == false){
					lighting();
				}
		}
		//AMMO
		public function collectAmmo():void {
				//add ammo to current ammo count
				pistolammo += 100;
				uziammo += 100;
				shotgunammo += 10;
				flamethrowerammo += 150;
				//reset ammo
				ammoempty = false;
				if(traceoutput == true){
					trace ("Collected Ammo Pack");
				}

		}
		//MEDSHOT
		public function collectMedshot():void {
			//check if item exists
			//Check if health is less than 90
			if (health <= 80){
				//add 10 health to current health count
				health += 20;
			}
			//check if health is greater than 90
			else if(health > 80){
				//set current health to 100
				health = 100;
			}
			if(traceoutput == true){
				trace ("Collected Medshot");
			}
		}
		//MEDPACK
		public function collectMedpack():void {
			//Check if health is less than 90
			if (health <= 50){
				//add 10 health to current health count
				health += 50;
			}
			//check if health is greater than 90
			else if(health > 50){
				//set current health to 100
				health = 100;
			}
			if(traceoutput == true){
				trace ("Collected Medpack");
			}
		}
		
		//SPEEDPACK
		public function collectSpeedpack():void {
				//adds timer listener event when speed pack is collected
				addEventListener(TimerEvent.TIMER, checkSpeedPackTimer);
				//check if item exists
				//remove item from stage
				
				//set player speed to 4
				player_speed = 4;
				//start timer
				Timer10.start();
				//set collected speed pack to true
				collectedSpeedPack = true;
				if(traceoutput == true){
					trace ("Collected Speedpack");
				}

		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							ITEM TIMERS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							LEVEL ITEMS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
				if(traceoutput == true){
					trace ("Door Opening");
				}
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
				if(traceoutput == true){
					trace ("Door Opening");
				}
			}else{
				door2opening = false;
			}
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							GUI/TEXT
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
			if (isusingchaingun == true){
				ui.ammotext.text = chaingunammo.toString();
			}
			ui.uipausegame.addEventListener(MouseEvent.CLICK, openpausescreen);
			ui.healthbar.width = health;
			ui.armourbar.width = armour;
			if (armour <= 0){
				ui.armourbar.width = 0;
			}
			ui.stagetext.text = currentstage.toString();
			ui.zombieskilledtext.text = totalzombieskilled.toString();
			ui.cashtext.text = ("$"+currentcash.toString());
			ui.leveltext.text = level.toString();
			//weapon icon in gui
			//pistol
			if (isusingpistol == true){
				ui.icon_pistol.visible = true;
				ui.icon_uzi.visible = false;
				ui.icon_shotgun.visible = false;
				ui.icon_flamethrower.visible = false;
				ui.icon_chaingun.visible = false;
			}
			//uzi
			if (isusinguzi == true){
				ui.icon_pistol.visible = false;
				ui.icon_uzi.visible = true;
				ui.icon_shotgun.visible = false;
				ui.icon_flamethrower.visible = false;
				ui.icon_chaingun.visible = false;
			}
			//shotgun
			if (isusingshotgun == true){
				ui.icon_pistol.visible = false;
				ui.icon_uzi.visible = false;
				ui.icon_shotgun.visible = true;
				ui.icon_flamethrower.visible = false;
				ui.icon_chaingun.visible = false;
			}
			//flamethrower
			if (isusingflamethrower == true){
				ui.icon_pistol.visible = false;
				ui.icon_uzi.visible = false;
				ui.icon_shotgun.visible = false;
				ui.icon_flamethrower.visible = true;
				ui.icon_chaingun.visible = false;
			}
			//chaingun
			if (isusingchaingun == true){
				ui.icon_pistol.visible = false;
				ui.icon_uzi.visible = false;
				ui.icon_shotgun.visible = false;
				ui.icon_flamethrower.visible = false;
				ui.icon_chaingun.visible = true;
			}
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							GAMEOVER
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
	public function gameover():void{
					ispaused = true;
					stage.removeEventListener(Event.ENTER_FRAME,mainloop);
					stage.removeEventListener(Event.ENTER_FRAME,processScripts);
					if(traceoutput == true){
						trace("GAME OVER");
					}
					stage.addChild(gameoverscreen);
					deaths += 1;
					gameoverdeath = true;
					gameoverscreen.restartgame.addEventListener(MouseEvent.CLICK, restartGame);
		
	}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							RANK SYSTEM
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

		public function showrankscreen(event:MouseEvent):void {
			pausescreen.gotorankscreen.removeEventListener(MouseEvent.CLICK, showrankscreen);
			pausescreen.addChild(rankscreen);
			rankscreen.currentrankimage.gotoAndStop(currentrank);
			rankscreen.exitrankscreen.addEventListener(MouseEvent.CLICK, closerankscreen);
		}
		public function closerankscreen(event:MouseEvent):void {
			pausescreen.gotorankscreen.addEventListener(MouseEvent.CLICK, showrankscreen);
			pausescreen.removeChild(rankscreen);
		}
		
		
		//Rank up timer checker
		public function checkRankUpTimer():void{
			if(traceoutput == true){
				trace ("timerstarted");
			}
			//check if player has speedpack
			if (Rankedup == true){
				//increase timer
				SecondsElapsedRANK++;
				//check if timer has "ticked" 2 times (2seconds)
				if (SecondsElapsedRANK >= 2){
					// tell function text has already been shown
					rankupshown = true;
					//stop timer
					Timer10.stop();
					//reset timer
					SecondsElapsedRANK = 0;
					//remove timer listen event
					removeEventListener(TimerEvent.TIMER, checkRankUpTimer);
					//set collected speedpack back to false
					Rankedup = false;
					removeChild(rankup);
				}
			}
		}
		public function ShowRankUp():void{
			if(rankupshown == false){
				addChild(rankup);
				rankup.x = 400;
				rankup.y = 200;
				setChildIndex(rankup,6);
				//Rank up pop up
				addEventListener(TimerEvent.TIMER, checkRankUpTimer);
				Rankedup = true;
				Timer10.start();
checkRankUpTimer();
			}
		}
		public function ProcessXP():void{
			
			if (experience == 1){
				currentrank = 0;
				addChild(rank0);
				rank0.x = 66;
				rank0.y = 387;
			}
			if (experience >= 500){
				currentrank = 1;
				addChild(rank1);
				rank1.x = 66;
				rank1.y = 387;
				if (this.contains(rank0)){
					removeChild(rank0);
				}
ShowRankUp();
			}
			if (experience >= 2500){
				currentrank = 2;
				addChild(rank2);
				rank2.x = 66;
				rank2.y = 387;
				if (this.contains(rank1)){
				removeChild(rank1);
				}
ShowRankUp();
			}
			if (experience >= 5000){
				currentrank = 3;
				addChild(rank3);
				rank3.x = 66;
				rank3.y = 387;
				if (this.contains(rank2)){
				removeChild(rank2);
				}
ShowRankUp();
			}
			if (experience >= 10000){
				currentrank = 4;
				addChild(rank4);
				rank4.x = 66;
				rank4.y = 387;
				if (this.contains(rank3)){
				removeChild(rank3);
				}
ShowRankUp();
			}
			if (experience >= 20000){
				currentrank = 5;
				addChild(rank5);
				rank5.x = 66;
				rank5.y = 387;
				if (this.contains(rank4)){
				removeChild(rank4);
				}
ShowRankUp();
			}
			if (experience >= 40000){
				currentrank = 6;
				addChild(rank6);
				rank6.x = 66;
				rank6.y = 387;
				if (this.contains(rank5)){
				removeChild(rank5);
				}
ShowRankUp();
			}
			if (experience >= 80000){
				currentrank = 7;
				addChild(rank7);
				rank7.x = 66;
				rank7.y = 387;
				if (this.contains(rank6)){
				removeChild(rank6);
				}
ShowRankUp();
			}
			if (experience >= 160000){
				currentrank = 8;
				addChild(rank8);
				rank8.x = 66;
				rank8.y = 387;
				if (this.contains(rank7)){
				removeChild(rank7);
				}
ShowRankUp();
			}
			if (experience >= 320000){
				currentrank = 9;
				addChild(rank9);
				rank9.x = 66;
				rank9.y = 387;
				if (this.contains(rank8)){
				removeChild(rank8);
				}
ShowRankUp();
			}
			if (experience >= 640000){
				currentrank = 10;
				addChild(rank10);
				rank10.x = 66;
				rank10.y = 387;
				if (this.contains(rank9)){
				removeChild(rank9);
				}
ShowRankUp();
			}
			if (experience >= 1200000){
				currentrank = 11;
				addChild(rank11);
				rank11.x = 66;
				rank11.y = 387;
				if (this.contains(rank10)){
				removeChild(rank10);
				}
ShowRankUp();
			}
			if (experience >= 2400000){
				currentrank = 12;
				addChild(rank12);
				rank12.x = 66;
				rank12.y = 387;
				if (this.contains(rank11)){
				removeChild(rank11);
				}
ShowRankUp();
			}
			if (experience >= 4800000){
				currentrank = 13;
				addChild(rank13);
				rank13.x = 66;
				rank13.y = 387;
				if (this.contains(rank12)){
				removeChild(rank12);
				}
ShowRankUp();
			}
			if (experience >= 9600000){
				currentrank = 14;
				addChild(rank14);
				rank14.x = 66;
				rank14.y = 387;
				if (this.contains(rank13)){
				removeChild(rank13);
				}
ShowRankUp();
			}
			if (experience >= 19200000){
				currentrank = 15;
				addChild(rank0);
				rank15.x = 66;
				rank15.y = 387;
				if (this.contains(rank14)){
				removeChild(rank14);
				}
ShowRankUp();
			}
			if (experience >= 38400000){
				currentrank = 16;
				addChild(rank0);
				rank16.x = 66;
				rank16.y = 387;
				if (this.contains(rank15)){
				removeChild(rank15);
				}
ShowRankUp();
			}
			if (experience >= 76800000){
				currentrank = 17;
				addChild(rank17);
				rank17.x = 66;
				rank17.y = 387;
				if (this.contains(rank16)){
				removeChild(rank16);
				}
ShowRankUp();
			}
			if (experience >= 153600000){
				currentrank = 18;
				addChild(rank18);
				rank18.x = 66;
				rank18.y = 387;
				if (this.contains(rank17)){
				removeChild(rank17);
				}
ShowRankUp();
			}
			if (experience >= 307200000){
				currentrank = 19;
				addChild(rank19);
				rank19.x = 66;
				rank19.y = 387;
				if (this.contains(rank18)){
				removeChild(rank18);
				}
ShowRankUp();
			}
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							EFFECTS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////		
	public function lighting():void{		
		if (playerhastorch == true){
			light.gotoAndStop(1);
		}
		if (playerhastorch == false){
			light.gotoAndStop(2);
		}
		light.x = player.x;
		light.y = player.y;
	}
	public function startfog():void{
		if(nofogcheat == false){	
	//start fog
			ground.addChild(s1); 
			s1.alpha = 0.5;
		}
	}
	public function endfog():void{		
	//start fog
			ground.removeChild(s1); 
	}
	public function processfog():void{		
			if (currentstage == 1) {
				startfog();
			}
			if (currentstage == 2) {
				endfog();
			}
	}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//					RESTART GAME
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
		public function restartGame(event:MouseEvent):void {
   		 		stage.addChild(confirmrestartgame);
				if(gameoverdeath == true){
					var url:String = stage.loaderInfo.url;
  	 	 			var request:URLRequest = new URLRequest(url);
   		 			navigateToURL(request,"_level0");
					if(traceoutput == true){
		 				trace ("Game Restarted");
					}
				} else {
					confirmrestartgame.yesrestartgame.addEventListener(MouseEvent.CLICK, confirmRESTART);
					confirmrestartgame.norestartgame.addEventListener(MouseEvent.CLICK, cancelRESTART);
				}
		}
		private function cancelRESTART(event:MouseEvent):void {
			if(stage.contains(confirmrestartgame)){
   		 		stage.removeChild(confirmrestartgame);
			}
		}
		private function confirmRESTART(event:MouseEvent):void {
   		 var url:String = stage.loaderInfo.url;
  	 	 var request:URLRequest = new URLRequest(url);
   		 navigateToURL(request,"_level0");
		 if(traceoutput == true){
			 trace ("Game Restarted");
		 }
		}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							SAVE AND LOAD
//////////////////////////////////////////////////////////////////////////////////////////////////////////////		
	public var saveDataObject:SharedObject;
	public function savegamestate(e:MouseEvent):void{
		stage.addChild(confirmsavescreen);
		confirmsavescreen.confirmsaveyes.addEventListener(MouseEvent.CLICK, saveData);
		confirmsavescreen.confirmsaveno.addEventListener(MouseEvent.CLICK, cancelSave);
	}
	public function cancelSave(e:MouseEvent):void{
			if(stage.contains(confirmsavescreen)){
   		 		stage.removeChild(confirmsavescreen);
			}		
	}

	public function saveData(){
			saveDataObject = SharedObject.getLocal("test"); 
			saveDataObject.data.savedisusingpistol = isusingpistol;
			saveDataObject.data.savedisusinguzi = isusinguzi;
			saveDataObject.data.savedisusingshotgun = isusingshotgun;
			saveDataObject.data.savedisusingflamethrower = isusingflamethrower;
			saveDataObject.data.savedammoempty = ammoempty;
			saveDataObject.data.savedexperience = experience;
			saveDataObject.data.savedcurrentcash = currentcash;
			saveDataObject.data.savedhaspistol = haspistol;
			saveDataObject.data.savedhasuzi = hasuzi;
			saveDataObject.data.savedhasshotgun = hasshotgun;
			saveDataObject.data.savedhasflamethrower = hasflamethrower;
			saveDataObject.data.savedcurrentstage = currentstage;
			saveDataObject.data.savedshootthruwalls = shootthruwalls;
			saveDataObject.data.savedwalkthruwalls = walkthruwalls;
			saveDataObject.data.savedinfinteammo = infinteammo;
			saveDataObject.data.savedinfintehealth = infintehealth;
			saveDataObject.data.savedplayer_speed = player_speed;
			saveDataObject.data.savedplayerhastorch = playerhastorch;
			saveDataObject.data.savedispaused = ispaused;
			saveDataObject.data.savedhasarmour = hasarmour;
			saveDataObject.data.savedarmour = armour;
			saveDataObject.data.savedhealth = health;
			saveDataObject.data.savedzombieskilled = zombieskilled;
			saveDataObject.data.savedtotalzombieskilled = totalzombieskilled;
			saveDataObject.data.savedtotalzomibes = totalzomibes;
			saveDataObject.data.savedzomibeskilled = zomibeskilled;
			saveDataObject.data.savedSecondsElapsed = SecondsElapsed;
			saveDataObject.data.savedSecondsElapsed = SecondsElapsedRANK;
			saveDataObject.data.savedUiSecondsElapsed = UiSecondsElapsed;
			saveDataObject.data.savedcollectedSpeedPack = collectedSpeedPack;
			saveDataObject.data.savedlevel = level;
			saveDataObject.data.savedplayerX = player.x;
			saveDataObject.data.savedplayerY = player.y;
			//ammo
			saveDataObject.data.savedpistolammo = pistolammo;
			saveDataObject.data.saveduziammo = uziammo;
			saveDataObject.data.savedshotgunammo = shotgunammo;
			saveDataObject.data.savedflamethrowerammo = flamethrowerammo;			
			saveDataObject.flush(); // immediately save to the local drive
			// TODO - add confirmation of save popup 
			//close confirm save screen
			if(stage.contains(confirmsavescreen)){
   		 		stage.removeChild(confirmsavescreen);
			}	
			saveDataObject.data.savedhascheated = hascheated;
			if(traceoutput == true){
			trace("Game Saved!");//replace with conformation screen later
			trace(((saveDataObject.size) / 1000) + "KB"); // this will show the size of the save file, in KiloBytes
			}
	}
 
	public function loadData():void{
		saveDataObject = SharedObject.getLocal("test"); 
			isusingpistol = saveDataObject.data.savedisusingpistol;
			isusinguzi = saveDataObject.data.savedisusinguzi;
			isusingshotgun = saveDataObject.data.savedisusingshotgun;
			isusingflamethrower = saveDataObject.data.savedisusingflamethrower;
			ammoempty = saveDataObject.data.savedammoempty;
			experience = saveDataObject.data.savedexperience;
			currentcash = saveDataObject.data.savedcurrentcash;
			haspistol = saveDataObject.data.savedhaspistol;
			hasuzi = saveDataObject.data.savedhasuzi;
			hasshotgun = saveDataObject.data.savedhasshotgun;
			hasflamethrower = saveDataObject.data.savedhasflamethrower;
			currentstage = saveDataObject.data.savedcurrentstage;
			shootthruwalls = saveDataObject.data.savedshootthruwalls;
			walkthruwalls = saveDataObject.data.savedwalkthruwalls;
			infinteammo = saveDataObject.data.savedinfinteammo;
			infintehealth = saveDataObject.data.savedinfintehealth;
			player_speed = saveDataObject.data.savedplayer_speed;
			playerhastorch = saveDataObject.data.savedplayerhastorch;
			ispaused = saveDataObject.data.savedispaused;
			hasarmour = saveDataObject.data.savedhasarmour;
			armour = saveDataObject.data.savedarmour;
			health = saveDataObject.data.savedhealth;
			zombieskilled = saveDataObject.data.savedzombieskilled;
			totalzombieskilled = saveDataObject.data.savedtotalzombieskilled;
			totalzomibes = saveDataObject.data.savedtotalzomibes;
			zomibeskilled = saveDataObject.data.savedzomibeskilled;
			SecondsElapsed = saveDataObject.data.savedSecondsElapsed;
			SecondsElapsedRANK = saveDataObject.data.savedSecondsElapsedRANK;
			UiSecondsElapsed = saveDataObject.data.savedUiSecondsElapsed;
			collectedSpeedPack = saveDataObject.data.savedcollectedSpeedPack;
			level = saveDataObject.data.savedlevel;
			player.x = saveDataObject.data.savedplayerX;
			player.y = saveDataObject.data.savedplayerY;
			//ammo
			pistolammo = saveDataObject.data.savedpistolammo;
			uziammo = saveDataObject.data.saveduziammo;
			shotgunammo = saveDataObject.data.savedshotgunammo;
			flamethrowerammo = saveDataObject.data.savedflamethrowerammo;
			hascheated = saveDataObject.data.savedhascheated; 
			
			//DONT LOAD ACHIVEMENT DATA HERE IT WILL OVERWRITE ANY NEW DATA IN CURRENT SESSION!!
			//LOAD ACHIVEMENT DATA WHEN GAME FIRST STARTS
			if(traceoutput == true){
			trace("Game Loaded!");
			}
		}
		
		public function loadgame(event:MouseEvent):void{
			loadData();
			//add confirm load here
			closepausescreen(null);
		}
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//							MISC
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
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