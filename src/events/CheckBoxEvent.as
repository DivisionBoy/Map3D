package events {
 
	import flash.events.Event;
 
	public class CheckBoxEvent extends Event {
 
		private var _val:String;

		public static var TOGGLE_CHECKBOX_UP:String = "toggle_checkbox_up";
		public static var TOGGLE_CHECKBOX_DOWN:String = "toggle_checkbox_down";
		
		
		public function CheckBoxEvent(type:String, val:String) { 
			super(type, true, false);
 
			_val = val;
		}
 
		public function get value():String {
			return _val;
		}
		
	}//class
}//package