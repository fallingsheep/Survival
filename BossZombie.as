package  {
	import flash.display.Stage;
    import flash.display.MovieClip;
    import flash.events.Event;
	public class BossZombie extends Zombie {
		
		public static var BossZombieX:int;
		public static var BossZombieY:int;
		//BOSS STUFF
		public var attackRandom:int;
		public var bossTimer:Timer = new Timer(1000,0)
		public var bosschargeTimer:Timer = new Timer(1000,0);
		public var SecondsElapsed:Number = 1;
		public var chargeSecondsElapsed:Number = 1;
		public var isCharging:Boolean = false;
		
		public function BossZombie(stageRef:Stage, BossZombieX:int, BossZombieY:int) {
			trace ("BOSS CREATED");
					radius = 12;//how big is the zombie in pixels (sphere)
					this.gotoAndStop(1)
					zombieSpeed = 0.2;
					zombiedamage = 10;
					zombiehitpoints = 200;
					agrorange = 200;
					addEventListener(Event.ENTER_FRAME,bosszombieloop);
			super (stageRef, ZombieX, ZombieY)
		}
		public function bosszombieloop(e:Event):void {
			attackRandom = randomRange(1,1000);// 1 in 1000 chance of charge attack
			if (survival.ispaused == false){				
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
					trace("boss attacking!");
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
					trace("boss charging!");
					}
				}
			}
		}
		public override function killZombie():void{
			survival.enemycontainer.removeChild(this);
			removeEventListener(Event.ENTER_FRAME,onFrame);
			survival.experience += 500;
			survival.currentcash += 500;
			survival.globalcashearnt += 500;
			survival.currentdead += 1;
			survival.spawnboss = false;
			trace("boss killed!");
		}

	}
	
}
