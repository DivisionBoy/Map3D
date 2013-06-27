package controls.ui {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class SingleButton extends Sprite {
		
		private var txt:TextField;
		private var label:String;
		private const WIDTH:uint = 50;
		public const HEIGHT:uint = 40;
		private var	sprite:Sprite;
		private var format:TextFormat;
		private var initWidth:Number;
		
		public function SingleButton(label:String, initWidth:Number) {
			this.initWidth = initWidth;
			buttonMode = true;
			format = new TextFormat();
			txt = new TextField;
			addChild(txt);
			txt.text = label;
			txt.autoSize = TextFieldAutoSize.LEFT;
			//format
			
			format.font = "Verdana";
			format.color = 0x000000;
			format.size = 16;
			format.bold = true;
			
			txt.setTextFormat(format);  			
			txt.defaultTextFormat = format;
			txt.selectable = false;
			txt.y = txt.height/2//HEIGHT/2//-2;
			txt.x = 10	
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			
			sprite = new Sprite();
			
			sprite.graphics.beginFill(0xFFFFFF);
			sprite.graphics.drawRect(0, 0, initWidth, HEIGHT);
			sprite.graphics.endFill();
			addChild(sprite);
			sprite.addChild(txt);
		}
		public function getWidth():Number {
			return sprite.width;
			
		}
		public function getHeight():Number {
			return sprite.height;
			
		}
		public function get itemHeight():Number{
			return sprite.height;
		}
		private function onRollOver(event:MouseEvent):void {
			updateGraphics(0x000000, HEIGHT);
		}
		
		private function onRollOut(event:MouseEvent):void {
			updateGraphics(0xFFFFFF, HEIGHT);
			format.color = 0x000000;
			txt.setTextFormat(format);  
		}
		private function updateGraphics(color:uint, initHeight:Number):void {
			graphics.clear();
			sprite.graphics.lineStyle(1, color);
			//sprite.graphics.beginFill(color);
			sprite.graphics.drawRect(0, 0, this.initWidth, initHeight);
			sprite.graphics.endFill();
			//format.color = 0xFFFFFF;
			//txt.setTextFormat(format);  			
		}
	}
}