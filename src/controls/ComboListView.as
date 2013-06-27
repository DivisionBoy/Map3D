package controls {

	import events.CommonEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class ComboListView extends Sprite {

		public var txt:TextField;
		private const HEIGHT:int = 20;
		private var	sprite:Sprite;
		private var format:TextFormat;
		private var _widthItem:Number;
		
		//CONSTRUCTOR
		private var bgRow:Sprite;
		private var myStyleSheet:StyleSheet;
		private var defaultStyleObj:Object;
		private var myTextField:TextField;
		private var colorOver:uint = 0xE0E0E0;
		private var colorOut:uint = 0xC2C2C2;
		public function ComboListView(label:String, widthItem:Number=180) {
			
			_widthItem = widthItem;
			
			format = new TextFormat();
			txt = new TextField;
			txt.text = label;
			txt.mouseEnabled = false;
			txt.height = HEIGHT;
			txt.width = widthItem;
			txt.multiline = true;
			txt.wordWrap = true;
			txt.selectable = false;
			txt.border = false;
			
			//format
			format.align = "center";
			format.font = "Verdana";
			format.color = 0x000000;
			format.size = 12;
			
			txt.setTextFormat(format);  			
			txt.defaultTextFormat = format;
			
			addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			
			sprite = new Sprite();
			sprite.graphics.beginFill(0xC2C2C2);
			sprite.graphics.drawRect(0, 0, widthItem, 20);
			sprite.graphics.endFill();
			addChild(sprite);
			sprite.addChild(txt);

		}
		private function onRollOver(event:MouseEvent):void {
			updateGraphics(colorOver);
		}
		
		private function onRollOut(event:MouseEvent):void {
			updateGraphics(colorOut);

		}
		public function selectColor():void {
			updateGraphics(0xCCCCC);
			
		}
		private function updateGraphics(color:uint):void {
			graphics.clear();
			
			sprite.graphics.beginFill(color);
			sprite.graphics.drawRect(0, 0, _widthItem, HEIGHT);
			sprite.graphics.endFill();
		
		}
		public function openRow(txt:String):void {
			var myHTMLText:String = txt;
			defaultStyleObj = new Object();
			defaultStyleObj.fontFamily = "Verdana";
			
			myStyleSheet = new StyleSheet();
			myStyleSheet.setStyle("body", {fontSize:'12',color:'#000000', textAlign:'left'});
			myStyleSheet.setStyle("h1", {fontSize:'18',color:'#000000'});
			myStyleSheet.setStyle("h2", {fontSize:'19',color:'#000000'});
			myStyleSheet.setStyle("a:link", {color:'#0000CC',textDecoration:'none'});
			myStyleSheet.setStyle("a:hover", {color:'#0000FF',textDecoration:'underline'});
			myStyleSheet.setStyle("b", {fontWeight:'bold'});
			myStyleSheet.setStyle("em", {fontWeight:'bold'});
			myStyleSheet.setStyle(".defaultStyle", defaultStyleObj);
			myStyleSheet.setStyle("redText", {color:'#FF0000'});
			
			myTextField = new TextField();
			myTextField.width = _widthItem-20;
			myTextField.y = 20;
			myTextField.x = 10;
			myTextField.multiline = true;
			myTextField.styleSheet = myStyleSheet;
			myTextField.htmlText = myHTMLText;
			myTextField.autoSize = TextFieldAutoSize.LEFT;
			myTextField.wordWrap = true;
			myTextField.border = false;
			addChild(myTextField);
			
			bgRow = new Sprite();
			bgRow.graphics.beginFill(0x6E6E6E,0.4);
			bgRow.graphics.drawRect(0, 0, _widthItem, myTextField.height+20);
			bgRow.graphics.endFill();
			addChildAt(bgRow, getChildIndex(sprite));
			colorOut = 0x6E6E6E;
			colorOver = 0x878787;
			updateGraphics(colorOver)
			///
			//setChildIndex(bgRow, getChildIndex(myTextField))
			//var myHTMLText:String = "<span class='defaultStyle'><h1><b>HTML</b> Text <i>(sample <u>header</u>)</i></h1>Here is some <em>sample</em> <strong>html text</strong> "+"filling a text box <a href='http://www.adrianparr.com'>this link to adrianparr.com</a> and example headers"+"<br><br><br><h1>Header h1</h1><h2>Header h2</h2><br><br><br>Hello world<br><br><br><redText>This text <i>will be red</i></redText><br><br><h1>Boo</h1></span>";
			
			
			//bgRow.y = this.y
			//sprite.addChild(txt);
			
		}
		public function closeRow():void {
			colorOver = 0xE0E0E0;
			colorOut = 0xC2C2C2;
			updateGraphics(colorOut)
			removeChild(bgRow);
			bgRow = null;
			defaultStyleObj = null;
			myStyleSheet = null;
			removeChild(myTextField);
			myTextField = null;
			
		}
		
		
	}//class
}//package