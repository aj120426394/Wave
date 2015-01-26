package{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.Timer;
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality; 

	public class Wave extends MovieClip{
		
		var SPEED_OF_DRAWING:uint = 20; // in miliseconds
		var timer:Timer = new Timer(SPEED_OF_DRAWING);
		var radius = 50;
		var color: uint;
		var mainParent;
		var glow:GlowFilter;
		var waveArray:Array;
		
		var islands = new Array();
		
		
		public function Wave(_parent,_x,_y,_color,_waveArray){
			x = _x;
			y = _y;
			mainParent = _parent;
			color = _color;
			this.waveArray = _waveArray;
			getArray();
			//islands = mainParent.getIslandList();
			
			//timer.addEventListener(TimerEvent.TIMER, drawWave);
			//timer.start();
			
			addEventListener(Event.ENTER_FRAME, drawWave);
			
			glow = new GlowFilter();
			glow.color = 0xFFFFFF; 
			glow.alpha = 1; 
			glow.blurX = 25; 
			glow.blurY = 25; 
			glow.quality = BitmapFilterQuality.MEDIUM;
			
		}
		
		public function drawWave(event:Event){
			collision();
			if(radius < 1000){
				radius += 4;
				this.graphics.clear();
				this.graphics.lineStyle(10,this.color,1,false,"normal",null,null,3);
				//this.filters = [glow];
				this.graphics.drawCircle(0,0,radius);
				
			}else{
				removeSelf();
			}
		}
		
		public function removeSelf(){
			removeEventListener(Event.ENTER_FRAME, drawWave);
			mainParent.removeChild(this);
			this.waveArray.shift();
		}

		public function collision(){
			for(var i:String in this.islands){
				var distance = calDistance(islands[i].x,islands[i].y);

				if(distance > 50 && distance > radius+100){
					//trace(i+"DEBUGG1");
					//islands[i].setClickable(false);
				}else if(distance > 50 && radius+45 < distance  && distance <= radius+100){
					//trace(i+"DEBUGG2");
					if(islands[i].getClickFlag()){
						islands[i].setClickable(false);
					}else{
						islands[i].setClickable(true);
					}
					
				}else if(distance > 50 && distance <= radius+45){
					//trace(i+"DEBUGG3");
					islands[i].setClickable(false);
					if(islands[i].getClickFlag()){
						islands[i].setClickFlag(false);
						trace("WIN!!!!!!!!!!");
					}else{
						trace("too late"+ i);
						mainParent.getChance();
					}
					islands.splice(i,1);
				}
				

			}
		}
		
		private function calDistance(targetX:Number,targetY:Number):Number{
			var dx = x - targetX;
			var dy = y - targetY;
			return Math.sqrt(dx*dx+dy*dy);
		}
		
		private function getArray(){
			var tempList = mainParent.getIslandList();
			for(var i:String in tempList){
				//if(tempList[i].x != this.x && tempList[i].y != this.y){
					
				//}
				islands.push(tempList[i]);
				
			}
			
		}
	}
}