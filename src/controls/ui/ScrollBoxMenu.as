package controls.ui {
	
	import components.GraphicElement;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	public class ScrollBoxMenu extends Sprite {
		
		public var maskObject:Sprite;
		private var offset:Number = 0
		private var _container:Sprite;
		private static var _pimp:GraphicElement;
		private var _track:Sprite;
		private var _height:Number;
		private var _k:Number;
		private var _noScroll:Boolean;
		private var _grabY:Number;
		private var _pimpMinHeight:Number;
		private var _scrollerWidth:Number;
		private var _scrollerPimpColor:uint;
		private var contentWay:Number
		private var maxPimpWay:Number
		private var pimpHeight:Number
		//private var shadowFilter:DropShadowFilter = new DropShadowFilter(4,45,0x000000,0.7,10,10,1,1);
		
		public function ScrollBoxMenu(content:DisplayObject, boxHeight:Number, scrollerWidth:Number = 10, scrollerPimpColor:uint = 0x808080) {
			_container = new Sprite();
			_scrollerPimpColor = scrollerPimpColor;
			_scrollerWidth = scrollerWidth;
			_height = boxHeight;
			_container.addChild(content);
			_noScroll = content.height <= _height;
			if(_noScroll)offset = 0;
			
			var _containerShadow:Sprite = createSprite(content.width+offset, _height,0xCCCCCC,"line");
			addChild(_containerShadow);
			_container.x = -_container.width - offset;
			//_container.y = 20
			//_containerShadow.filters = [shadowFilter];
			maskObject = createSprite(content.width+15, _height, 0xFF0000);
			_container.mask = maskObject;
			
			this.addChild(_container);
			this.addChild(maskObject);
					
			if (this.stage != null) {
				init();
			}else{
				this.addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(event:Event = null):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			this.addEventListener(MouseEvent.MOUSE_WHEEL, wheelHandler);
			_pimpMinHeight = _scrollerWidth * 2;
			contentWay = _container.height - _height;
			pimpHeight = _height - contentWay;
			maxPimpWay = _height - _pimpMinHeight;
			if (contentWay > maxPimpWay) {
				//slider
				_pimp = new GraphicElement(10, _pimpMinHeight,0xA3A3A3,5,5);
				_k = contentWay / maxPimpWay;
			}else{
				_pimp = new GraphicElement(10, pimpHeight,0xA3A3A3,5,5);
				_k = 1;
			}
			
			_track = createSprite(_scrollerWidth, _height, 0xFFFFFF);
			_track.x = -3;
			
			_pimp.x = _track.x;
			_track.alpha = 0.4;
			addChild(_track);
			addChild(_pimp);
			_pimp.addEventListener(MouseEvent.MOUSE_DOWN, pimpDownHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, pimpUpHandler);
			
			if (_noScroll) {
				_pimp.visible = false;
				_track.visible = false;
				_k = 0;
			}
		}
		
		private function createSprite(initWidth:Number, initHeight:Number, color:uint = 0xCCCCCC, mode:String = "none"):Sprite {
			var g:Sprite = new Sprite();
			if(mode == "line")g.graphics.lineStyle(5,0xE6E6E6);
			g.graphics.beginFill(color);
			g.graphics.drawRect(-initWidth, 0, initWidth, initHeight);
			g.graphics.endFill();
			
			return g;
		}
		
		private function wheelHandler(event:MouseEvent):void {
			_pimp.y = Math.min(Math.max(0, _pimp.y - event.delta), _height - _pimp.height);
			moveContent();
		}

		public static function setPosY(num:Number):void {
			_pimp.y = num;
			
		}
			
		private function movePimp(event:MouseEvent):void {
			_pimp.y = Math.min(Math.max(0, this.mouseY - _grabY), _height - _pimp.height);
			moveContent();
		}
		
		private function moveContent():void {
			_container.y = -_pimp.y * _k;
		}
		private function pimpDownHandler(event:MouseEvent):void {
			_grabY = _pimp.mouseY;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, movePimp);
		}
		private function pimpUpHandler(event:MouseEvent):void {
			if(stage !=null)stage.removeEventListener(MouseEvent.MOUSE_MOVE, movePimp);
		}
		public function updateGraphic(initWidth:Number, initHeight:Number, cListHeight:Number):void {
			_height = initHeight;
			maskObject.width = initWidth;
			maskObject.height = initHeight;
			_track.height = initHeight;
			contentWay = cListHeight - _height;
			pimpHeight = _height - contentWay;
			maxPimpWay = _height - _pimpMinHeight;
			_pimp.y = Math.min(Math.max(0, _pimp.y), initHeight - _pimp.height)
			_container.y = -_pimp.y * _k;

			if (contentWay > maxPimpWay){
				_pimp.updateXY(0, 10, _pimpMinHeight, 5,5)
				_k = contentWay / maxPimpWay;
			}else if(_height >= pimpHeight+10){
				_pimp.updateXY(0, 10, pimpHeight, 5,5);
				_k = 1;
				_pimp.visible = true;
				_track.visible = true;

			}else{
				_pimp.visible = false;
				_track.visible = false;
				_k = 0;
				_pimp.y = 0;	
			}
		}
		
	}
}