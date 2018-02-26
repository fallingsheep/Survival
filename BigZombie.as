package  {
	import flash.display.Stage;
    import flash.display.MovieClip;
    import flash.events.Event;
	
	public class BigZombie extends Zombie {

		public static var BigZombieX:int;
		public static var BigZombieY:int;
		
		public function BigZombie(stageRef:Stage, BigZombieX:int, BigZombieY:int) {
			trace ("Big Zombie Created");
					radius = 9;//how big is the zombie in pixels (sphere)
					this.gotoAndStop(1)
					zombieSpeed = 0.2;
					zombiedamage = 5;
					zombiehitpoints = 20;
					agrorange = 200;
			super (stageRef, ZombieX, ZombieY)
		}
		public override function killZombie():void{
			survival.enemycontainer.removeChild(this);
			removeEventListener(Event.ENTER_FRAME,onFrame);
			survival.experience += 50;
			survival.currentcash += 50;
			survival.globalcashearnt += 50;
			survival.currentdead += 1;

		}

	}
	
}
