package events {
 
	import alternativa.engine3d.objects.Mesh;
	
	import flash.events.Event;
 
	public class MeshEvent extends Event {
 
		private var _val:Mesh;

 		public static const SEARCH_ID_ITEM:String = "search_id_item";
		
		
		public function MeshEvent(type:String, val:Mesh) { 
			super(type, true, false);
 
			_val = val;
		}
 
		public function get value():Mesh {
			return _val;
		}
		
	}//class
}//package