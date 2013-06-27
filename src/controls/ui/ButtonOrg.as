package controls.ui {

	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.*;
		
	public class ButtonOrg extends Sprite {
		
		private var txt:TextField;
		private var label:String;
		private const WIDTH:uint = 305;
		public const HEIGHT:uint = 16;
		private var	sprite:Sprite;
		private var format:TextFormat;
		
		//CONSTRUCTOR
		public function ButtonOrg(label:String) {		
			format = new TextFormat();
			txt = new TextField;
			addChild(txt);
			txt.text = label;
			txt.width = WIDTH;
			txt.autoSize = TextFieldAutoSize.CENTER;
			//format
			format.font = "Verdana";
            format.color = 0x000000;
            format.size = 12;
			
			txt.setTextFormat(format);  			
            txt.defaultTextFormat = format;
            txt.selectable = false;
			txt.y = -2;
			txt.mouseEnabled = false
			
			sprite = new Sprite();

			sprite.graphics.beginFill(0xFFFFFF,0);
			sprite.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			sprite.graphics.endFill();
			addChild(sprite);
			sprite.addChild(txt);
			this.buttonMode = true
		}
		public function getWidth():Number {
			return sprite.width;
			
		}
		public function getHeight():Number {
			return sprite.height;
			
		}
	
	}//class
}//package