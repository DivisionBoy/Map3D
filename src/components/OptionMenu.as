package components {
	import controls.StaticField;
	import controls.ui.SingleButton;
	import controls.ui.SingleButtonItem;
	import controls.ui.SingleButtonItemSlider;
	
	import events.CommonEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class OptionMenu extends Sprite {
		private var bg:GraphicElement;
		private var bgIn:GraphicElement;
		private var buttonBloom:SingleButtonItem;
		private var buttonDepth:SingleButtonItem;
		private var buttonSSAO:SingleButtonItem;
		public var buttonClipping:SingleButtonItemSlider;
		private var singleButton:SingleButton;
		private var buttonShadow:SingleButtonItem;
		private var buttonAddress:SingleButtonItem;
		private var buttonRoad:SingleButtonItem;
		private var buttonPlants:SingleButtonItem;
		private var title:StaticField;
		private var buttonWater:SingleButtonItem;
		
		public function OptionMenu() {
			super();
			bg = new GraphicElement(800, 600, 0x000000);
			addChild(bg);
			bgIn = new GraphicElement(770, 570, 0xCCCCCC);
			bg.addChild(bgIn)
			bgIn.x = -15;
			bgIn.y = 15;
			
			var bgTitle:ComplexGraphicElement = new ComplexGraphicElement(200, 40, 0x4A4A4A);
			bg.addChildAt(bgTitle, bg.getChildIndex(bgIn)+1);
			bgTitle.x = -bgIn.width + 15;
			bgTitle.y = 15;
			//
			title = new StaticField("boldTextOption", "none","none","none", 0, 50);
			addChild(title);
			title.width = 200;
			title.x = -bgIn.width + 35;
			title.y = 15;
			title.text = "Настройка";
			
			//
			buttonBloom = new SingleButtonItem("Свечение(Bloom)", bgIn.width-30);
			addChild(buttonBloom);
			buttonBloom.x = -bgIn.width;
			buttonBloom.y = bgTitle.y + bgTitle.height+20;
			//Depth Of Field
			buttonDepth = new SingleButtonItem("Глубина(Depth Of Field)", bgIn.width-30);
			addChild(buttonDepth);
			buttonDepth.x = -bgIn.width;
			buttonDepth.y = buttonBloom.y + buttonBloom.itemHeight+10;
			//SSAO
			buttonSSAO = new SingleButtonItem("Затенение(SSAO)", bgIn.width-30);
			addChild(buttonSSAO);
			buttonSSAO.x = -bgIn.width;
			buttonSSAO.y = buttonDepth.y + buttonBloom.itemHeight+10;
			//Shadow
			buttonShadow = new SingleButtonItem("Тени", bgIn.width-30);
			addChild(buttonShadow);
			buttonShadow.x = -bgIn.width;
			buttonShadow.y = buttonSSAO.y + buttonBloom.itemHeight+10;
			
			//near/far clipping
			buttonClipping = new SingleButtonItemSlider("Видимое расстояние до объектов", bgIn.width-30);
			addChild(buttonClipping);
			//buttonClipping.addEventListener(
			buttonClipping.x = -bgIn.width;
			buttonClipping.y = buttonShadow.y + buttonBloom.itemHeight+10;
			//
			buttonAddress = new SingleButtonItem("Подпись адреса строения", bgIn.width-30);
			addChild(buttonAddress);
			buttonAddress.addButton("Фон");
			buttonAddress.x = -bgIn.width;
			buttonAddress.y = buttonClipping.y + buttonBloom.itemHeight+10;
			//Road
			buttonRoad = new SingleButtonItem("Выделить проезжую часть", bgIn.width-30, false);
			addChild(buttonRoad);
			buttonRoad.x = -bgIn.width;
			buttonRoad.y = buttonAddress.y + buttonBloom.itemHeight+10;
			//buttonRoad.unselect()
			//Plants
			buttonPlants = new SingleButtonItem("Растительность на карте(Деревья, трава)", bgIn.width-30);
			addChild(buttonPlants);
			buttonPlants.x = -bgIn.width;
			buttonPlants.y = buttonRoad.y + buttonBloom.itemHeight+10;
			//Water
			buttonWater = new SingleButtonItem("Вода", bgIn.width-30, false);
			addChild(buttonWater);
			buttonWater.x = -bgIn.width;
			buttonWater.y = buttonPlants.y + buttonBloom.itemHeight+10;

			singleButton = new SingleButton("Принять", 100);
			addChild(singleButton);
			singleButton.x = -singleButton.width-30;
			singleButton.y = 530;
			singleButton.addEventListener(MouseEvent.CLICK, onPressSingleButton);
			
		}
		
		protected function onPressSingleButton(event:MouseEvent):void {
			dispatchEvent(new CommonEvent(CommonEvent.BUTTON_ACCEPT));
			
		}
		
		public function lockCheck(param:Boolean, paramAlpha:Number):void {
			buttonAddress.checkboxPlus.mouseChildren = param;
			buttonAddress.checkboxPlus.mouseEnabled = param;
			buttonAddress.checkboxPlus.alpha = paramAlpha;
			
		}
	}
}