package components {
	
	import controls.ui.AccordionBox;
	import controls.ui.ScrollBox;
	
	import events.CommonEvent;
	
	import flash.display.Sprite;
	
	public class OrgView extends Sprite {
		
		private var accordion:AccordionBox;
		private var heghtScrollBox:Number = 150;
		private var scroller:ScrollBox;
		
		public function OrgView(listOrg:Array, initWidth:Number, initHeight:Number) {
			super();
			var bgInfo:ComplexGraphicElement = new ComplexGraphicElement(initWidth, initHeight+50, 0xCCCCCC);
			addChild(bgInfo);
			accordion = new AccordionBox(listOrg);
			accordion.addEventListener(CommonEvent.CLICK_ITEM, clickItem);
			accordion.addEventListener(CommonEvent.UPDATE_COORDINATE, updateScrollBox);
			accordion.createElement(listOrg);
			scroller = new ScrollBox(accordion, heghtScrollBox);
			addChild(scroller);
			scroller.y = 30;
		}
		
		protected function updateScrollBox(event:CommonEvent):void {
			scroller.updateGraphic(accordion.height);
			
		}
		
		protected function clickItem(event:CommonEvent):void {
			scroller.updateGraphic(accordion.height);
			
		}
	}
}