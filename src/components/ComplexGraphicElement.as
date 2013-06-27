package components {
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	
	public class ComplexGraphicElement extends Sprite {
		
		private var g:Graphics;
		
		public function ComplexGraphicElement(initWidth:Number, initHeight:Number, color:uint) {
			g = this.graphics;
			g.beginFill(color);
			g.drawRoundRectComplex(0, 0, initWidth, initHeight, 0, 0, 20, 20);
			g.endFill();
				
		}
		/*public function updateXY(initX:Number, initWidth:Number, initHeight:Number, topL:Number, topR:Number, BottomL:Number, BottomR:Number, color:uint):void {
			g.clear();
			g = this.graphics;
			g.beginFill(color);
			g.drawRoundRectComplex(-initWidth, 0, initWidth+initX, initHeight, topL, topR, BottomL, BottomR);
			g.endFill();
			
			
		}*/
	}
}