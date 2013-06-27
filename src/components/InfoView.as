package components {
	import controls.StaticField;
	import controls.ui.ButtonOrg;
	
	import events.CommonEvent;
	import events.StringEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class InfoView extends Sprite {
		private var title:StaticField;
		private var address:StaticField;
		private var offets:Number = 5;
		private var nameBuild:StaticField;
		private var floor:StaticField;
		private var nameBuildingarr:Array = new Array();
		private var nonWordChars:Array = [":", "^"];
		private var buttonOrg:ButtonOrg;
		public var flag:Boolean = false;
		
		public function InfoView(initWidth:Number, initHeight:Number) {
			super();

			var bgInfo:ComplexGraphicElement = new ComplexGraphicElement(initWidth, initHeight, 0xCCCCCC)
			addChild(bgInfo);
			
			title = new StaticField("boldText", "none","none","none", 0xBFBFBF);
			addChild(title);
			title.width = initWidth -offets*4;
			title.x = (bgInfo.width - title.width)/2;
			title.y = 10;
			
			//
			address = new StaticField("boldText", "none","none","none", 0xBFBFBF);
			addChild(address);
			address.width = initWidth - offets*4;
			address.x = (bgInfo.width - address.width)/2;
			address.y = title.y + title.height + offets;
			//
			nameBuild = new StaticField("regular", "none","none","none", 0xBFBFBF);
			addChild(nameBuild);
			nameBuild.width = initWidth - offets*4;
			nameBuild.x = (bgInfo.width - nameBuild.width)/2;
			nameBuild.y = address.y + address.height + offets;
			//
			floor = new StaticField("regular", "none","none","none", 0xBFBFBF);
			addChild(floor);
			floor.width = initWidth -offets*4;
			floor.x = (bgInfo.width - floor.width)/2;
			floor.y = nameBuild.y + nameBuild.height + offets;
			//
			buttonOrg = new ButtonOrg("----------------- Организации -----------------");
			addChild(buttonOrg);
			buttonOrg.y = bgInfo.y + bgInfo.height-30;
			buttonOrg.addEventListener(MouseEvent.MOUSE_UP, mouseUpOrg);
			buttonOrg.visible = false;
		}
		
		protected function mouseUpOrg(event:MouseEvent):void {
			if(!this.flag){
				dispatchEvent(new StringEvent(StringEvent.CHANGE_VALUE, address.text));
			}
			else{
				dispatchEvent(new CommonEvent(CommonEvent.CLOSE_ORGLIST));
			}
			this.flag = !this.flag;
			
			
		}
		public function visibleOrgButtonOn():void {
			buttonOrg.visible = true;
			
		}
		public function visibleOrgButtonOff():void {
			buttonOrg.visible = false;
			
		}
		
		public function setText(nameBuilding:String):void {

			if(nameBuildingarr.length > 0) {
				for(var i:int = 0; i < nameBuildingarr.length; i++){
					nameBuildingarr.splice(i--, 1);
				}
			}
			if (nameBuilding.toString().toLowerCase().indexOf(":") != -1){
				nameBuildingarr = nameBuilding.split(".");

				var txtTemp:String = nameBuildingarr[0];
				for(var j:int = 0; j < nonWordChars.length; j++){
					txtTemp = txtTemp.toString().split(nonWordChars[j]).join("");
				}
				title.text = txtTemp;
				nameBuildingarr[1] != null ? address.text = nameBuildingarr[1] : address.text = "";
				nameBuildingarr[2] != null ? nameBuild.text = nameBuildingarr[2] : nameBuild.text = "";
				nameBuildingarr[3] != null ? floor.text = nameBuildingarr[3] : floor.text = "";
				
			}else{
				nameBuildingarr = nameBuilding.split(".");
				title.text = "";
				address.text = nameBuildingarr[0].toString().split("^").join("");
				nameBuildingarr[1] != null ? nameBuild.text = nameBuildingarr[1] : nameBuild.text = "";
				nameBuildingarr[2] != null ? floor.text = nameBuildingarr[2] : floor.text = ""; 
			}
		}
	}
}