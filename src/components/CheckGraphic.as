package components {
	import flash.display.Sprite;
	
	public class CheckGraphic extends Sprite {
		private var oneSide:Sprite = new Sprite();
		private var twoSide:Sprite = new Sprite();
		
		public function CheckGraphic(){
			this.mouseChildren = false;
			this.mouseEnabled = false;
			addChild(oneSide);
			oneSide.graphics.lineStyle(2.5, 0xFFFFFF);
			oneSide.graphics.lineTo(3, 3);
			oneSide.y = 0;
			oneSide.rotation = 5;
			addChild(twoSide);
			twoSide.graphics.lineStyle(2.5, 0xFFFFFF);
			twoSide.graphics.lineTo(6, 6);
			twoSide.rotation = 77;
			twoSide.x = 8;
			twoSide.y = -3;
		}
		
	}
	
}



