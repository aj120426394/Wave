package{
	import flash.display.MovieClip;
	import flash.text.*;
	import flash.events.*;
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality; 

	public class Popup extends MovieClip{
		var surviveTime: String;
		var format: TextFormat;
		var againFromat: TextFormat;
		var survive:TextField;
		var again: TextField;
		var glow:GlowFilter;
		
		public function Popup(surviveTime){
			this.x = 0;
			this.y = 0;
			this.surviveTime = surviveTime;
			
			format = new TextFormat();
			format.size = 90;
			format.font = "Tekton Pro";
			format.bold;
			
			againFromat = new TextFormat();
			againFromat.size = 90;
			againFromat.font = "Tekton Pro";
			againFromat.bold;
			againFromat.color = 0x009E25;
			
			survive = new TextField();
			survive.x = 550;
			survive.y = 300;
			survive.width = 400;
			survive.defaultTextFormat = format;
			survive.text = surviveTime;
			this.addChild(survive);
			
			
			again = new TextField();
			again.x = 320;
			again.y = 500;
			again.width = 400;
			again.defaultTextFormat = againFromat;
			again.text = "Play again";
			this.addChild(again);
			
			
			glow = new GlowFilter();
			glow.color = 0xFFFFFF; 
			glow.alpha = 1; 
			glow.blurX = 25; 
			glow.blurY = 25; 
			glow.quality = BitmapFilterQuality.MEDIUM;
			
			again.addEventListener(MouseEvent.ROLL_OVER, _rollOver);
			again.addEventListener(MouseEvent.ROLL_OUT, _rollOut);
			
			function _rollOver(e:Event):void
			{
				again.filters = [glow];
			}

			function _rollOut(e:Event):void
			{
				again.filters = [];
			}
		}
	}
}