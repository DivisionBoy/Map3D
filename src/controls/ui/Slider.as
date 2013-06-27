package controls.ui{
	import components.GraphicElement;
	
	import events.OneNumberEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Slider extends Sprite {
		private var pimp:Sprite;
		private var bg:GraphicElement;
		private var movePimpBoo:Boolean = true;
		private var _grab:Number;
		private var bgtxt:GraphicElement;
		private var txt:TextField;
		private var format:TextFormat;
		private var procent:Number = 100;
		
		public function Slider(initWidth:Number) {
			super();
			
			bg = new GraphicElement(initWidth, 5, 0x000000,3,3);
			addChild(bg);
			pimp = new Sprite();
			addChild(pimp);
			pimp.graphics.beginFill(0xC4C4C4)
			pimp.graphics.drawCircle(0,0,7);
			pimp.graphics.endFill();
			pimp.y = 2;
			pimp.addEventListener(MouseEvent.MOUSE_DOWN, downPimp);
			//
			bgtxt = new GraphicElement(30, 30, 0x000000, 5, 5);
			addChild(bgtxt);
			bgtxt.x = 40
			bgtxt.y = -15
			//
			format = new TextFormat();
			txt = new TextField;
			addChild(txt);
			txt.text = Math.round(procent)+"";
			//txt.text = label;
			txt.autoSize = TextFieldAutoSize.LEFT;
			//format
			format.font = "Verdana";
			format.color = 0xffffff;
			format.size = 12;
			format.bold = true;
			
			txt.setTextFormat(format);  			
			txt.defaultTextFormat = format;
			txt.selectable = false;
			txt.border = false;
			txt.y = txt.height/2 - 20
			txt.x = 5+(40/2 - txt.width/2);

		}
		protected function downPimp(event:MouseEvent):void{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, movePimp);
			stage.addEventListener(MouseEvent.MOUSE_UP, upPimp);
			movePimpBoo = false;
			_grab = pimp.mouseX;
			
		}
		public function moveSlide(num:Number):void {
			if(!num == 0){
				pimp.x = num-200;
				txt.text =  Math.round(procent+(pimp.x/2))+"";
			}else{
				pimp.x = 0;
				txt.text = "100";
			}
			txt.x = 5+(40/2 - txt.width/2);
		}
		
		protected function upPimp(event:MouseEvent):void{
			movePimpBoo = true;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, movePimp);
			dispatchEvent(new OneNumberEvent(OneNumberEvent.CLICK_SLIDER_PIMP, -pimp.x/2));
			stage.removeEventListener(MouseEvent.MOUSE_UP, upPimp);
		}
		protected function movePimp(event:MouseEvent):void{
			pimp.x = Math.min(Math.max(-(bg.x+bg.width), this.mouseX+_grab), 0);
			txt.text = Math.round(procent+(pimp.x/2))+"";
			txt.x = 5+(40/2 - txt.width/2); 
			
		}
	}
}