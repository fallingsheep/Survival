package {
    import flash.display.Stage;
    import flash.display.MovieClip;
    import flash.events.Event;
 
    public class Bullet extends MovieClip {
		
        private var stageRef:Stage;
        private var speed:Number = 10;
		private var xVel:Number = 0;
		private var yVel:Number = 0;
		private var rotationInRadians = 0;
 
        public function Bullet(stageRef:Stage, X:int, Y:int, rotationInDegrees:Number):void {
            this.stageRef = stageRef;
            this.x = X;
            this.y = Y;
			
			this.rotation = rotationInDegrees;
			this.rotationInRadians = rotationInDegrees * Math.PI / 180;
        }
///////////////////////////////////////////////////////
//							Main Loop
///////////////////////////////////////////////////////
        public function loop():void {
			xVel = Math.cos(rotationInRadians) * speed;
			yVel = Math.sin(rotationInRadians) * speed;
			
			x += xVel;
			y += yVel;
			//remove bullet if it goes off stage
			
        }
    }
}