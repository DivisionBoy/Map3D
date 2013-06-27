package events {
	
	import flash.events.Event;
	
	public class CheckInfoEvent extends Event {
		
		private var _val:String;
		
		public static const CHECK:String = "check";
		
		public function CheckInfoEvent(type:String) { 
			super(type, true, false);
			

		}

	}//class
}//package