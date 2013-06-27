package events {
	
	import flash.events.Event;
	
	public class ButtonEvent extends Event {
		
		private var _val:String;
		
		public static const PRESS_MENU_BUTTON:String = "press_menu_button";
		public static const PRESS_EXTENDED_BUTTON:String = "press_extended_button";
		//
		public static const BUTTON_OK:String = "button_ok";
		public static const BUTTON_CANCEL:String = "button_cancel";
		
		public static const BUTTON_CHECKBOX:String = "button_checkbox";
		
		public function ButtonEvent(type:String, val:String) { 
			super(type, true, false);
			
			_val = val;

		}
		
		public function get value():String {
			return _val;
		}

	}//class
}//package