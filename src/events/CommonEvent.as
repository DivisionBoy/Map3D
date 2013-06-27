package events {
	
	import flash.events.Event;

	public class CommonEvent extends Event {
		
		//toggleButton
		public static const TOGGLE_UP:String = "toggle_up";
		public static const TOGGLE_DOWN:String = "toggle_down";
		//Button OK - CANCEL
		public static const BUTTON_OK:String = "button_ok";
		public static const BUTTON_CANCEL:String = "button_cancel";
		//SEARCH
		public static const MOUSE_OVER_SEARCH:String = "mouse_over_search";
		public static const MOUSE_DOWN_ITEM_SEARCH:String = "mouse_down_item_search";

		public static const COMBOBOX_BUTTON:String =  "combobox_button";
		public static const COMBOBOX_CLOSE:String = "combobox_close";
		public static var MOUSE_DOWN_BUTTON_ORG:String = "mouse_down_button_org";
		public static var CLOSE_ORGLIST:String = "close_orglist";
		public static var CLICK_ITEM:String = "click_item";
		public static var UPDATE_COORDINATE:String = "update_coordinate";
		public static var ROLLOVERITEM:String = "rolloveritem";
		public static var ROLLOUTITEM:String = "rolloutitem";
		public static var FREE_CAM:String = "free_cam";
		public static var WALK_CAM:String = "walk_cam";
		public static var STANDARD_CAM:String = "standard_cam";
		public static var OPTION_BUTTON_PRESS:String = "option_button_press";
		public static var BUTTON_ACCEPT:String = "button_accept";
		
		public function CommonEvent(type:String) {
			super(type, true, false);
			
		}
	}
}