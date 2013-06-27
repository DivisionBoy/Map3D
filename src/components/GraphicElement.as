package components {
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	
	public class GraphicElement extends Sprite {
		
		private var g:Graphics;
		private var color:uint;
		
		public function GraphicElement(initX:Number, initY:Number, color:uint, one:int=20,two:int=20) {
			this.color = color;
			g = this.graphics;
			g.beginFill(color);
			g.drawRoundRect(-initX, 0, initX, initY, one, two);
			g.endFill();
			
		}
		public function updateXY(initX:Number, initWidth:Number, initHeight:Number, one:int=20,two:int=20):void {
			g.clear();
			g = this.graphics;
			g.beginFill(this.color);
			g.drawRoundRect(-initWidth, 0, initWidth+initX, initHeight, one, two);
			g.endFill();
			
			
		}
	}
}