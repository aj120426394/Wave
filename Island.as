package{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.display.Sprite; 
	import flash.filters.BitmapFilterQuality; 

	
	public class Island extends MovieClip{
		var mainParent;
		var color:uint;
		var clickFlag:Boolean;
		var clickable:Boolean;
		var KEY;
		var glow:GlowFilter;
		var waveArray:Array;
		
		public function Island(_parent,_x,_y,_color,KEY,_waveArray){
			x = _x;
			y = _y;
			clickFlag = false;
			clickable = false;
			mainParent = _parent;
			color = _color;
			drawIsland();
			this.KEY = KEY;
			glow = new GlowFilter();
			glow.color = 0xFFFFFF; 
			glow.alpha = 1; 
			glow.blurX = 25; 
			glow.blurY = 25; 
			glow.quality = BitmapFilterQuality.MEDIUM;
			this.waveArray = _waveArray;
			
			//addEventListener(MouseEvent.CLICK, explode);
		}
		
		private function drawIsland(){
			graphics.beginFill(0,1);
			graphics.lineStyle(10,this.color,1,false,"normal",null,null,3);
			graphics.drawCircle(0,0,50);
			graphics.endFill();
			
			
			graphics.lineStyle(35,this.color,1,false,"normal",null,null,3);
			graphics.drawCircle(0,0,65);
			
			/*
			graphics.lineStyle(35,this.color,0.4,false,"normal",null,null,3);
			graphics.drawCircle(0,0,65);
			
			*/
		}
		
		public function explode(){
			if(clickable){
				var b = new Wave(mainParent,x,y,this.color,this.waveArray);
				this.waveArray.push(b);
				mainParent.addChild(b);				
				setClickFlag(true);
			}else{
				trace("too early");
				mainParent.getChance();
			}
		}
		
		public function getClickFlag(){
			return clickFlag;
		}
		public function setClickFlag(flag:Boolean){
			clickFlag = flag;
		}
		public function getClickable(){
			return clickable;
		}
		public function setClickable(flag:Boolean){
			if(flag == true){
				this.filters = [glow];
			}else{
				this.filters = null;
			}
			clickable = flag;
		}
	}
}