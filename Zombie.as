package  {
	import flash.display.Stage;
    import flash.display.MovieClip;
    import flash.events.Event;
	
	public class Zombie extends MovieClip {
		
		public var stageRef:Stage;
		public var zombieRandom:int;
		public static var ZombieX:int;
		public static var ZombieY:int;
		public var radius:int;
		public var zombieSpeed:Number;
		public var bigzombiechance:Number;
		public var zombieType:Number;
		public var agrorange:int;
		public var inrangeX,inrangeY:Boolean;
		public var isbigzombie:Boolean;
		public var zombiehitpoints:int;
		public var zombiedamage:int;
		public var attackRandom:int;
		public var isAttacking:Boolean = false;
			
        public function Zombie(stageRef:Stage, ZombieX:int, ZombieY:int):void {
			zombieRandom = randomRange(0,9);
			//set zombies X and Y to random spawn points
			if (zombieRandom == 0){
				ZombieX=35;
				ZombieY=365;
			}
			else if (zombieRandom == 1){
				ZombieX=285;
				ZombieY=365;
			}
			else if (zombieRandom == 2){
				ZombieX=535;
				ZombieY=365;
			}
			else if (zombieRandom == 3){
				ZombieX=760
				ZombieY=365;
			}
			else if (zombieRandom == 4){
				ZombieX=35;
				ZombieY=40;
			}
			else if (zombieRandom == 5){
				ZombieX=285;
				ZombieY=40;
			}
			else if (zombieRandom == 6){
				ZombieX=535;
				ZombieY=40;
			}
			else if (zombieRandom == 7){
				ZombieX=760;
				ZombieY=40;
			}
			else if (zombieRandom == 8){
				ZombieX=760;
				ZombieY=200;
			}
			else if (zombieRandom == 9){
				ZombieX=35;
				ZombieY=200;
			}
			else{
				ZombieX=700;
				ZombieY=300;
			}
            this.stageRef = stageRef;
            this.x = ZombieX;
            this.y = ZombieY;
				
				zombieType = randomRange(0,1);//how many types of zombies
				bigzombiechance = randomRange(0,8);
				
				if(zombieType == 0){
					radius = 19;
					this.gotoAndStop(1)
					zombieSpeed = 0.5;
					isbigzombie = false;
					zombiehitpoints = 10;
					zombiedamage = 1;
					agrorange = 350;//how far zombie can see
				}else if((zombieType == 1) && (bigzombiechance == 1)){
					radius = 9;//how big is the zombie in pixels (sphere)
					this.gotoAndStop(2)
					zombieSpeed = 0.2;
					isbigzombie = true;
					zombiedamage = 5;
					zombiehitpoints = 20;
					agrorange = 200;
				}else{
					zombieType = 0;
					radius = 19;
					this.gotoAndStop(1)
					zombieSpeed = 0.5;
					isbigzombie = false;
					zombiehitpoints = 10;
					agrorange = 350;//how far zombie can see
					zombiedamage = 1;
				}

				addEventListener(Event.ENTER_FRAME,zombieloop);
        }
///////////////////////////////////////////////////////
//							Main Loop
///////////////////////////////////////////////////////
		public function zombieloop(e:Event):void {
			if (survival.ispaused == false){
				var Zdist_x:Number=this.x-survival.player.x;
				var Zdist_y:Number=this.y-survival.player.y;
				var Zangle:Number=- Math.atan2(Zdist_x,Zdist_y);
				var distance:Number = Math.sqrt((Zdist_x)*(Zdist_x) + (Zdist_y)*(Zdist_y));
				//stop zombies going thru walls
				while (survival.environment.hitTestPoint(this.x, this.y+radius, true)) {
					this.y--;
				}
				while (survival.environment.hitTestPoint(this.x, this.y-radius, true)) {
					this.y++;
				}
				while (survival.environment.hitTestPoint(this.x-radius, this.y, true)) {
					this.x++;
				}
				while (survival.environment.hitTestPoint(this.x+radius, this.y, true)) {
					this.x--;
				}
				//stop zombies going thru door
				while (survival.door.hitTestPoint(this.x, this.y+radius, true)) {
					this.y--;
				}
				while (survival.door.hitTestPoint(this.x, this.y-radius, true)) {
					this.y++;
				}
				while (survival.door.hitTestPoint(this.x-radius, this.y, true)) {
					this.x++;
				}
				while (survival.door.hitTestPoint(this.x+radius, this.y, true)) {
					this.x--;
				}
				//move zombie towards player
				if ((distance <= agrorange)&&(isAttacking == false)){
					//rotate zombie to face player
					this.rotation=to_degrees(Zangle);
					//move zombie towards player
					if(this.y > survival.player.y){
						this.y -= zombieSpeed; //Y UP
					}
					if(this.y < survival.player.y){
						this.y += zombieSpeed;//Y DOWN
					}
					if(this.x > survival.player.x){
						this.x -= zombieSpeed;//X LEFT
					}
					if(this.x < survival.player.x){
						this.x += zombieSpeed;//X RIGHT
					}
				}
			}
		}
///////////////////////////////////////////////////////
//							MISC
///////////////////////////////////////////////////////
		public function to_radians(n:Number):Number {
				return (n*0.0174532925);
			}
		public function to_degrees(n:Number):Number {
				return (n*57.2957795);
			}
		public function randomRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
	}//end class
}//end package
	
