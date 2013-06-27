package events {
 
	import flash.events.Event;
 
	public class StringEvent extends Event {
 
		private var _val:String;

		public static const CHANGE_VALUE:String = "change_value"; 
 
		public function StringEvent(type:String, val:String) { 
			super(type, true, false);
 
			_val = val;
		}
 
		public function get value():String {
			return _val;
		}

	}//class
}//package