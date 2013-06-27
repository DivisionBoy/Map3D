package controls.ui {

	import events.CommonEvent;
	import flash.display.Sprite;
	import model.ResourceManager;

	public class ToggleButton extends Sprite{
		private var buttonUp:ResourceManager;
		private var buttonDown:ResourceManager;
		private var flag:Boolean;
		
		public function ToggleButton(url_up:String, url_down:String) {
			mouseChildren = false;
			mouseEnabled = false;
			buttonUp = new model.ResourceManager(url_up);
			addChild(buttonUp);
			//
			buttonDown = new ResourceManager(url_down);
			addChild(buttonDown);
			buttonDown.visible = false;
		}
		
		public function clickButton():void {
			if(!this.flag){
				dispatchEvent(new CommonEvent(CommonEvent.TOGGLE_UP));
				buttonUp.visible = false;
				buttonDown.visible = true;
			}
			else{
				dispatchEvent(new CommonEvent(CommonEvent.TOGGLE_DOWN));
				buttonUp.visible = true;
				buttonDown.visible = false;
			}
			this.flag = !this.flag;
			
		}
		public function state(boo:String):void {
			if(boo == "false"){
				buttonUp.visible = false;
				buttonDown.visible = true;
			}else{
				buttonUp.visible = true;
				buttonDown.visible = false;
			}
		}
		
	}
}