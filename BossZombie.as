package  {
    import flash.display.*;
    import flash.events.*;
	import flash.utils.*;
	
	public class BossZombie extends MovieClip {
		
		private var stageRef:Stage;

		public static var bossZombieX:int;
		public static var bossZombieY:int;
		public var attackRandom:int;
		public var radius:int;
		public var zombieSpeed:Number;
		public var bigzombiechance:Number;
		public var zombieType:Number;
		public var agrorange:int;
		public var inrangeX,inrangeY:Boolean;
		public var isbigzombie:Boolean;
		public var isAttacking:Boolean = false;
		public var bosszombiehitpoints:int;
		public var zombiedamage:int;
		public var bossTimer:Timer = new Timer(1000, 10);
		public var bosschargeTimer:Timer = new Timer(1000, 10);
		public var SecondsElapsed:Number = 1;
		public var chargeSecondsElapsed:Number = 1;
		
		public function attackheck():void{
			SecondsElapsed++;
				//check if timer has "ticked" 500 times
				if (SecondsElapsed >= 10){
					//stop timer
					bossTimer.stop();
					//reset timer
					SecondsElapsed = 0;
					//reset damage
					zombiedamage = 5;
					//remove timer listen event
					removeEventListener(TimerEvent.TIMER, attackheck);
					isAttacking = false;
				}
		}
		public function chargeattackheck():void{
			chargeSecondsElapsed++;
				//check if timer has "ticked" 500 times
				if (chargeSecondsElapsed >= 120){
					//stop timer
					bosschargeTimer.stop();
					//reset timer
					chargeSecondsElapsed = 0;
					//reset agro
					agrorange = 400;
					//reset damage
					zombiedamage = 5;
					//remove timer listen event
					removeEventListener(TimerEvent.TIMER, chargeattackheck);
					isAttacking = false;
				}
		}
			
        public function BossZombie(stageRef:Stage, bossZombieX:int, bossZombieY:int):void {
				bossZombieX=400;
				bossZombieY=100;
				this.stageRef = stageRef;
				this.x = bossZombieX;
				this.y = bossZombieY;
				radius = 35;
				zombieSpeed = 0.7;
				isbigzombie = false;
				bosszombiehitpoints = 5000;
				zombiedamage = 5;
				agrorange = 400;//how far zombie can see
				addEventListener(Event.ENTER_FRAME,bosszombieloop);
        }
///////////////////////////////////////////////////////
//							Main Loop
///////////////////////////////////////////////////////
		public function bosszombieloop(e:Event):void {
			if (survival.ispaused == false){
				var Zdist_x:Number=this.x-survival.player.x;
				var Zdist_y:Number=this.y-survival.player.y;
				var Zangle:Number=- Math.atan2(Zdist_x,Zdist_y);
				var distance:Number = Math.sqrt((Zdist_x)*(Zdist_x) + (Zdist_y)*(Zdist_y));

				//stop zombies going thru walls
				while (survival.environment.hitTestPoint(this.x, this.y+radius, true)) {
					this.y--;
					this.gotoAndStop(2);//walking
				}
				while (survival.environment.hitTestPoint(this.x, this.y-radius, true)) {
					this.y++;
					this.gotoAndStop(2);//walking
				}
				while (survival.environment.hitTestPoint(this.x-radius, this.y, true)) {
					this.x++;
					this.gotoAndStop(2);//walking
				}
				while (survival.environment.hitTestPoint(this.x+radius, this.y, true)) {
					this.x--;
					this.gotoAndStop(2);//walking
				}
				/*
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
				*/
				//move zombie towards player
				if (distance < agrorange){
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
				}else if (isAttacking == true){
					trace("boss attacking");
					this.rotation=to_degrees(Zangle);
					
					this.gotoAndStop(1);//idle
				}
				

				//if ((attackRandom == 0)&&(isAttacking == false)){
					if(distance = 10){
						this.gotoAndStop(2);//attack 1 animation
						zombiedamage = 100;//attack damage
						isAttacking = true;
						trace("attack start");
					}else if(distance > 10){
					isAttacking = false;
					trace("attack end");
					}
			}
		}
///////////////////////////////////////////////////////
//							MISC
///////////////////////////////////////////////////////
		private function to_radians(n:Number):Number {
				return (n*0.0174532925);
			}
		private function to_degrees(n:Number):Number {
				return (n*57.2957795);
			}
		public function randomRange(minNum:Number, maxNum:Number):Number {
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
	}//end class
}//end package
	
