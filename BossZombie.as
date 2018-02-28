package  {
	import flash.display.Stage;
    import flash.display.MovieClip;
    import flash.events.Event;
	public class BossZombie extends Zombie {
		
		public static var BossZombieX:int;
		public static var BossZombieY:int;
		//BOSS STUFF
		public var isCharging:Boolean = false;
		
		public function BossZombie(stageRef:Stage, BossZombieX:int, BossZombieY:int) {
			trace ("BOSS CREATED");
					radius = 12;//how big is the zombie in pixels (sphere)
					this.gotoAndStop(1)
					zombieSpeed = 0.2;
					zombiedamage = 10;
					zombiehitpoints = 2000;
					agrorange = 200;
					addEventListener(Event.ENTER_FRAME,bosszombieloop);
			super (stageRef, ZombieX, ZombieY)
		}
		public function bosszombieloop(e:Event):void {
			trace ("BOSS CREATED"+zombiehitpoints);
			attackRandom = randomRange(1,100);// 1 in 100 chance of charge attack
			if (survival.ispaused == false){
				var Zdist_x:Number=this.x-survival.player.x;
				var Zdist_y:Number=this.y-survival.player.y;
				var Zangle:Number=- Math.atan2(Zdist_x,Zdist_y);
				var distance:Number = Math.sqrt((Zdist_x)*(Zdist_x) + (Zdist_y)*(Zdist_y));
				if(isCharging == true){
					
				}
				//attack player if in range
				if((distance <= 50)&&(isAttacking ==false)){
					this.rotation=to_degrees(Zangle);
					this.gotoAndStop(3);//attack 1
					zombiedamage = 2;//attack damage
					isAttacking = true;
					zombieSpeed = 0.5;
					isCharging = false;
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
				if ((distance >= 100)&&(isCharging == false)){
					this.rotation=to_degrees(Zangle);
					if(attackRandom == 1){
					zombieSpeed = 2;
					isCharging = true;
					trace("boss charging!");
					}
				}
				
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
				//kill zombie if hp is 0 or below
				if (zombiehitpoints <= 0){
					killZombie();
				}
			}
		}
		public override function killZombie():void{
			if(survival.enemycontainer.contains(this)){
				survival.enemycontainer.removeChild(this);
			}
			removeEventListener(Event.ENTER_FRAME,onFrame);
			removeEventListener(Event.ENTER_FRAME,bosszombieloop);
			survival.experience += 500;
			survival.currentcash += 500;
			survival.globalcashearnt += 500;
			survival.currentdead += 1;
			survival.bossspawn = false;
			trace("boss killed!");
		}

	}
	
}
