package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;
	
	
	public class Main extends MovieClip {
		var islands:Array = new Array();
		var waveArray:Array = new Array();
		var timer:Timer;
		var clearWaveTime:Number;
		var tmpTime:Number;
		var timeCount:TextField;
		var chanceCount:TextField;
		var test:TextField;
		var format:TextFormat;
		var islandNum:Number;
		var level:Number;
		var clearWave:Boolean;
		var clearWaveReloadTime:Number;
		var reloadTime:Number;
		var gameStart:Boolean;
		
		public function Main() {
			// constructor code

			var title = new Title();
			title.y = 50;
			this.addChild(title);
			
			var beg = new LV_beg();
			beg.x = 345.05;
			beg.y = 316.45;
			this.addChild(beg);
			beg.addEventListener(MouseEvent.CLICK, beginnerLV);

			
			var intermediate = new LV_int();
			intermediate.x = 267.60;
			intermediate.y = 432.00;
			this.addChild(intermediate);
			intermediate.addEventListener(MouseEvent.CLICK, intermediateLV);
			
			var adv = new LV_adv();
			adv.x = 315.85;
			adv.y = 553.60;
			this.addChild(adv);
			adv.addEventListener(MouseEvent.CLICK, advancedLV);
			
			format = new TextFormat();
			format.size = 40;
			format.font = "Tekton Pro";
			format.bold;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, explode);
			
			clearWave = true;
			clearWaveTime = 0;
			gameStart = false;
		}
		
		public function getIslandList():Array{
			return islands;
		}
		public function explode(e:KeyboardEvent){
			trace(e.keyCode);
			if(e.keyCode == 87){
				islands[0].explode();
			}
			else if(e.keyCode == 13){
				islands[1].explode();
			}
			else if(e.keyCode == 32 && (this.level == 3 || this.level == 2)){
				islands[2].explode();
			}
			else if(e.keyCode == 71 && clearWave){
				this.clearAllWave();
				clearWave = false;
			}
		}
		private function beginnerLV(e:MouseEvent):void{
			this.islandNum = 2;
			this.level = 1;
			this.clearWaveReloadTime = 100;
			setDashboard();
			trace(e);
			
			islands.push(new Island(this,100,150,0xE81A5F,87,this.waveArray));
			this.addChild(islands[0]);
			
			islands.push(new Island(this,920,250,0x009E25,38,this.waveArray));
			this.addChild(islands[1]);
			
			var tsunami = new Wave(this,510,350,0x30A4E3,this.waveArray);
			this.waveArray.push(tsunami);
			this.addChild(tsunami);
			
			startTimer();
		}
		private function intermediateLV(e:MouseEvent):void{
			this.islandNum = 3;
			this.clearWaveReloadTime = 100;
			this.level = 2;
			setDashboard();
			
			islands.push(new Island(this,100,150,0xE81A5F,87,this.waveArray));
			this.addChild(islands[0]);
			
			islands.push(new Island(this,920,250,0x009E25,38,this.waveArray));
			this.addChild(islands[1]);
			
			islands.push(new Island(this,500,650,0x3B13B0,83,this.waveArray));
			this.addChild(islands[2]);
			
			var tsunami = new Wave(this,510,350,0x30A4E3,this.waveArray);
			this.waveArray.push(tsunami);
			this.addChild(tsunami);
			
			startTimer();
		}
		private function advancedLV(e:MouseEvent):void{
			this.islandNum = 3;
			this.clearWaveReloadTime = 0;
			this.level = 3;
			setDashboard();
			
			islands.push(new Island(this,100,150,0xE81A5F,87,this.waveArray));
			this.addChild(islands[0]);
			
			islands.push(new Island(this,920,250,0x009E25,38,this.waveArray));
			this.addChild(islands[1]);
			
			islands.push(new Island(this,500,650,0x3B13B0,83,this.waveArray));
			this.addChild(islands[2]);
			
			var tsunami = new Wave(this,510,350,0x30A4E3,this.waveArray);
			this.waveArray.push(tsunami);
			this.addChild(tsunami);
			
			startTimer();
		}
		private function setDashboard():void{
			while (this.numChildren > 1) {
				this.removeChildAt(this.numChildren-1);
			}
			
			var chanceWord = new chance_word();
			chanceWord.x = 420;
			chanceWord.y = 300;
			this.addChild(chanceWord);
			
			chanceCount = new TextField();
			chanceCount.x = 530;
			chanceCount.y = 300;
			chanceCount.defaultTextFormat = format;
			chanceCount.text = "10";
			this.addChild(chanceCount);
			
			timeCount = new TextField();
			timeCount.x = 421;
			timeCount.y = 14;
			timeCount.width = 150;
			timeCount.defaultTextFormat = format;
			timeCount.text = "00:00.00";
			this.addChild(timeCount);
			
			test = new TextField();
			test.x = 325;
			test.y = 400;
			test.width = 400;
			test.defaultTextFormat = format;
			test.text  = "Shockwave Ready";
			this.addChild(test);
			
		}
		
		private function clearAllWave(){
			while(this.waveArray.length > 0){
				this.waveArray[0].removeSelf();
			}
			for(var i:String in this.islands){
				this.islands[i].setClickable(false);
			}
			var tsunami = new Wave(this,510,350,0x30A4E3,this.waveArray);
			this.waveArray.push(tsunami);
			this.addChild(tsunami);
			
		}
		
		private function startTimer():void{
			timer = new Timer(100); //create a new timer that ticks every second.
			timer.addEventListener(TimerEvent.TIMER, getSurviveTime, false, 0, true); //listen for the timer tick
			tmpTime = flash.utils.getTimer();
			timer.start(); //start the timer
		}
		
		public function getSurviveTime(e:Event):void{
			if(this.level == 3 && 0.05 > Math.random() > 0){
				var tsunami = new Wave(this,510,350,0x30A4E3,this.waveArray);
				this.addChild(tsunami);
			}
			timeCount.text = showTimePassed(flash.utils.getTimer() - tmpTime);
			if(this.numChildren - this.islandNum < 6){
				showLose();
			}
			
			if(clearWave  == false){
				if(clearWaveTime < this.clearWaveReloadTime){
					clearWaveTime ++;
					trace(clearWaveTime);
					if(clearWaveTime %10 <= 0){
						reloadTime--;
					}
				}else{
					clearWave = true;
					this.clearWaveReloadTime += 50;
				}
				test.text = "Shockwave Loading..." + reloadTime;
			}else{
				clearWaveTime = 0;
				test.text = "Shockwave Ready";
				reloadTime = clearWaveReloadTime / 10;
			}
			
			
		}
		
		//this function will format your time like a stopwatch
		private function showTimePassed(startTime:int):String {
			var leadingZeroMS:String = ""; //how many leading 0's to put in front of the miliseconds
			var leadingZeroS:String = ""; //how many leading 0's to put in front of the seconds

			var time = startTime; //this gets the amount of miliseconds elapsed
			var miliseconds = (time % 1000); // modulus (%) gives you the remainder after dividing, 


			if (miliseconds < 10) { //if less than two digits, add a leading 0
				leadingZeroMS = "0";
			}

			var seconds = Math.floor((time / 1000) % 60); //this gets the amount of seconds

			if (seconds < 10) { //if seconds are less than two digits, add the leading zero
				leadingZeroS = "0";
			}

			var minutes = Math.floor( (time / (60 * 1000) ) ); //60 seconds times 1000 miliseocnds gets the minutes
			return minutes + ":" + leadingZeroS + seconds + "." + leadingZeroMS + miliseconds;
		}
		
		private function showLose():void{
			timer.stop();
			showPopup = true;
			while(this.waveArray.length > 0){
				this.waveArray[0].removeSelf();
			}
			
			while (this.numChildren > 1) {
				this.removeChildAt(this.numChildren-1);
			}
			
			var p:Popup = new Popup(timeCount.text);
			p.again.addEventListener(MouseEvent.CLICK, resetGame);
			addChild(p);
		}
		
		private var showPopup:Boolean = true;
		
		public function getChance(){
			
			if(int(chanceCount.text) > 0){
				chanceCount.text = int(chanceCount.text)-1+"";
			} else {
				if (showPopup) {
					showPopup = false;
					showLose();
				}
			}
			
		}
		
		public function resetGame(e:MouseEvent):void{
			while (this.numChildren > 1) {
				this.removeChildAt(this.numChildren-1);
			}
			//stage.removeEventListener(KeyboardEvent.KEY_DOWN, explode);
			showPopup = true;
			clearWave = false;
			while(islands.length > 0){
				islands.pop();
			}
			
			var title = new Title();
			title.y = 50;
			this.addChild(title);
			
			var beg = new LV_beg();
			beg.x = 345.05;
			beg.y = 316.45;
			this.addChild(beg);
			beg.addEventListener(MouseEvent.CLICK, beginnerLV);
			
			var intermediate = new LV_int();
			intermediate.x = 267.60;
			intermediate.y = 432.00;
			this.addChild(intermediate);
			intermediate.addEventListener(MouseEvent.CLICK, intermediateLV);
			
			var adv = new LV_adv();
			adv.x = 315.85;
			adv.y = 553.60;
			this.addChild(adv);
			adv.addEventListener(MouseEvent.CLICK, advancedLV);
			
			format = new TextFormat();
			format.size = 40;
			format.font = "Tekton Pro";
			format.bold;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, explode);
			
			clearWave = true;
			clearWaveTime = 0;
		}
		
	}
	
}
