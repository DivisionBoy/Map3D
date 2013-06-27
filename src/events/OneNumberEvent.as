package events {
 
	import flash.events.Event;
 
	public class OneNumberEvent extends Event {
 
		private var _val:Number;

		public static const CLICK_SLIDER_PIMP:String = "click_slider_pimp"; 
 		public static const SEARCH_ID_ITEM:String = "search_id_item";
		
		
		public function OneNumberEvent(type:String, val:Number) { 
			super(type, true, false);
 
			_val = val;
		}
 
		public function get value():Number {
			return _val;
		}
		
	}//class
}//package