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
		public var bossTimer:Timer = new Timer(1000,0)
		public var bosschargeTimer:Timer = new Timer(1000,0);
		public var SecondsElapsed:Number = 1;
		public var chargeSecondsElapsed:Number = 1;
			
        public function BossZombie(stageRef:Stage, bossZombieX:int, bossZombieY:int):void {
				bossZombieX=400;
				bossZombieY=200;
				this.stageRef = stageRef;
				this.x = bossZombieX;
				this.y = bossZombieY;
				radius = 35;
				zombieSpeed = 0.5;
				isbigzombie = false;
				bosszombiehitpoints = 5000;
				agrorange = 400;//how far zombie can see
				addEventListener(Event.ENTER_FRAME,bosszombieloop);
        }
///////////////////////////////////////////////////////
//							Main Loop
///////////////////////////////////////////////////////

		
		public function bosszombieloop(e:Event):void {
			attackRandom = randomRange(1,1000);// 1 in 1000 chance of charge attack
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
				if(ischarging == true){
					
				}
				//attack player if in range
				if((distance <= 50)&&(isAttacking ==false)){
					this.rotation=to_degrees(Zangle);
					this.gotoAndStop(3);//attack 1
					zombiedamage = 2;//attack damage
					isAttacking = true;
					zombieSpeed = 0.5;
					ischarging = false;
					trace("boss attacking");
				}else if(distance > 75){
					isAttacking = false;
				}
				//move towards player
				if ((distance <= agrorange)&&(isAttacking ==false)){
					this.rotation=to_degrees(Zangle);
					this.gotoAndStop(2);
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
				//charge player if far enough away
				if ((distance >= 100)&&(ischarging == false)){
					this.rotation=to_degrees(Zangle);
					if(attackRandom == 1){
					zombieSpeed = 2;
					ischarging = true;
					trace("boss charging");
					}
				}
			}
		}
		var ischarging:Boolean;
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
	
