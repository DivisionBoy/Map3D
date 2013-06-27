package controls.ui {
	import components.ComplexGraphicElement;
	
	import controls.ComboListView;
	
	import events.CommonEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class AccordionBox extends Sprite {
		private var listView:ComboListView;
		private var arr:Array = new Array();

		private var selectObject:Object;
		private var currentHeight:Number;
		private var currentObject:Object;
		private var listOrg:Array;
		
		public function AccordionBox(listOrg:Array) {
			
			super();
			
		}
		
		public function getHeight():Number{
			return currentHeight;
		}
		
		public function createElement(listOrg:Array):void {
			this.listOrg = listOrg;
			for(var i:int = 0; i < listOrg.length; i++){
				listView = new ComboListView(listOrg[i].label,305);
				addChild(listView);
				listView.y = listView.height*i;
				listView.addEventListener(MouseEvent.CLICK, onClick);
				arr.push(listView);
			}
			
		}
		
		protected function onClick(e:MouseEvent):void {
			currentObject = e.currentTarget as DisplayObject;
			var targetNum:int = arr.indexOf(currentObject);
			
			currentHeight = currentObject.height+currentObject.y;
			if(selectObject != null)selectObject.closeRow();
			selectObject = e.currentTarget;
			dispatchEvent(new CommonEvent(CommonEvent.CLICK_ITEM));
			selectObject.openRow("<span class='defaultStyle'><body>"+""+listOrg[targetNum].item1+"</body>\n"+""+listOrg[targetNum].item2+"\n<a href='http:\\"+listOrg[targetNum].item3+"'>"+listOrg[targetNum].item3+"</a></span>");//listOrg[targetNum].item1
			setCoo();			
		}
		private function setCoo():void {
			var h_cumulate:Number = 0;
			for(var i:int = 0; i < this.listOrg.length; i++){
				arr[i].y = h_cumulate;//arr[i].height*i;
				h_cumulate += arr[i].height;
			}
			currentHeight = currentObject.height+currentObject.y;
			dispatchEvent(new CommonEvent(CommonEvent.UPDATE_COORDINATE));
			
		}
		
	}
}