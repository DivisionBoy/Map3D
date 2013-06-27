package controls {
	
	import com.greensock.TweenMax;
	
	import components.GraphicElement;
	import components.InfoView;
	import components.OrgView;
	
	
	import events.CheckInfoEvent;
	import events.CommonEvent;
	import events.MeshEvent;
	import events.StringEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.utils.Timer;
	import controls.ui.ScrollBoxMenu;
	import controls.ui.SingleButtonIco;
	import controls.ui.ToggleButton;

	public class ManagerControls extends Sprite {

		public var txt:StaticField;
		private static var timer:Timer;
		private static var comboList:ComboList;
		//private static var _stage:Stage;
		private var scroller:ScrollBoxMenu;
		private var heghtScrollBox:Number = 150;
		private var glowFilter:GlowFilter = new GlowFilter(0x000000,1,10,10,1,2);
		
		//CONSTRUCTOR
		private var bg:GraphicElement;
		private var infoView:InfoView;
		private var check:Boolean = false;
		private var orgView:OrgView;
		private var optionButton:SingleButtonIco;
		private var containerSearch:Sprite = new Sprite();
		private var walkCamButton:SingleButtonIco;
		private var currentViewModeButton:Object;
		private var previousViewModeButton:Object;
		private const HEIGHT_BG:Number = 30;
		private var stateCamButton:ToggleButton;
		private var bgTitle:GraphicElement;
		private var bgMaska:GraphicElement;
		private var bgOption:GraphicElement;
		private var bgCam:GraphicElement;
		private var bgWalkCam:GraphicElement;
		
		
		public function ManagerControls(initWidth:Number) {
			/*cont = new Sprite();
			addChild(cont);*/
			//addChild(container)
			timer = new Timer(50, 1);
			timer.addEventListener(TimerEvent.TIMER, removeObject);
			//_stage = registr;
			addChild(containerSearch);
			
			txt = new StaticField("search","none","none","edit", 0x878787, 20, 285);
			containerSearch.addChild(txt);
			txt.x = 0;
			txt.y = HEIGHT_BG - txt.height - 5;
			txt.addEventListener(FocusEvent.FOCUS_OUT, focusKill);
			txt.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE, focusKill);
			txt.addEventListener(Event.CHANGE, changeText);
			txt.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			txt.text = "Поиск ";
			//
			bgOption = new GraphicElement(50, 50, 0xA6A6A6, 15, 15);
			addChild(bgOption);
			bgOption.buttonMode = true;
			bgOption.x = bgOption.width;
			bgOption.y = -20;
			bgOption.addEventListener(MouseEvent.CLICK, optionButtonPress);
			//bgCam
			bgCam = new GraphicElement(50, 50, 0xA6A6A6, 15, 15);
			addChild(bgCam);
			bgCam.buttonMode = true;
			bgCam.x = txt.width;
			bgCam.y = -20;
			bgCam.addEventListener(MouseEvent.CLICK, stateCamInit);
			//bgWalkCam
			bgWalkCam = new GraphicElement(50, 50, 0xA6A6A6, 15, 15);
			addChild(bgWalkCam);
			bgWalkCam.buttonMode = true;
			bgWalkCam.x = bgCam.x -bgWalkCam.width - 10;
			bgWalkCam.y = -20;
			bgWalkCam.addEventListener(MouseEvent.CLICK, walkCamInit);
			//
			bgMaska = new GraphicElement(txt.width+20, 800, 0xFF0000, 0, 0);
			addChild(bgMaska);
			bgMaska.x = bgMaska.width - 10;
			bgMaska.y = 30;
			containerSearch.mask = bgMaska;
			bgMaska.alpha = 0.5;
			
			bgTitle = new GraphicElement(txt.width+20, 60, 0x4A4A4A, 0, 0);
			addChildAt(bgTitle, getChildIndex(containerSearch));
			bgTitle.x = bgTitle.width-10;
			bgTitle.filters = [glowFilter];
			
			bg = new GraphicElement(txt.width+20, HEIGHT_BG, 0x4A4A4A, 0, 0)
			containerSearch.addChildAt(bg, containerSearch.getChildIndex(txt))
			//bg.y = 40;

			bg.x = bg.width-10;
			containerSearch.y = 30
			
			infoView = new InfoView(bg.width, 150);
			containerSearch.addChild(infoView);
			infoView.visible = false;
			infoView.x = -10;
			infoView.y = bg.height;
			infoView.addEventListener(StringEvent.CHANGE_VALUE, initOrgView);
			infoView.addEventListener(CommonEvent.CLOSE_ORGLIST, closeOrgList);

			optionButton = new SingleButtonIco("assets/buttons/options2");
			addChild(optionButton);
			optionButton.scaleX = 0.9;
			optionButton.scaleY = 0.9;
			optionButton.x = containerSearch.x + 10;
			
			//
			stateCamButton = new ToggleButton("assets/buttons/cameraLock2", "assets/buttons/cameraUnLock2");//standardCam
			addChild(stateCamButton);
			stateCamButton.scaleX = 0.9;
			stateCamButton.scaleY = 0.9;
			stateCamButton.x = bgCam.x - 41;
			
			//
			walkCamButton = new SingleButtonIco("assets/buttons/walkCam2");
			addChild(walkCamButton);
			walkCamButton.scaleX = 0.9;
			walkCamButton.scaleY = 0.9;
			walkCamButton.x = bgWalkCam.x - 30;
		
			containerSearch.addEventListener(MouseEvent.ROLL_OUT, onOut);
			containerSearch.addEventListener(MouseEvent.ROLL_OVER, onOver);
			//if(currentViewModeButton == null)currentViewModeButton = null

		}
		
		protected function optionButtonPress(event:MouseEvent):void {
			dispatchEvent(new CommonEvent(CommonEvent.OPTION_BUTTON_PRESS));
			
		}
		/*private function createBG():Sprite{
			var sprite:GraphicElement = new GraphicElement(50, 50, 0xA6A6A6, 15, 15);
			//addChild(sprite);
			//bgOption.x = bgOption.width;
			//bgOption.y = -20
				return sprite;
		}*/
		public function buttonDisable():void {
			if(currentViewModeButton != null){
				previousViewModeButton = currentViewModeButton;
				currentViewModeButton.mouseEnabled = false;
				currentViewModeButton.mouseChildren = false;
			}
		}
		public function buttonEnable():void {
			if(previousViewModeButton != null){
				previousViewModeButton.mouseEnabled = true;
				previousViewModeButton.mouseChildren = true;
			}
			
		}
		protected function stateCamInit(event:MouseEvent):void {
			currentViewModeButton = event.currentTarget;
			//dispatchEvent(new CommonEvent(CommonEvent.STANDARD_CAM));
			stateCamButton.clickButton();
			
		}
		
		protected function walkCamInit(event:MouseEvent):void {
			currentViewModeButton = event.currentTarget;
			dispatchEvent(new CommonEvent(CommonEvent.WALK_CAM));
			
		}
		
		protected function freeCamInit(event:MouseEvent):void {
			currentViewModeButton = event.currentTarget;
			dispatchEvent(new CommonEvent(CommonEvent.FREE_CAM));
			
		}
		
		protected function closeOrgList(event:CommonEvent):void {
			if(orgView != null){
				containerSearch.removeChild(orgView);
				orgView = null;
				//infoView.flag = false;
				//listOrg = null;
			}
		}
		
		protected function initOrgView(e:StringEvent):void {
			//получение данных по адресу здания и отправление их в класс OrgView
			if("Дианова, 8" == e.value){

				var comboData:Array = new Array( 
					{label:"Гирутек, Медицинский центр", item1:"Гирудотерапия, Услуги невролога, Очищение организма, Центиры альтернативной медицины, Медицинские лаборатории", item2:"(3812)90 - 73 - 49", item3:"www.girutek.ru"}, 
					{label:"Диана, салон прически", item1:"Парикмахерские, Ногтевые студии, Студии загара", item2:"(3812)75 - 42 - 23", item3:""},
					{label:"Пчелка, сеть магазинов", item1:"Продукты пчеловодства", item2:"(3812)26 - 59 - 48\n(3812)72 - 11 - 72", item3:""},
					{label:"Семейная, сеть аптек", item1:"Аптеки", item2:"(3812)781 - 031", item3:"www.apteka-omsk.ru"},
					{label:"Центр-книга, сеть магазинов", item1:"Книги, учебная литература", item2:"(3812)72 - 03 - 05", item3:"www.omskbook.ru"},
					{label:"SunRise, оптика", item1:"Аптеки", item2:"(3812)71 - 76 - 97", item3:""}
				); 	
			}
			if("Лесной проезд, 4" == e.value){
				var comboData:Array = new Array( 
					{label:"Выгодный, супермаркет", item1:"Супермаркеты", item2:"(3812)78 - 11 - 66", item3:""}, 
					{label:"Позитив, агенство недвижимости", item1:"Агентства недвижимости, Оформление недвижимости, Помощь в оформлении ипотеки", item2:"(3812)340 - 640", item3:""},
					{label:"Flip, торгово-сервисный центр", item1:"Мобильные телефоны, Аксессуары к мобильным телефонам, Ремонт мобильных устройств связи", item2:"8 - 962 - 031 - 74 - 47", item3:""},
					{label:"Олимпия, подростково-молодежный клуб", item1:"Детски/Подростковые клубы", item2:"(3812)73 - 29 - 64", item3:""},
					{label:"Next, сеть школ современного танца", item1:"Танцевальные школы", item2:"8 - 913 - 964 - 08 - 11", item3:"www.next.ucoz.ru"},
					{label:"Мир женщины, библиотека", item1:"Библиотеки", item2:"(3812)73 - 35 - 88", item3:"www.lib.omsk.ru"}
				); 	
			}
			if("Дианова, 14" == e.value){
				var comboData:Array = new Array( 
					{label:"АТ-Маркет, торговый центр", item1:"Торгово-развлекательные центры/Моллы", item2:"(3812)29 - 16 - 99", item3:"www.at-market.ru"}, 
					{label:"Атмосфера, кинотеатр", item1:"Кинотеатры", item2:"(3812)90 - 14 - 40\n(3812)660 - 900", item3:"www.at-kino.ru"}, 
					{label:"Баловень, магазин мужских сорочек", item1:"Мужская одежда", item2:"", item3:""},
					{label:"Банкомат, АКБ Абсолют Банк, ЗАО", item1:"Банкоматы", item2:"", item3:""},
					{label:"Банкомат, БИНБАНК, ОАО", item1:"Банкоматы", item2:"", item3:""},
					{label:"Банкомат, Мастер-Банк, ОАО", item1:"Банкоматы", item2:"", item3:""},
					{label:"Белорусская косметика, сеть магазинов", item1:"Косметика, Парфюмерия", item2:"(3812)33 - 22 - 56", item3:""},
					{label:"Билайн, сеть центров обслуживания", item1:"Мобильные телефоны, Аксессуары к мобильным телефонам, Фототовары, Аудио/Видео техника", item2:"(3812)24 - 77 - 17", item3:""},
					{label:"Быстро-пицца косметика, кафе, Левый берег", item1:"Кафе/Рестораны быстрого питаня, Доставка готовых блюд", item2:"(3812)633 - 623", item3:"www.bistropizza55.ru"},
					{label:"Ваше сиятельство, сеть ювелирных салонов", item1:"Ювилирные изделия, Ремонт/Изготовление ювелирных изделий", item2:"(3812)38 - 45 - 14\n(3812)38 - 69 - 15", item3:""},
					{label:"ДНС, цифровой супермаркет", item1:"Компьютеры/Комплектующие, Оргтехника, Фототовары, Мобильные телефоны, Видео/Аудио техника", item2:"(3812)66 - 55 - 88", item3:"www.dns-shop.ru"}
				); 	
			}
			if("Дианова, 7/1" == e.value){
				var comboData:Array = new Array( 
					{label:"Банкомат, Сбербанк России, ОАО", item1:"Банкоматы", item2:"", item3:""}, 
					{label:"Империя-Омск-Сервис, ООО", item1:"ЛДСП / ДВПО / МДФ, Изготовление мебели под заказ, Мебель корпусная, Мебель для кухни", item2:"(3812)51 - 87 - 75", item3:"www.imp-omsk-servis.ucoz.ru"},
					{label:"Ломбард Ларго, ООО", item1:"Ломбарды", item2:"34 - 99 - 24", item3:""},
					{label:"Медуника, сеть аптек", item1:"Аптеки", item2:"(3812)72 - 11 - 68", item3:"www.medunika.ru"},
					{label:"Милара, ателье", item1:"Ателье швейные, Ателье меховые / кожаные", item2:"8 - 913 - 623 - 53 - 41", item3:""},
					{label:"Холди, дискаунтер", item1:"Супермаркет", item2:"(3812)71 - 94 - 66", item3:"www.hol-omsk.ru"}
				); 	
			}
			if("Дианова, 3/1" == e.value){
				var comboData:Array = new Array( 
					{label:"АЛЬКОМ, ООО", item1:"Компьютеры, Комплектующие, Оргтехника, Ремонт компьютеров, Заправка картриджей, Ремонт оргтехники", item2:"(3812)308 - 309\n(3812)309 - 308", item3:"www.alcom55.ru"}, 
					{label:"Акцент-Омск, ООО", item1:"Автозапчасти для отечественных автомобилей, Автозапчасти для иномарок, Автохимия, Масла", item2:"(3812)33 - 06 - 15", item3:""},
					{label:"Альянс, ООО, мебельная фирма", item1:"Изготовление мебели под заказ, ЛДСП, ДВПО, МДФ, Мебель офисная, Мебель для кухни, Мебельные фасады", item2:"49 - 48 - 38", item3:""},
					{label:"Банкомат, Альфа-Банк, ОАО", item1:"Банкоматы", item2:"", item3:""},
					{label:"Барбара, фитнес-клуб", item1:"Фитнес-клуб", item2:"380 - 777\n(3812)49 - 31 - 36", item3:"www.barbarafitness.ru"},
					{label:"Вестфалика, сеть магазинов", item1:"Магазины обувные", item2:"(3812)33 - 06 - 14", item3:"www.obuvrus.ru"},
					{label:"Домовой, мебельная компания", item1:"ЛДСП / ДВПО / МДФ, Изготовление мебели под заказ, Мебель корпусная, Мебель для кухни, Мебель офисная", item2:"(3812)33 - 06 - 21", item3:"www.domovoy-omsk.ru"},
					{label:"Лето, торговый комплекс", item1:"Торговые центры", item2:"(3812)33 - 06 - 20", item3:""}
				); 	
			}
			if("Дианова, 1" == e.value){
				var comboData:Array = new Array( 
					{label:"Аптечный пункт, ООО Алали", item1:"Аптеки", item2:"", item3:""}, 
					{label:"Банкомат, Альфа-Банк, ОАО", item1:"Банкоматы", item2:"", item3:""},
					{label:"Банкомат, Сбербанк России, ОАО", item1:"Банкоматы", item2:"", item3:""}, 
					{label:"Банкомат, Альфа-Банк, ОАО", item1:"Банкоматы", item2:"", item3:""},
					{label:"Банкомат, БИНБАНК, ОАО", item1:"Банкоматы", item2:"", item3:""},
					{label:"Европа, сеть автомагазинов", item1:"Автозапчасти для иномарок, Автоаксессуары, Контрактные автозапчасти, Автохимия, Масла", item2:"(3812)38 - 78 - 46", item3:"www.z-onlain.ru"},
					{label:"Криад, ООО, магазин", item1:"Мужская одежда", item2:"8 - 913 - 679 - 06 - 91", item3:""}
				); 	
			}
			if("Дианова, 7б" == e.value){
				var comboData:Array = new Array( 
					{label:"Клинический кожно-венерологический диспансер", item1:"Диспансер, Услуги дерматовенеролога, Услуги трихолога, Медицинские лаборатории", item2:"(3812)73 - 03 - 79\n(3812)73 - 28 - 33\n(3812)73 - 27 - 06", item3:"www.omsk-okvd.ru"}, 
					{label:"Наркологический кабинет", item1:"Диспансер", item2:"(3812)73 - 36 - 76", item3:""},
					{label:"Фармари, сеть аптек", item1:"Аптеки", item2:"", item3:""}
				); 	
			}
			if("Дианова, 7в" == e.value){
				var comboData:Array = new Array( 
					{label:"Банкомат, Сбербанк России, ОАО", item1:"Банкоматы", item2:"", item3:""}, 
					{label:"Почтовое отделение №106", item1:"Почтовые отделения", item2:"(3812)73 - 29 - 36\n(3812)73 - 36 - 51\n(3812)73 - 28 - 75", item3:""},
					{label:"Сбербанк России, ОАО", item1:"Банки, Кассы обмена валют", item2:"8 - 800 - 555 - 55 - 50", item3:"www.sbrf.ru"}
				); 	
			}
			if("Дианова, 7г" == e.value){
				var comboData:Array = new Array( 
					{label:"Ателье, ИП Шурова В.А.", item1:"Ателье швейные", item2:"8 - 965 - 975 - 68 - 41", item3:""}, 
					{label:"Для вас, продовольственный комплекс", item1:"Универсальные магазины", item2:"(3812)59 - 55 - 72", item3:""},
					{label:"Омское лекарство, ОАО", item1:"Сеть аптек", item2:"(3812)23 - 15 - 92\n(3812)73 - 28 - 52\n(3812)73 - 36 - 58", item3:""}
				); 	
			}
			if("Волгоградская, 30б" == e.value){
				var comboData:Array = new Array( 
					{label:"Магнит, федеральная сеть магазинов", item1:"Супермаркеты", item2:"(3812)73 - 23 - 37", item3:"www.magnit-info.ru"}, 
					{label:"Дебют, парикмахерская", item1:"Парикмахерские, Студии загара, Ногтевые студии", item2:"(3812)73 - 23 - 37", item3:""}
				); 	
			}
			if("Волгоградская, 32а" == e.value){
				var comboData:Array = new Array( 
					{label:"Магнит, федеральная сеть магазинов", item1:"Супермаркеты", item2:"(3812)73 - 23 - 37", item3:"www.magnit-info.ru"}, 
					{label:"Ателье на Волгоградской", item1:"Ателье швейные", item2:"8 - 908 - 795 - 51 - 26", item3:""}
				); 	
			}
			if("Фугенфирова, 3" == e.value){
				var comboData:Array = new Array( 
					{label:"Леприкон, банкетный зал", item1:"Банкетные залы", item2:"(3812)38 - 05 - 08", item3:""}, 
					{label:"Омское лекарство, ОАО", item1:"Аптеки", item2:"(3812)23 - 15 - 92", item3:""},
					{label:"Сибириада, сеть народных супермаркетов", item1:"Супермаркеты", item2:"(3812)72 - 01 - 68", item3:"www.hol-omsk.ru"}
				); 	
			}
			if("Фугенфирова, 5" == e.value){
				var comboData:Array = new Array( 
					{label:"Банкомат, Сбербанк России, ОАО", item1:"Банкоматы", item2:"", item3:""}, 
					{label:"Итальянская химчистка, ИП Галеева Р.А.", item1:"Химчистки одежды, Чистка/Рестоврация пухо-перьевых изделий", item2:"(3812)38 - 79 - 14", item3:""},
					{label:"Ларчик, ООО, ломбард", item1:"Ломбард", item2:"", item3:""},
					{label:"На Фугенфирова, торговый комплекс", item1:"Универсальные магазины", item2:"(3812)75 - 59 - 76", item3:""},
					{label:"Ниточка, сеть магазинов", item1:"Пряжа, Швейная фурнитура, Швейное оборудование, Товары для творчества и рукоделия", item2:"8 - 965 - 974 - 68 - 49", item3:"www.nitochka.tiu.ru"}
				); 	
			}
			if("Фугенфирова, 7" == e.value){
				var comboData:Array = new Array( 
					{label:"Главный, центр полиграфических и фотоуслуг", item1:"Фототовары, Фотоцентры, Фото на документы, Термопечать, Широкоформатная / УФ-печать", item2:"8 - 913 - 649 - 88 - 80", item3:"www.omskfoto.ucoz.ru"}, 
					{label:"Ломбард, Иволга, сеть ломбардов", item1:"Ломбарды", item2:"(3812)70 - 23 - 97", item3:""},
					{label:"Салон-парикмахерская, ИП Абрамян О.В.", item1:"Парикмахерские, Ногтевые студии", item2:"8 - 908 - 108 - 08 - 42", item3:""}
				); 	
			}
			
			if("Лукашевича, 4" == e.value){
				var comboData:Array = new Array( 
					{label:"Ростелеком, ОАО, Омский филиал", item1:"Операторы кабельного телевидения, Услуги телефонной связи, IP-телефония, Интернет-провайдеры", item2:"8 - 800 - 100 - 08 - 00", item3:"www.rt.ru"}
				); 	
			}
			if("Лукашевича, 8б" == e.value){
				var comboData:Array = new Array( 
					{label:"Магнит, федеральная сеть магазинов", item1:"Супермаркеты", item2:"(3812)73 - 23 - 37", item3:"www.magnit-info.ru"}
				); 	
			}
			if("Лукашевича, 10б" == e.value){
				var comboData:Array = new Array( 
					{label:"Магнит, федеральная сеть магазинов", item1:"Супермаркеты", item2:"(3812)73 - 23 - 37", item3:"www.magnit-info.ru"}
				); 	
			}
			
			if("Лесной проезд, 11" == e.value){
				var comboData:Array = new Array( 
					{label:"Оазис, торговый комплекс", item1:"Торговые центры, Аренда помещений", item2:"(3812)722 - 127\n(3812)722 - 129\n(3812)722 - 124", item3:"www.oazis55.ru"},
					{label:"Аптечный пункт, ООО Алали", item1:"Аптеки", item2:"", item3:""},
					{label:"АЛЬКОМ, ООО", item1:"Компьютеры, Комплектующие, Оргтехника, Ремонт компьютеров, Заправка картриджей, Ремонт оргтехники", item2:"(3812)308 - 309\n(3812)309 - 308", item3:"www.alcom55.ru"}, 
					{label:"Акцент-Омск, ООО", item1:"Автозапчасти для отечественных автомобилей, Автозапчасти для иномарок, Автохимия, Масла", item2:"(3812)33 - 06 - 15", item3:""},
					{label:"Банкомат, Альфа-Банк, ОАО", item1:"Банкоматы", item2:"", item3:""},
					{label:"Банкомат, Сбербанк России, ОАО", item1:"Банкоматы", item2:"", item3:""}, 
					{label:"Банкомат, Альфа-Банк, ОАО", item1:"Банкоматы", item2:"", item3:""},
					{label:"Банкомат, БИНБАНК, ОАО", item1:"Банкоматы", item2:"", item3:""}
				); 	
			}
			orgView = new OrgView(comboData, bg.width, 150);
			orgView.x = -10;
			orgView.y = infoView.y + infoView.height-20;
			containerSearch.addChildAt(orgView, containerSearch.getChildIndex(infoView));	
			/*var txt:String  = "<span class='defaultStyle'><h1><b>"+""+e.value+""+"</b></h1></span>"
			orgView = new OrgView(txt, bg.width, 150);
			orgView.x = -10;
			orgView.y = infoView.y + infoView.height-20;
			addChildAt(orgView, getChildIndex(infoView));
			*/
		}
		
		protected function onOut(event:MouseEvent):void{
			dispatchEvent(new CommonEvent(CommonEvent.ROLLOUTITEM));
			if(scroller != null){
				moveInfoList();
				
				if(comboList.height < 150)TweenMax.to(scroller, 0.5, { y:-scroller.height+35, onComplete:onFinishState } );//65 - было 35
				else
					TweenMax.to(scroller, 0.5, { y:-heghtScrollBox+HEIGHT_BG, onComplete:onFinishState } );

				comboList.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			}
			
		}
		public function txtEnabled():void{
			mouseChildren = true;
			mouseEnabled = true;
			//stage.focus = txt;
		}
		public function txtDisabled():void{ 
			mouseChildren = false;
			mouseEnabled = false;
		}
			
		private function focusKill(e:FocusEvent=null):void{
			if(txt.text.length <= 0 ){
				txt.text = "Поиск ";
			}
		}
		
		private function removeObject(e:TimerEvent):void {
			timer.stop();
			if(comboList.height < 150)TweenMax.to(scroller, 0.5, { y:-scroller.height, onComplete:onFinishState } );
			else
				TweenMax.to(scroller, 0.5, { y:-heghtScrollBox, onComplete:onFinishState } );
		}
		
		private function onFinishState():void{

			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			comboList.removeEventListener(MouseEvent.ROLL_OUT, onOut);
		}
		private function changeText(e:Event):void{
			comboList.checkText = txt.text; //проверка введенных символов на наличие их в массиве
			if(scroller != null){
				containerSearch.removeChild(scroller);
				scroller = null;
				comboList.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			}

			//если текстовое поле содержит меньше 1 символа, то элементы удоляются
			if(txt.text.length < 1 || comboList.searchStatus != 0){
				this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				infoView.y = HEIGHT_BG;
				if(orgView != null)orgView.y = infoView.y + infoView.height-HEIGHT_BG;

				TweenMax.killAll();
				check = false;

				if(scroller != null){
					containerSearch.removeChild(scroller);
					scroller = null;
					
					comboList.removeEventListener(MouseEvent.ROLL_OUT, onOut);
				}
			} else {//если введенные символы не найдены в массиве, то ничего не делаем
				comboList.j = 0;//сброс смещения элементов
				comboList.createElement(txt.text);//создание экземпляра и передача имени
				
				
				if(comboList.height < 150){
					heghtScrollBox = comboList.height;
				}else{
					heghtScrollBox = 150;
				}
					scroller = new ScrollBoxMenu(comboList, heghtScrollBox);
					containerSearch.addChildAt(scroller, containerSearch.getChildIndex(bg));
					scroller.x = comboList.width-8;//offsetGraphic.x-2//
					scroller.y = -heghtScrollBox;//offsetGraphic.height-10//
					
					TweenMax.killAll();
					TweenMax.to(scroller, 0.3, { y:HEIGHT_BG, onComplete:onFinishState } );
					moveInfoList();
			}
		}
		
		private function moveInfoList():void {
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(event:Event):void {
			
			if(comboList.height < 150){
				infoView.y = scroller.y+scroller.height-5;
				if(orgView != null)orgView.y = infoView.y+infoView.height-HEIGHT_BG;
			}else if(scroller != null){
				infoView.y = scroller.y+149;
				if(orgView != null)orgView.y = scroller.y+infoView.height+130	
				}else{
					infoView.y = HEIGHT_BG;
					//orgView.y = infoView.y+infoView.height-30
			}
		}
		
		protected function onOver(event:MouseEvent):void {
			dispatchEvent(new CommonEvent(CommonEvent.ROLLOVERITEM));
			if(scroller != null){
				TweenMax.to(scroller, 0.3, { y:HEIGHT_BG } );
				moveInfoList();
			}
		}
		public function setArray(objectMesh:Array/*Mesh*/):void{

			if(comboList != null)comboList = null;
			comboList = new ComboList(objectMesh);
			comboList.addEventListener(CheckInfoEvent.CHECK, checkInfo);
			comboList.addEventListener(MeshEvent.SEARCH_ID_ITEM, changeItem);
		}
		
		protected function changeItem(e:MeshEvent):void{
			
			setInfo(e.value.name)
			
		}
		
		public function visibleInfo():void {
			infoView.visible = true;
			
		}
		public function setInfo(ObjectName:String):void {
			infoView.setText(ObjectName)
			infoView.flag = false;
			//trace(e.value.name)
			if(orgView != null)containerSearch.removeChild(orgView),orgView = null
			if (ObjectName.toString().toLowerCase().indexOf("^") != -1){
				infoView.visibleOrgButtonOn();
			}else{
				infoView.visibleOrgButtonOff();
				//infoView.flag = false;
				if(orgView != null)containerSearch.removeChild(orgView),orgView = null
			}
			
		}
		
		protected function checkInfo(event:Event):void {
			check = true
			
		}
		
		protected static function downItem(event:CommonEvent):void{
			timer.start();
			
		}

		private function focusIn(e:FocusEvent):void {
			txt.mouseDown();
			if(txt.text.length < 1 || txt.text == "Поиск "){
				txt.text = "";
			}	
		}
		public function updateWidth(initWidth:Number):void {
			txt.updateXY(60, initWidth-5);
		}
		
	}//class
}//package