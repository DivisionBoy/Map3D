package controls {
	
	import alternativa.engine3d.objects.Mesh;
	
	import events.CheckInfoEvent;
	import events.CommonEvent;
	import events.MeshEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class ComboList extends Sprite {

		public var j:int = 0; //смещение элементов по приростании j параметра
		private var sp:Sprite;
		private var arr:Array = new Array();
		private var listView:ComboListView;
		
		
		private var arrLink:Array = new Array();
		private var _arrPosY:Array = new Array();
		private var arrObject:Array = new Array();
		private var arrNew:Array = new Array();
		
		private var txt:String;
		private var arrCont:Array = new Array();
		private var nonWordChars:Array = [":", "^"];
		private var checkThisText:String;
		
		//CONSTRUCTOR
		public function ComboList(objectMesh:Array) {	

			arrLink = objectMesh;
				
		}
		
		protected function onOut(event:MouseEvent):void{
			dispatchEvent(new CommonEvent(CommonEvent.MOUSE_OVER_SEARCH));
			
		}
		public function set checkText(txt:String):void {
			checkThisText = txt;
		}
		//Если объект найден отправляется положительное число, если нет, то отрицательное
		public function get searchStatus():Number {
			for(var i:int = 0; i < arrLink.length; i++){
				if(arrLink[i].name.toString().toLowerCase().indexOf(checkThisText.toLowerCase()) != -1){
					var statusNum:Number = 0;
					break;
					
				}else{
					statusNum = -1;
				}
			}
				return statusNum;
		}
		//Создание элементов найденных объектов в поиске
		public function createElement(text:String):void {
			txt = text
			if(arr.length > 0) {
				for(var k:int = 0; k < arr.length; k++){
					//очистка массива
					arr.splice(k--, 1);
				}
			}
			
			if(sp != null)removeChild(sp);
			sp = new Sprite();
			addChild(sp);
			_arrPosY.length = 0;
			arrObject.length = 0;

			for(var i:int = 0; i < arrLink.length; i++){
				//если введенный в поле поиска символ совпадает с текущими данными то данные добавляются в новый массив arr
				if (arrLink[i].toString().toLowerCase().indexOf(txt.toLowerCase()) != -1 /*&& arrLink[i].toString().toLowerCase().indexOf(txt.toLowerCase()) == " "*/) { 
					
					//заполнение нового массива из найденных данных
					arr.push(arrLink[i]);
					arrNew = arr[j].name.toString().split(".");
					var txtTemp:String = arrNew[0]
					for(var h:int = 0; h < nonWordChars.length; h++){
						txtTemp = txtTemp.toString().split(nonWordChars[h]).join("");
					}
					listView = new ComboListView(txtTemp,300);
					arrObject.push(listView);
					listView.addEventListener(MouseEvent.CLICK, mouseUp);			
					listView.y = listView.height*j++;
					sp.addChild(listView);
				}
			}
		}
		
		private function mouseUp(e:MouseEvent):void {
			var targetLink:DisplayObject = e.currentTarget as DisplayObject;
			var targetItemNum:Number = this.arrObject.indexOf(targetLink);

			dispatchEvent(new MeshEvent(MeshEvent.SEARCH_ID_ITEM, arr[targetItemNum] as Mesh));//отправляет ссылку найденного объекта _arr[targetItemNum]
			dispatchEvent(new CommonEvent(CommonEvent.MOUSE_DOWN_ITEM_SEARCH));
		}

	}//class
}//package