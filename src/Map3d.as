package {
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.core.View;
	import alternativa.engine3d.core.events.MouseEvent3D;
	import alternativa.engine3d.lights.AmbientLight;
	import alternativa.engine3d.lights.DirectionalLight;
	import alternativa.engine3d.loaders.ParserA3D;
	import alternativa.engine3d.materials.TextureMaterial;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.objects.SkyBox;
	import alternativa.engine3d.objects.Sprite3D;
	import alternativa.engine3d.primitives.Plane;
	import alternativa.engine3d.resources.BitmapTextureResource;
	import alternativa.engine3d.resources.ExternalTextureResource;
	import alternativa.engine3d.shadows.DirectionalLightShadow;
	
	import components.CameraController;
	import model.MaterialWater;
	import components.OptionMenu;
	import components.objects.RoadMesh;
	import components.objects.WorldOptimizedMesh;
	
	import controls.WalkController;
	import controls.ManagerControls;
	
	import eu.nekobit.alternativa3d.core.renderers.NekoRenderer;
	import eu.nekobit.alternativa3d.materials.WaterMaterial;
	import eu.nekobit.alternativa3d.post.PostEffectRenderer;
	import eu.nekobit.alternativa3d.post.effects.Bloom;
	import eu.nekobit.alternativa3d.post.effects.DepthOfField;
	import eu.nekobit.alternativa3d.post.effects.OuterGlow;
	
	import events.CheckBoxEvent;
	import events.CommonEvent;
	import events.MeshEvent;
	import events.OneNumberEvent;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.NativeWindow;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class Map3d extends Sprite {
		
		private const RESOURCE_LIMIT_ERROR_ID:int = 3691;
		
		private var scene:Object3D = new Object3D();
		private var cameraContainer:Object3D = new Object3D();
		private var plants:Object3D = new Object3D();
		private var sign:Object3D;
		
		private var camera:Camera3D;
		private var controller:CameraController;
		private var directionalLight:DirectionalLight;
		private var shadow:DirectionalLightShadow;
		private var stage3D:Stage3D;
		
		private var world:Mesh;
		
		/**
		 * SKYBOX
		 * */
		private var skyBox:SkyBox;
		[Embed(source = "assets/skybox/left.jpg")] static private const left_t_c:Class;
		private var left_t:BitmapTextureResource = new BitmapTextureResource(new left_t_c().bitmapData);
		[Embed(source = "assets/skybox/right.jpg")] static private const right_t_c:Class;
		private var right_t:BitmapTextureResource = new BitmapTextureResource(new right_t_c().bitmapData);
		[Embed(source = "assets/skybox/top.jpg")] static private const top_t_c:Class;
		private var top_t:BitmapTextureResource = new BitmapTextureResource(new top_t_c().bitmapData);
		[Embed(source = "assets/skybox/bottom.jpg")] static private const bottom_t_c:Class;
		private var bottom_t:BitmapTextureResource = new BitmapTextureResource(new bottom_t_c().bitmapData);
		[Embed(source = "assets/skybox/front.jpg")] static private const front_t_c:Class;
		private var front_t:BitmapTextureResource = new BitmapTextureResource(new front_t_c().bitmapData);
		[Embed(source = "assets/skybox/back.jpg")] static private const back_t_c:Class;
		private var back_t:BitmapTextureResource = new BitmapTextureResource(new back_t_c().bitmapData);

		/**
		 * Загрузка ресурсов: Архитектура(динамичные элементы, имеющие свой индекс)
		 * */
		
		[Embed(source="data/objects3d/map_house.a3d", mimeType="application/octet-stream")]
		private const Model:Class;
		
		/**
		 * Загрузка ресурсов: Ландшафт
		 * */
		
		[Embed(source="data/objects3d/landscape/landshaft.A3D", mimeType="application/octet-stream")]
		private const Landscape:Class;
		
		/**
		 * Загрузка ресурсов: Все виды растительности
		 * */
		
		[Embed(source="data/objects3d/trees.A3D", mimeType="application/octet-stream")]
		private const Trees:Class;
		
		/**
		 * Загрузка ресурсов: Городское освещение
		 * */
		
		[Embed(source="data/objects3d/fonari.A3D", mimeType="application/octet-stream")]
		private const Streetlights:Class;
		
		/**
		 * Загрузка ресурсов: Текстуры
		 * Развертки архитектуры
		 * */
		
		[Embed(source="assets/skin/texture18.jpg")]
		private const Texture_1:Class;
		[Embed(source="assets/skin/texture2.jpg")]
		private const Texture_2:Class;
		[Embed(source="assets/skin/texture10.jpg")]
		private const Texture_3:Class;
		[Embed(source="assets/skin/texture16.jpg")]
		private const Texture_4:Class;
		[Embed(source="assets/skin/texture3.jpg")]
		private const Texture_5:Class;
		[Embed(source="assets/skin/texture13.jpg")]
		private const Texture_6:Class;
		[Embed(source="assets/skin/texture7.jpg")]
		private const Texture_7:Class;
		[Embed(source="assets/skin/texture5.jpg")]
		private const Texture_8:Class;
		[Embed(source="assets/skin/texture15.jpg")]
		private const Texture_9:Class;
		[Embed(source="assets/skin/texture9.jpg")]
		private const Texture_10:Class;
		[Embed(source="assets/skin/texture4.jpg")]
		private const Texture_11:Class;
		[Embed(source="assets/skin/texture17.jpg")]
		private const Texture_12:Class;
		[Embed(source="assets/skin/texture6.jpg")]
		private const Texture_13:Class;
		[Embed(source="assets/skin/texture14.jpg")]
		private const Texture_14:Class;
		[Embed(source="assets/skin/texture12.jpg")]
		private const Texture_15:Class;
		[Embed(source="assets/skin/texture8.jpg")]
		private const Texture_16:Class;
		[Embed(source="assets/skin/texture11.jpg")]
		private const Texture_17:Class;
		[Embed(source="assets/skin/texture19.jpg")]
		private const Texture_19:Class;
		[Embed(source="assets/skin/texture20.jpg")]
		private const Texture_20:Class;
		[Embed(source="assets/skin/texture21.jpg")]
		private const Texture_21:Class;
		
		[Embed(source="assets/skin/texture2_nor_2.jpg")]
		private const Texture_18:Class;
		
		//Building Specular
		[Embed(source="assets/skin/amb_specular.jpg")]
		private const Texture_2_Specular:Class;
		[Embed(source="assets/skin/amb_specular_dark.jpg")]
		private const Texture_2_Specular_Dark:Class;
		
		// NormalMap
		//Active Buildings
		[Embed(source="assets/skin/texture2_normal.jpg")]
		private const Texture2_normal:Class;
		[Embed(source="assets/skin/texture3_normal.jpg")]
		private const Texture3_normal:Class;
		[Embed(source="assets/skin/texture4_normal.jpg")]
		private const Texture4_normal:Class;
		[Embed(source="assets/skin/texture5_normal.jpg")]
		private const Texture5_normal:Class;
		[Embed(source="assets/skin/texture6_normal.jpg")]
		private const Texture6_normal:Class;
		[Embed(source="assets/skin/texture7_normal.jpg")]
		private const Texture7_normal:Class;
		[Embed(source="assets/skin/texture8_normal.jpg")]
		private const Texture8_normal:Class;
		[Embed(source="assets/skin/texture9_normal.jpg")]
		private const Texture9_normal:Class;
		[Embed(source="assets/skin/texture10_normal.jpg")]
		private const Texture10_normal:Class;
		[Embed(source="assets/skin/texture11_normal.jpg")]
		private const Texture11_normal:Class;
		[Embed(source="assets/skin/texture12_normal.jpg")]
		private const Texture12_normal:Class;
		[Embed(source="assets/skin/texture13_normal.jpg")]
		private const Texture13_normal:Class;
		[Embed(source="assets/skin/texture14_normal.jpg")]
		private const Texture14_normal:Class;
		[Embed(source="assets/skin/texture15_normal.jpg")]
		private const Texture15_normal:Class;
		[Embed(source="assets/skin/texture16_normal.jpg")]
		private const Texture16_normal:Class;
		[Embed(source="assets/skin/texture17_normal.jpg")]
		private const Texture17_normal:Class;
		[Embed(source="assets/skin/texture18_normal.jpg")]
		private const Texture18_normal:Class;
		[Embed(source="assets/skin/texture19_normal.jpg")]
		private const Texture19_normal:Class;
		[Embed(source="assets/skin/texture20_normal.jpg")]
		private const Texture20_normal:Class;		
		[Embed(source="assets/skin/texture21_normal.jpg")]
		private const Texture21_normal:Class;
		
		/**
		 * Загрузка ресурсов: Текстуры
		 * Тайловые текстуры ландшафта и нормали к ним
		 * */
		
		//Landscape Textures
		[Embed(source="assets/landscape/Material.jpg")]
		private const Material:Class;
		[Embed(source="assets/landscape/Materi01.jpg")]
		private const Material1:Class;
		[Embed(source="assets/landscape/Materi02.jpg")]
		private const Material2:Class;
		[Embed(source="assets/landscape/Materi03.jpg")]
		private const Material3:Class;
		[Embed(source="assets/landscape/Materi04.jpg")]
		private const Material4:Class;
		[Embed(source="assets/landscape/Materi05.jpg")]
		private const Material5:Class;
		[Embed(source="assets/landscape/Materi06.jpg")]
		private const Material6:Class;
		[Embed(source="assets/landscape/Materi07.jpg")]
		private const Material7:Class;
		[Embed(source="assets/landscape/Materi08.jpg")]
		private const Material8:Class;
		[Embed(source="assets/landscape/Materi09.jpg")]
		private const Material9:Class;
		[Embed(source="assets/landscape/Materi10.jpg")]
		private const Material10:Class;
		[Embed(source="assets/landscape/Materi11.jpg")]
		private const Material11:Class;
		[Embed(source="assets/landscape/Materi12.jpg")]
		private const Material12:Class;
		[Embed(source="assets/landscape/Materi13.jpg")]
		private const Material13:Class;
		[Embed(source="assets/landscape/Materi14.jpg")]
		private const Material14:Class;
		[Embed(source="assets/landscape/Materi15.jpg")]
		private const Material15:Class;
		[Embed(source="assets/landscape/Materi16.jpg")]
		private const Material16:Class;
		[Embed(source="assets/landscape/Materi17.jpg")]
		private const Material17:Class;
		[Embed(source="assets/landscape/Materi18.jpg")]
		private const Material18:Class;
		[Embed(source="assets/landscape/Materi19.jpg")]
		private const Material19:Class;
		[Embed(source="assets/landscape/Materi20.jpg")]
		private const Material20:Class;
		[Embed(source="assets/landscape/Materi21.jpg")]
		private const Material21:Class;
		[Embed(source="assets/landscape/Materi22.jpg")]
		private const Material22:Class;
		[Embed(source="assets/landscape/Materi23.jpg")]
		private const Material23:Class;
		[Embed(source="assets/landscape/road.jpg")]
		private const Material_Road:Class;
		[Embed(source="assets/landscape/_Fencing.jpg")]
		private const Material_Fencing:Class;
		[Embed(source="assets/landscape/_Fencing.jpg")]
		private const Material_Fencing_:Class;
		[Embed(source="assets/landscape/Brick_An.jpg")]
		private const Brick_An:Class;
		[Embed(source="assets/landscape/_Brick_A.jpg")]
		private const _Brick_A:Class;
		
		[Embed(source="assets/landscape/Materi07_specular.jpg")]
		private const Material7_Specular:Class;
		[Embed(source="assets/landscape/Materi09_specular.jpg")]
		private const Material9_Specular:Class;
		[Embed(source="assets/landscape/Materi15_specular.jpg")]
		private const Material15_Specular:Class;

		//Grass
		[Embed(source="assets/plants/shr15.jpg")]
		private const Grass:Class;
		[Embed(source="assets/plants/shr15_op.jpg")]
		private const Grass_Op:Class;
		[Embed(source="assets/plants/shr15_normal.jpg")]
		private const Grass_Normal:Class;
		
		//Normal maps
		[Embed(source="assets/landscape/Material_normal.jpg")]
		private const Material_normal:Class;
		[Embed(source="assets/landscape/Materi01_normal3.jpg")]
		private const Material01_normal:Class;
		/*[Embed(source="assets/landscape/Materi02_normal.jpg")]
		private const Material02_normal:Class;*/
		[Embed(source="assets/landscape/Materi03_normal.jpg")]
		private const Material03_normal:Class;
		[Embed(source="assets/landscape/Materi04_normal.jpg")]
		private const Material04_normal:Class;
		[Embed(source="assets/landscape/Materi05_normal.jpg")]
		private const Material05_normal:Class;
		[Embed(source="assets/landscape/Materi06_normal.jpg")]
		private const Material06_normal:Class;
		[Embed(source="assets/landscape/Materi07_normal.jpg")]
		private const Material07_normal:Class;
		[Embed(source="assets/landscape/Materi08_normal.jpg")]
		private const Material08_normal:Class;
		[Embed(source="assets/landscape/Materi09_normal.jpg")]
		private const Material09_normal:Class;
		[Embed(source="assets/landscape/Materi10_normal.jpg")]
		private const Material10_normal:Class;
		[Embed(source="assets/landscape/Materi11_normal.jpg")]
		private const Material11_normal:Class;
		[Embed(source="assets/landscape/Materi12_normal.jpg")]
		private const Material12_normal:Class;
		[Embed(source="assets/landscape/Materi13_normal.jpg")]
		private const Material13_normal:Class;
		[Embed(source="assets/landscape/Materi14_normal.jpg")]
		private const Material14_normal:Class;
		[Embed(source="assets/landscape/Materi15_normal.jpg")]
		private const Material15_normal:Class;
		[Embed(source="assets/landscape/Materi16_normal.jpg")]
		private const Material16_normal:Class;
		[Embed(source="assets/landscape/Materi17_normal.jpg")]
		private const Material17_normal:Class;
		[Embed(source="assets/landscape/Materi18_normal.jpg")]
		private const Material18_normal:Class;
		[Embed(source="assets/landscape/Materi19_normal.jpg")]
		private const Material19_normal:Class;
		[Embed(source="assets/landscape/Materi20_normal.jpg")]
		private const Material20_normal:Class;
		[Embed(source="assets/landscape/Materi21_normal.jpg")]
		private const Material21_normal:Class;
		[Embed(source="assets/landscape/Materi22_normal.jpg")]
		private const Material22_normal:Class;
		[Embed(source="assets/landscape/Materi23_normal.jpg")]
		private const Material23_normal:Class;
		[Embed(source="assets/landscape/road_normal.JPG")]
		private const Material_road_normal:Class;
		[Embed(source="assets/landscape/Fencing_normal2.jpg")]
		private const Material_fencing_normal:Class;
		[Embed(source="assets/landscape/Brick_An_normal.jpg")]
		private const Brick_An_normal:Class;
		
		/**
		 * Загрузка ресурсов: Текстуры
		 * Развертки деревьев, растений и нормали к ним
		 * */
		
		[Embed(source="assets/plants/grass.jpg")]
		private const Grass2:Class;
		[Embed(source="assets/plants/grass_op.jpg")]
		private const Grass2_Op:Class;
		[Embed(source="assets/plants/grass_normal.jpg")]
		private const Grass2_Normal:Class;

		[Embed(source="assets/plants/tree1.jpg")]
		private const Tree0:Class;
		[Embed(source="assets/plants/tree1_op.jpg")]
		private const Tree0_Op:Class;
		[Embed(source="assets/plants/tree1_normal.jpg")]
		private const Tree0_Normal:Class;
		//
		[Embed(source="assets/plants/tree2.jpg")]
		private const Tree1:Class;
		[Embed(source="assets/plants/tree2_op.jpg")]
		private const Tree1_Op:Class;
		[Embed(source="assets/plants/tree2_normal.jpg")]
		private const Tree1_Normal:Class;
		//
		[Embed(source="assets/plants/tree5.jpg")]
		private const Tree2:Class;
		[Embed(source="assets/plants/tree5_op.jpg")]
		private const Tree2_Op:Class;
		[Embed(source="assets/plants/tree5_normal.jpg")]
		private const Tree2_Normal:Class;
		
		//Изображение при загрузке
		[Embed(source="assets/loadImage_fin.jpg")]
		static private const LoadImage:Class;	
		
		/**
		 * Переменные пост-эффектов
		 * */
		private var bloom:PostEffectRenderer;
		private var glowObject:OuterGlow;
		private var depthEffect:DepthOfField;
		private var bloomEffect:Bloom;
		
		//
		
		private var managerControls:ManagerControls;
		//Упрощенная модель мира для определения столкновений(коллайдер)
		private var worldOptimized:WorldOptimizedMesh;
		//Класс реализующий режим камеры:"своими глазами"
		private var walkController:WalkController;
		
		private var arrMesh:Array = new Array()
		private var arrAddress:Array = new Array();
		private var nonWordChars:Array = [":", "^"];
		private var arrResource:Array = new Array();
		
		private var selectObject:Mesh;

		private var currentCameraZ:Number;
		private var currentCameraX:Number = 0;
		private var currentCameraY:Number = 0;
		private var currentPimpNum:Number = 0;
		private var zoom:int=5000;
		
		private var optionMenu:OptionMenu;
		
		private var standardMode:Boolean = true;
		private var mode:Boolean = false;
		private var bgCurrentSelect:Boolean = false;

		private var txt:TextField;
		private var format:TextFormat;
		
		private var parser:ParserA3D;
		private var hierarchyLength:uint;
		private var roadMesh:RoadMesh;
		private var material:TextureMaterial;
		private var btResource:BitmapTextureResource;

		private var water:MaterialWater;

		private var bmpdata:BitmapData;
		private var loadImage:Bitmap;
		private var bmImageLoad:Bitmap;
		
		private var resolutionX:int = Capabilities.screenResolutionX;
		private var resolutionY:int = Capabilities.screenResolutionY;
			
		public function Map3d(){
			//stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			var window:NativeWindow = stage.nativeWindow;
			window.x = (resolutionX/2) -  640;
			window.y = (resolutionY/2) -  400;
			//stage.frameRate = 24
			
			
			world = new Mesh();
			managerControls = new ManagerControls(-60);
			stage.addChild(managerControls);
			managerControls.txtEnabled();
			managerControls.x = 40;

			managerControls.addEventListener(MeshEvent.SEARCH_ID_ITEM, changeItem);
			managerControls.addEventListener(CommonEvent.ROLLOVERITEM, onRollOverItemOrg);
			managerControls.addEventListener(CommonEvent.ROLLOUTITEM, onRollOutItemOrg);
			managerControls.addEventListener(CommonEvent.TOGGLE_UP, freeCamInit);
			managerControls.addEventListener(CommonEvent.WALK_CAM, walkCamInit);
			managerControls.addEventListener(CommonEvent.TOGGLE_DOWN, standardCamInit);
			managerControls.addEventListener(CommonEvent.OPTION_BUTTON_PRESS, optionButtonPress);
			
			txt = new TextField();
			format = new TextFormat();
			txt.autoSize = TextFieldAutoSize.LEFT;
			//format
			format.font = "Verdana";
			format.color = 0x000000;
			format.size = 46;
			format.bold = true;
			txt.setTextFormat(format);  			
			txt.defaultTextFormat = format;
			
			camera = new Camera3D(1, 40000);
			camera.renderer = new NekoRenderer();
			optionMenu = new OptionMenu();
			//optionMenu.scaleX = 0.9
			//optionMenu.scaleY = 0.9
			/*matrix = new Matrix3D(new <Number>[-0.6691306829452515, -0.7431448101997375, 0, 0, -0.10342574119567871, 0.09312496334314346, -0.9902680516242981, 0, 0.735912561416626, -0.6626186966896057, -0.13917307555675507, 0, -333.00445556640625, 237.38864135742188, 400.38525390625, 1]);
			camera.matrix = matrix;*/ 
			//camera.rotationZ = -0.6632251798678817
			//camera.z = -500;
			camera.view = new View(stage.stageWidth, stage.stageHeight, false, 0, 0, 4);
			camera.view.hideLogo();
			camera.nearClipping = 10;
			addChild(camera.view);
			//addChild(camera.diagram);
			cameraContainer.addChild(camera);
			scene.addChild(cameraContainer);
			
			//Контэйнер для всех спрайт3д материалов отображающих адреса строений
			sign = new Object3D();
			scene.addChild(sign);

			// SSAO
			/*camera.effectMode = Camera3D.MODE_SSAO_COLOR;
			
			camera.ssaoAngular.occludingRadius = 0.7;
			camera.ssaoAngular.secondPassOccludingRadius = 0.32;
			camera.ssaoAngular.maxDistance = 1;
			camera.ssaoAngular.falloff = 7.2;
			camera.ssaoAngular.intensity = 0.85;
			camera.ssaoAngular.secondPassAmount = 0.76;
			camera.ssaoScale = 1;// 0 - высокое качество 1 - низкое
			*/

			scene.addChild(world);
			scene.addChild(plants);

			controller = new CameraController(stage, camera, 400, 10);
			controller.smoothingDelay = 0.7;
			
			stage3D = stage.stage3Ds[0];
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, createMap);
			stage3D.requestContext3D(/*Context3DRenderMode.AUTO*/);

			bmpdata = new BitmapData( 1920, 1080, true, 0 );
			bmImageLoad =  new Bitmap(bmpdata)
			bmImageLoad.smoothing = true;
			bmImageLoad.width = 1280;
			bmImageLoad.height = 768;
			stage.addChild( bmImageLoad );
			loadImage = new LoadImage();
			bmpdata.draw( loadImage );
			
			//Инициализация статической камеры
			stadartCam()
		}
		

		/*private function uploadResources(resources:Vector.<Resource>):void
		{
			for each(var res:Resource in resources)
			{
				if(!res.isUploaded)
				{
					res.upload(stage3D.context3D);
				}				
			}
		}*/
		protected function optionButtonPress(event:CommonEvent):void {
			//if(optionMenu == null) optionMenu = new OptionMenu();
			stage.addChild(optionMenu);
			optionMenu.addEventListener(OneNumberEvent.CLICK_SLIDER_PIMP, clickPimp);
			
			optionMenu.addEventListener(CheckBoxEvent.TOGGLE_CHECKBOX_DOWN, checkboxDown);
			optionMenu.addEventListener(CheckBoxEvent.TOGGLE_CHECKBOX_UP, checkboxUp);
			optionMenu.addEventListener(CommonEvent.BUTTON_ACCEPT, acceptOption);
			optionMenu.x = optionMenu.width/2 + stage.stageWidth/2;
			optionMenu.y = (stage.stageHeight/2)-300;
			controller.disable();
			managerControls.mouseChildren = false;
			managerControls.mouseEnabled = false;
			if(walkController != null)walkController.disable();
			
		}		
		//Событие при нажатии на кнопку "Применить" в настройках, выполняется данный метод
		protected function acceptOption(event:CommonEvent):void {

			controller.enable();
			if(walkController != null)walkController.enable();
			managerControls.mouseChildren = true;
			managerControls.mouseEnabled = true;

			stage.removeChild(optionMenu);
		}
		//Применение свойств настроек
		protected function checkboxUp(e:CheckBoxEvent):void {
			switch (e.value) {
				case "Свечение(Bloom)" :
					bloomEffect = new Bloom();
					bloom.addEffect(bloomEffect);
					break;
				
				case "Глубина(Depth Of Field)" :
					depthEffect = new DepthOfField()
					bloom.addEffect(depthEffect);
					break;
				
				case "Тени" :
					shadow.addCaster(world);
					shadow.addCaster(plants);
					break;
				
				case "Затенение(SSAO)" :
					/*camera.effectMode = Camera3D.MODE_SSAO_COLOR;
					
					camera.ssaoAngular.occludingRadius = 0.7;
					camera.ssaoAngular.secondPassOccludingRadius = 0.32;
					camera.ssaoAngular.maxDistance = 1;
					camera.ssaoAngular.falloff = 7.2;
					camera.ssaoAngular.intensity = 0.85;
					camera.ssaoAngular.secondPassAmount = 0.76;
					camera.ssaoScale = 1;
					*/
					break;
				case "Подпись адреса строения" :
					optionMenu.lockCheck(true, 1);
					setupBGAddress(bgCurrentSelect);
					break;
				
				case "Фон" :
					scene.removeChild(sign);
					sign = null;
					bgCurrentSelect = false;
					setupBGAddress(bgCurrentSelect);
					break;
				
				case "Выделить проезжую часть" :
					addRoad();
					break;
				case "Растительность на карте(Деревья, трава)" :
					addPlants();
					break;
				case "Вода" :
					addWater();
					break;
			}
		}
		
		private function addWater():void {

			water = new MaterialWater(world, stage3D, camera);
			scene.addChild(water);

		}
		
		private function removeRoad():void {
			scene.removeChild(roadMesh);
			roadMesh = null;
			
		}
		
		protected function checkboxDown(e:CheckBoxEvent):void {
		
			switch (e.value) {
				case "Свечение(Bloom)" :
					bloom.removeEffect(bloomEffect);
					break;
				
				case "Глубина(Depth Of Field)" :
					bloom.removeEffect(depthEffect);
					break;
				
				case "Тени" :
					shadow.clearCasters();
					break;
				
				case "Затенение(SSAO)" :
					//
					break;
				
				case "Подпись адреса строения" :
					optionMenu.lockCheck(false, 0.5);
					if(arrResource.length > 0){
						for (var i:uint = 0; i < arrResource.length; i++){
							arrResource[i].dispose();
							arrResource.splice(i--, 1);
						}
						
					}
					break;
				
				case "Фон" :
					scene.removeChild(sign);
					sign = null;
					bgCurrentSelect = true;
					setupBGAddress(bgCurrentSelect);
					break;
				
				case "Выделить проезжую часть" :
					removeRoad();
					break;
				
				case "Растительность на карте(Деревья, трава)" :
					removePlants();
					break;
				case "Вода" :
					removeWater();
					break;
			}
		}
		
		private function removeWater():void {
			//water.dispose();
			scene.removeChild(water);
			water = null;
			
		}
		
		private function addRoad():void {
			roadMesh = new RoadMesh();
			scene.addChild(roadMesh);
			
			for each (var resource:Resource in roadMesh.getResources(true)) {
				resource.upload(stage3D.context3D);
			}
			
		}
		
		//Инициализация подписей адреса, над строениями
		private function setupBGAddress(bg:Boolean):void {
			if(sign == null){
				sign = new Object3D();
				scene.addChild(sign);
			}
				if(arrResource.length > 0){
					for (var i:uint = 0; i < arrResource.length; i++){
						//arrResource[i].disposeTexture()
						arrResource[i].dispose();
						arrResource.splice(i--, 1);
					}
				}
			var bm:BitmapData;
			btResource = new BitmapTextureResource(bm);

			for (var ind:uint = 0; ind < hierarchyLength; ind++) {
				
				arrAddress = arrMesh[ind].name.toString().split(".");
				var txtTemp:String = arrAddress[0];
				
				for(var h:uint = 0; h < nonWordChars.length; h++){
					txtTemp = txtTemp.toString().split(nonWordChars[h]).join("");
				}

				txt.text = txtTemp;
				
				format.leftMargin = 40;//(1024/2) - (txt.width/2); //40
				txt.setTextFormat(format);

				if(txtTemp != "ambient"){
					//определение по условию с фоном или без будут надписи
					bg ? bm = new BitmapData(txt.width+40, 64,true, 0x000000) : bm = new BitmapData(txt.width+40, 64,false, 0xE0E0E0);			

					bm.draw(txt);
					btResource = new BitmapTextureResource(bm, true);//true - произвольный размер битмапы
					
					arrResource.push(btResource);
					material = new TextureMaterial(btResource);
					//material.alphaThreshold = 1
					bg ? material.alphaThreshold = 1 : material.alphaThreshold = 0;

					var sprite:Sprite3D = new Sprite3D(txt.width+40, 64, material);
					sign.addChild(sprite);
					sprite.x = arrMesh[ind].x;
					sprite.y = arrMesh[ind].y;
					sprite.z = arrMesh[ind].z;
					
					//добавление ресурсов в контекст3д
					btResource.upload(stage3D.context3D);
				}
			}
			
		}
		
		protected function clickPimp(e:OneNumberEvent):void {
			currentPimpNum = e.value; 
			camera.farClipping = 40000-((40000/150)*e.value);
		}
		
		
		private function enableMouseWheel():void {
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, wheelHandler);
		}
		
		private function disableMouseWheel():void {
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL, wheelHandler);
		}

		private function wheelHandler(event:MouseEvent):void {	
			if(event.delta > 0){
				if(zoom < 10000)zoom+=550;
				controller.setObjectPosXYZ(controller.getCooX(),controller.getCooY(),zoom);
			}else{
				if(zoom > 3000)zoom-=550;
				controller.setObjectPosXYZ(controller.getCooX(),controller.getCooY(),zoom);
			}
		}
		
		protected function standardCamInit(e:CommonEvent):void {
			if(currentPimpNum == 0){
				camera.farClipping = 40000;
				optionMenu.buttonClipping.slider.moveSlide(0);
			}else{
				camera.farClipping = 40000-((40000/150)*currentPimpNum);
				optionMenu.buttonClipping.slider.moveSlide(200-((200/100)*currentPimpNum));
			}
			stadartCam();
		}
		
		private function stadartCam():void {
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrameWalkCam);
			
			standardMode = true;
			mode = false;

			removeWorldOptimized();
			if(walkController != null){
				cameraContainer.addChild(camera);
				//trace(walkController.getHerocameraX()+" getHero");
				currentCameraX = walkController.getHerocameraX();
				currentCameraY = walkController.getHerocameraY();
			}else{
				currentCameraX = controller.getCooX();
				currentCameraY = controller.getCooY();
			}
			removeHero();

			controller.standardViewModeEnable();
			controller.setObjectPosXYZ(currentCameraX,currentCameraY,5000);

			stage.addEventListener(Event.ENTER_FRAME, onEnterFrameFreeCam);

			zoom = 5000;

			controller.rotationObject = -3.1;//-Math.PI
			controller.unbindKey(69);
			controller.unbindKey(67);
			controller.bindKey(87, "ACTION_UP");
			controller.bindKey(83, "ACTION_DOWN");
			enableMouseWheel();
			managerControls.buttonEnable();			
		}
		
		protected function freeCamInit(event:CommonEvent):void {
			standardMode = false;
			mode = false;
			if(currentPimpNum == 0){
				camera.farClipping = 40000;
				optionMenu.buttonClipping.slider.moveSlide(0);
			}else{
				camera.farClipping = 40000-((40000/150)*currentPimpNum);
				optionMenu.buttonClipping.slider.moveSlide(200-((200/100)*currentPimpNum));
			}

			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrameWalkCam);
			removeWorldOptimized();
			if(walkController != null){
				cameraContainer.addChild(camera)
				currentCameraX = walkController.getHerocameraX();
				currentCameraY = walkController.getHerocameraY();
			}else{
				currentCameraX = controller.getCooX();
				currentCameraY = controller.getCooY();
			}
			removeHero();
			controller.standardViewModeDisable()
			controller.setObjectPosXYZ(currentCameraX,currentCameraY,5000);

			stage.addEventListener(Event.ENTER_FRAME, onEnterFrameFreeCam);
			controller.setDefaultBindings()
			managerControls.buttonEnable();
			disableMouseWheel();
		}
		
		protected function walkCamInit(event:CommonEvent):void {
				shadow.width = 6500;
				shadow.height = 6500;
				shadow.nearBoundPosition = - 4000;
				shadow.farBoundPosition = 2000;
				//shadow.pcfOffset = 0.2;
				stage.removeEventListener(Event.ENTER_FRAME, onEnterFrameFreeCam);
				addWorldOptimized();
				if(currentPimpNum < 70){
					camera.farClipping = 40000-((40000/150)*70);
					optionMenu.buttonClipping.slider.moveSlide(70);
				}
				addHero();

				stage.addEventListener(Event.ENTER_FRAME, onEnterFrameWalkCam);
				managerControls.buttonEnable();
				managerControls.buttonDisable();
				disableMouseWheel();		
		}
		

		private function removeWorldOptimized():void {
			if(worldOptimized != null)worldOptimized = null;
			
		}
		
		protected function onRollOutItemOrg(event:CommonEvent):void {
			controller.enable();
			if(standardMode)enableMouseWheel();
		}
		
		protected function onRollOverItemOrg(event:CommonEvent):void {
			controller.disable();
			disableMouseWheel();
		}		

		private function createMap(event:Event):void {
			stage3D.removeEventListener(Event.CONTEXT3D_CREATE, createMap);
			
			setupModel(Landscape);
			setupModel(Streetlights);
			setupModel(Model);

			addSkyBox();
			setupPlants();
			setupBGAddress(bgCurrentSelect);
			
			var ambientLight:AmbientLight = new AmbientLight(0x333333);
			world.addChild(ambientLight);
			ambientLight.intensity = 2;
			directionalLight = new DirectionalLight(0xFFFF99);
			directionalLight.lookAt(0, 1, -1);//directionalLight.lookAt(0, -1, -1);
			directionalLight.intensity = 1;
			//directionalLight.scaleX = 5
			//directionalLight.scaleY = 5
			world.addChild(directionalLight);
			
			shadow = new DirectionalLightShadow(11500, 11500, -7000, 5000, 2048, 0.8);//1000, 1000, -500, 500 ||| 6500, 6500, -4000, 2000, 2048, 0.5
			shadow.biasMultiplier = .99;
			shadow.addCaster(world);
			shadow.addCaster(plants);

			directionalLight.shadow = shadow;
			//shadow.debug = true;

			stage.addEventListener(Event.RESIZE, onResize);
			onResize();

			bloom = new PostEffectRenderer(stage3D, camera);
			glowObject = new OuterGlow();
			depthEffect = new DepthOfField();
			bloomEffect = new Bloom();
			bloom.addEffect(bloomEffect);
			bloom.addEffect(depthEffect);
			bloom.addEffect(glowObject);
			glowObject.applyGlowToObject(null);

			bmpdata.dispose();
		}
		private function removePlants():void {
			scene.removeChild(plants);
			shadow.removeCaster(plants);
			
		}
		private function addPlants():void {
			scene.addChild(plants);
			shadow.addCaster(plants);
		}
		private function setupPlants():void {
			parser = new ParserA3D();
			parser.parse(new Trees());

			var hierarchyLengthPlants:Number = parser.hierarchy.length;
			for (var ind:uint = 0; ind < hierarchyLengthPlants; ind++) {
				plants.addChild(parser.hierarchy[ind]);
			}

			var materialProcessor:MaterialProcessor = new MaterialProcessor(stage3D.context3D);
			materialProcessor.setupMaterials(parser.objects);
			
			var textureURLMap:Object = createTextureURLMap();
			for each (var textureResource:ExternalTextureResource in scene.getResources(true, ExternalTextureResource)) {

				var textureName:String = getShortTextureName(textureResource.url).toLocaleLowerCase();

				//var isATFTexture:Boolean = textureName.split(".").pop() == "atf";
				try {

					materialProcessor.setupExternalTexture(textureResource, textureURLMap[textureName], false);
				}
				catch (error:Error) {
					if (error.errorID == RESOURCE_LIMIT_ERROR_ID) {
						break;
					} else {
						throw error;
					}
				}
			}
			for each (var resource:Resource in plants.getResources(true)) {
				if(!resource.isUploaded){
					resource.upload(stage3D.context3D);
				}
			}	
		}
		
		private function addWorldOptimized():void {
			worldOptimized = new WorldOptimizedMesh();
			
		}
		
		private function addHero():void {
			currentCameraZ = camera.z;
			if(selectObject != null && mode == true){
				currentCameraX = selectObject.x-1000;
				currentCameraY = selectObject.y-1000;
			}else{
				currentCameraX = controller.getCooX();
				currentCameraY = controller.getCooY();
			}

			var meshObject:Mesh = Mesh(worldOptimized.getChildByName("obj"))
			walkController = new WalkController(camera,new Vector3D(40,40,100), 15, 5, stage, meshObject, currentCameraX, currentCameraY, camera.rotationZ);
			scene.addChild(walkController);
			
			walkController.z = currentCameraZ;
			walkController.x = currentCameraX;
			walkController.y = currentCameraY;	

		}
		private function removeHero():void {
			if(walkController != null){
				shadow.width = 11500;
				shadow.height = 11500;
				shadow.nearBoundPosition = -7000;
				shadow.farBoundPosition = 5000;
				//shadow.pcfOffset = 0.5;
				scene.removeChild(walkController);
				walkController = null;
			}
		}
		
		private function addSkyBox():void {
			skyBox = new SkyBox(100000, 
				new TextureMaterial(left_t), 
				new TextureMaterial(right_t), 
				new TextureMaterial(back_t), 
				new TextureMaterial(front_t), 
				new TextureMaterial(bottom_t), 
				new TextureMaterial(top_t), 0.01);
			skyBox.mouseChildren = false;
			skyBox.mouseEnabled = false;
			scene.addChild(skyBox);
			
			for each (var resource:Resource in skyBox.getResources(true)) {
				resource.upload(stage3D.context3D);
			}
		}
		private function setupModel(arg:Class):void {

			parser = new ParserA3D();
			parser.parse(new arg());

			hierarchyLength = parser.hierarchy.length;
			for (var ind:uint = 0; ind < hierarchyLength; ind++) {
				world.addChild(parser.hierarchy[ind]);
				
				
				if(arg == Model){
					parser.hierarchy[ind].addEventListener(MouseEvent3D.DOUBLE_CLICK, onDoubleClick);
					parser.hierarchy[ind].doubleClickEnabled = true;
					arrMesh.push(parser.hierarchy[ind]);
					
					managerControls.setArray(arrMesh/*parser.hierarchy[ind] as Mesh*/)
				}
			}
			var materialProcessor:MaterialProcessor = new MaterialProcessor(stage3D.context3D);

			materialProcessor.setupMaterials(parser.objects);

			var textureURLMap:Object = createTextureURLMap();

			for each (var textureResource:ExternalTextureResource in scene.getResources(true, ExternalTextureResource)) {

				var textureName:String = getShortTextureName(textureResource.url).toLocaleLowerCase();

				//var isATFTexture:Boolean = textureName.split(".").pop() == "atf";
				try {
					//apply file data to external texture
					materialProcessor.setupExternalTexture(textureResource, textureURLMap[textureName], false);
				}
				catch (error:Error) {
					if (error.errorID == RESOURCE_LIMIT_ERROR_ID) {
						break;
					} else {
						throw error;
					}
				}
			}
			if(arg == Model){
					for each (var resource:Resource in world.getResources(true)) {
					if(!resource.isUploaded){
						resource.upload(stage3D.context3D);
					}
				}
			}
		}
		
		protected function onDoubleClick(e:MouseEvent3D):void {
			if(selectObject != null){
				glowObject.removeGlowFromObject(selectObject);
			}
			selectObject = e.currentTarget as Mesh;
			setObject(selectObject.x,selectObject.y, selectObject.z);
			managerControls.setInfo(selectObject.name);
		}
		
		private function setObject(initX:Number, initY:Number, initZ:Number):void {
			var currentZNumer:Number;
			managerControls.visibleInfo();
			glowObject.applyGlowToObject(selectObject);	
			mode = true;
			if(camera.z < initZ){
				currentZNumer = initZ+1000;
			}else{
				currentZNumer = controller.getCooZ();
			}
			if(!standardMode){
				controller.setObjectPosXYZDoubleClick(initX,initY,currentZNumer);
				controller.lookAtXYZ(initX, initY, initZ);
				controller.updateObjectTransform();
			}else{
				controller.setObjectPosXYZDoubleClick(initX,initY,currentZNumer);
			}
		}
		protected function changeItem(e:MeshEvent):void {
			if(selectObject != null){
				glowObject.removeGlowFromObject(selectObject);
			}
			selectObject = e.value;
			setObject(e.value.x, e.value.y, e.value.z);
		}
		
		private function getShortTextureName(name:String):String {
			var shortName:String = name.split("/").pop();
			shortName = shortName.split("\\").pop();
			return shortName;
		}
		
		private function createTextureURLMap():Object {
				
			//map of "texture url->texture data"
			var urlMap:Object = new Object();
			urlMap["texture18.jpg"] = new Texture_1();
			urlMap["texture2.jpg"] = new Texture_2();
			urlMap["texture10.jpg"] = new Texture_3();
			urlMap["texture16.jpg"] = new Texture_4();
			urlMap["texture3.jpg"] = new Texture_5();
			urlMap["texture13.jpg"] = new Texture_6();
			urlMap["texture7.jpg"] = new Texture_7();
			urlMap["texture5.jpg"] = new Texture_8();
			urlMap["texture15.jpg"] = new Texture_9();
			urlMap["texture9.jpg"] = new Texture_10();
			urlMap["texture4.jpg"] = new Texture_11();
			urlMap["texture17.jpg"] = new Texture_12();
			urlMap["texture6.jpg"] = new Texture_13();
			urlMap["texture14.jpg"] = new Texture_14();
			urlMap["texture12.jpg"] = new Texture_15();
			urlMap["texture8.jpg"] = new Texture_16();
			urlMap["texture11.jpg"] = new Texture_17();
			urlMap["texture19.jpg"] = new Texture_19();
			urlMap["texture20.jpg"] = new Texture_20();
			urlMap["texture21.jpg"] = new Texture_21();
			urlMap["texture2_nor_2.jpg"] = new Texture_18();
			
			//Building Specular
			urlMap["amb_specular.jpg"] = new Texture_2_Specular();
			urlMap["amb_specular_dark.jpg"] = new Texture_2_Specular_Dark();
			
			urlMap["materi07_specular.jpg"] = new Material7_Specular();
			urlMap["materi09_specular.jpg"] = new Material9_Specular();
			urlMap["materi15_specular.jpg"] = new Material15_Specular();
			
			//Plants
			urlMap["shr15.jpg"] = new Grass();
			urlMap["shr15_op.jpg"] = new Grass_Op();
			urlMap["shr15_normal.jpg"] = new Grass_Normal();
			
			urlMap["grass.jpg"] = new Grass2();
			urlMap["grass_op.jpg"] = new Grass2_Op();
			urlMap["grass_normal.jpg"] = new Grass2_Normal();
			//
			urlMap["tree1.jpg"] = new Tree0();
			urlMap["tree1_op.jpg"] = new Tree0_Op();
			urlMap["tree1_normal.jpg"] = new Tree0_Normal();
			//
			urlMap["tree2.jpg"] = new Tree1();
			urlMap["tree2_op.jpg"] = new Tree1_Op();
			urlMap["tree2_normal.jpg"] = new Tree1_Normal();
			//
			urlMap["tree5.jpg"] = new Tree2();
			urlMap["tree5_op.jpg"] = new Tree2_Op();
			urlMap["tree5_normal.jpg"] = new Tree2_Normal();
			//texture landscape
			
			urlMap["material.jpg"] = new Material();
			urlMap["materi01.jpg"] = new Material1();
			urlMap["materi02.jpg"] = new Material2();
			urlMap["materi03.jpg"] = new Material3();
			urlMap["materi04.jpg"] = new Material4();
			urlMap["materi05.jpg"] = new Material5();
			urlMap["materi06.jpg"] = new Material6();
			urlMap["materi07.jpg"] = new Material7();
			urlMap["materi08.jpg"] = new Material8();
			urlMap["materi09.jpg"] = new Material9();
			urlMap["materi10.jpg"] = new Material10();
			urlMap["materi11.jpg"] = new Material11();
			urlMap["materi12.jpg"] = new Material12();
			urlMap["materi13.jpg"] = new Material13();
			urlMap["materi14.jpg"] = new Material14();
			urlMap["materi15.jpg"] = new Material15();
			urlMap["materi16.jpg"] = new Material16();
			urlMap["materi17.jpg"] = new Material17();
			urlMap["materi18.jpg"] = new Material18();
			urlMap["materi19.jpg"] = new Material19();
			urlMap["materi20.jpg"] = new Material20();
			urlMap["materi21.jpg"] = new Material21();
			urlMap["materi22.jpg"] = new Material22();
			urlMap["materi23.jpg"] = new Material23();
			urlMap["road.jpg"] = new Material_Road();
			urlMap["_fencing.jpg"] = new Material_Fencing();
			urlMap["fencing_.jpg"] = new Material_Fencing_();
			urlMap["brick_an.jpg"] = new Brick_An();
			urlMap["_brick_a.jpg"] = new _Brick_A();
			
			//texture normal
			//Active Buildings
			urlMap["texture2_normal.jpg"] = new Texture2_normal();
			urlMap["texture3_normal.jpg"] = new Texture3_normal();
			urlMap["texture4_normal.jpg"] = new Texture4_normal();
			urlMap["texture5_normal.jpg"] = new Texture5_normal();
			urlMap["texture6_normal.jpg"] = new Texture6_normal();
			urlMap["texture7_normal.jpg"] = new Texture7_normal();
			urlMap["texture8_normal.jpg"] = new Texture8_normal();
			urlMap["texture9_normal.jpg"] = new Texture9_normal();
			urlMap["texture10_normal.jpg"] = new Texture10_normal();
			urlMap["texture11_normal.jpg"] = new Texture11_normal();
			urlMap["texture12_normal.jpg"] = new Texture12_normal();
			urlMap["texture13_normal.jpg"] = new Texture13_normal();
			urlMap["texture14_normal.jpg"] = new Texture14_normal();
			urlMap["texture15_normal.jpg"] = new Texture15_normal();
			urlMap["texture16_normal.jpg"] = new Texture16_normal();
			urlMap["texture17_normal.jpg"] = new Texture17_normal();
			urlMap["texture18_normal.jpg"] = new Texture18_normal();
			urlMap["texture19_normal.jpg"] = new Texture19_normal();
			urlMap["texture20_normal.jpg"] = new Texture20_normal();
			urlMap["texture21_normal.jpg"] = new Texture21_normal();
			

			urlMap["material_normal.jpg"] = new Material_normal();
			urlMap["materi01_normal.jpg"] = new Material01_normal();
			urlMap["materi02_normal.jpg"] = new Material01_normal();
			urlMap["materi03_normal.jpg"] = new Material03_normal();
			urlMap["materi04_normal.jpg"] = new Material04_normal();
			urlMap["materi05_normal.jpg"] = new Material05_normal();
			urlMap["materi06_normal.jpg"] = new Material06_normal();
			urlMap["materi07_normal.jpg"] = new Material07_normal();
			urlMap["materi08_normal.jpg"] = new Material08_normal();
			urlMap["materi09_normal.jpg"] = new Material09_normal();
			urlMap["materi10_normal.jpg"] = new Material10_normal();
			urlMap["materi11_normal.jpg"] = new Material11_normal();
			urlMap["materi12_normal.jpg"] = new Material12_normal();
			urlMap["materi13_normal.jpg"] = new Material13_normal();
			urlMap["materi14_normal.jpg"] = new Material14_normal();
			urlMap["materi15_normal.jpg"] = new Material15_normal();
			urlMap["materi16_normal.jpg"] = new Material16_normal();
			urlMap["materi17_normal.jpg"] = new Material17_normal();
			urlMap["materi18_normal.jpg"] = new Material18_normal();
			urlMap["materi19_normal.jpg"] = new Material19_normal();
			urlMap["materi20_normal.jpg"] = new Material20_normal();
			urlMap["materi21_normal.jpg"] = new Material21_normal();
			urlMap["materi22_normal.jpg"] = new Material22_normal();
			urlMap["materi23_normal.jpg"] = new Material23_normal();
			urlMap["road_normal.jpg"] = new Material_road_normal();
			urlMap["fencing_normal2.jpg"] = new Material_fencing_normal();
			urlMap["brick_an_normal.jpg"] = new Brick_An_normal();
			urlMap["brick_an_normal.jpg"] = new _Brick_A();
			
			return urlMap;
}
		private function onEnterFrameFreeCam(e:Event):void {
			
			shadow.centerX = camera.localToGlobal(new Vector3D(0,0,0)).x
			shadow.centerY = camera.localToGlobal(new Vector3D(0,0,0)).y

			camera.startTimer();
			controller.update();
			if(water != null)water.update();
			camera.stopTimer();
			bloom.render();			
		}
		
		private function onEnterFrameWalkCam(e:Event):void {
			shadow.centerX = camera.localToGlobal(new Vector3D(0,0,0)).x;
			shadow.centerY = camera.localToGlobal(new Vector3D(0,0,0)).y;
			camera.startTimer();
			walkController.update();
			if(water != null) water.update();
			camera.stopTimer();
			bloom.render();
		}

		private function onResize(e:Event = null):void {
			camera.view.width = stage.stageWidth;
			camera.view.height = stage.stageHeight;
		}
		
	}
}