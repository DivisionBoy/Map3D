package {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	public class Log extends Sprite {
		private static var txt:TextField;
		
		public function Log() {
			//trace("LOG:", msg);
			
			
		}
		
		public static function mes(msg:String):void {
			
			txt.text = msg
			
		}
		public static function detector(stage:Stage):void {
			txt = new TextField()
			stage.addChild(txt)
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.background = true;
			txt.backgroundColor = 0xCCCCCC
		}

	}
}