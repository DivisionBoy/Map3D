package controls {
		import alternativa.engine3d.collisions.EllipsoidCollider;
		import alternativa.engine3d.core.Camera3D;
		import alternativa.engine3d.core.Object3D;
		import alternativa.engine3d.objects.Mesh;
		
		import flash.display.Stage;
		import flash.display.StageDisplayState;
		import flash.events.FullScreenEvent;
		import flash.events.KeyboardEvent;
		import flash.events.MouseEvent;
		import flash.geom.Point;
		import flash.geom.Vector3D;
		import flash.ui.Keyboard;
		import flash.utils.Dictionary;
		import flash.utils.getTimer;
		
		/**
		 * ...
		 * @author QW01_01
		 */
		public class WalkController extends Object3D
		{
			private static const MathPI2:Number = Math.PI / 2;
			private static const MathPI4:Number = Math.PI / 4;
			private static const Eps:Number = 0.001;
			private static const Bobtime:Number = 0.35;
			private static const MaxSpeed:Number = 20;
			private var delt:Number;
			
			private var herocamera:Camera3D;
			private var stage:Stage;
			
			private var time:Number = MathPI2;
			private var headbob:Number;
			private var height:Number;
			
			private var collider:EllipsoidCollider;
			private var characterCoords:Vector3D;
			
			private var col:Mesh;
			
			public function WalkController(camera:Camera3D, size:Vector3D, height:Number, headbob:Number, stage:Stage,collision:Mesh, initX:Number, initY:Number, initRotationZ:Number)
			{
				this.initX = initX;
				this.initY = initY;
				this.initRotationZ = initRotationZ;
				/*stage.displayState = StageDisplayState.FULL_SCREEN;
				stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullscreen);
				stage.addEventListener(FullScreenEvent.FULL_SCREEN_INTERACTIVE_ACCEPTED, onFullscreen);*/
				this.stage = stage;
				herocamera = camera;
				this.headbob = headbob;
				this.height = height;
				herocamera.z = headbob + height;
				/*herocamera.x = initX
				herocamera.y = initY*/
				/*herocamera.x = 500
				herocamera.y = 500*/
				herocamera.rotationX = -MathPI2;
			//	herocamera.rotationZ = rotationZ
				addChild(camera);
				
				col = collision;
				collider = new EllipsoidCollider(size.x / 2, size.y / 2, size.z /2 );
				
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onkeydown);
				stage.addEventListener(KeyboardEvent.KEY_UP, onkeyup);
				
				stage.addEventListener(MouseEvent.MOUSE_DOWN, onPress);
				stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
				
				characterCoords = new Vector3D(initX, initY, 20);
			}
			
			protected function onFullscreen(event:FullScreenEvent):void
			{
				stage.mouseLock = true;

			}
			
			public function disable():void
			{
				stage.removeEventListener(MouseEvent.MOUSE_DOWN, onPress);
				stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onmove);
			}
			public function enable():void
			{
				stage.addEventListener(MouseEvent.MOUSE_DOWN, onPress);
				stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onmove);
			}
			
			public function onMouseLock(x:Number, z:Number):void
			{
				herocamera.rotationX -= x / 200;
				if (herocamera.rotationX > 0)
				{
					herocamera.rotationX = 0;
				}
				else if (herocamera.rotationX < -Math.PI)
				{
					herocamera.rotationX = -Math.PI;
				}
				this.rotationZ -= z / 200;
			}
			
			private var target:Point = new Point();
			private var rotZ:Number = 0;
			private var rotX:Number = -MathPI2;
			private var ang:Number = 0;
			
			private function onPress(e:MouseEvent):void
			{
				target = new Point(e.localX, e.localY);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, onmove);
			}
			
			private function onUp(e:MouseEvent):void
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, onmove);
				target = null;
				rotZ = this.rotationZ;
				rotX = herocamera.rotationX;
			}
			
			private function onmove(e:MouseEvent):void
			{
				if (target != null)
				{
					
					ang = (target.y - e.localY) / 200 + rotX;
					if (-Math.PI <= ang && ang <= 0)
						herocamera.rotationX = ang;
					this.rotationZ = (target.x - e.localX) / 200 + rotZ;
				}
			}
			
			private var _left:Boolean = false;
			private var _right:Boolean = false;
			private var _up:Boolean = false;
			private var _down:Boolean = false;
			
			private function onkeydown(event:KeyboardEvent):void
			{
				if(!_up)
				if (event.keyCode == Keyboard.A)
					_left = true;
				else if (event.keyCode == Keyboard.D)
					_right = true;
				else if (event.keyCode == Keyboard.W)
					_up = true;
				else if (event.keyCode == Keyboard.S)
					_down = true;
			}
			
			private function onkeyup(event:KeyboardEvent):void
			{
				if (event.keyCode == Keyboard.A)
					_left = false;
				else if (event.keyCode == Keyboard.D)
					_right = false;
				else if (event.keyCode == Keyboard.W)
					_up = false;
				else if (event.keyCode == Keyboard.S)
					_down = false;
			}
			
			private var wx:Number;
			private var wy:Number;
			private var wz:Number;
			private var wearpon:Object3D;
			private var displ:Vector3D = new Vector3D(0,0,-20);
			private var speed:Number = 0;
			private var initX:Number;
			private var initY:Number;
			private var initRotationZ:Number;
			
			public function setWearpon(wearpon:Object3D, x:Number, y:Number, z:Number):void
			{
				herocamera.addChild(wearpon);
				this.wearpon = wearpon;
				wx = wearpon.x = x;
				wy = wearpon.y = y;
				wz = wearpon.z = z;
			}
			
			public function update():void
			{
				delt = 0;
				
				if (_up || _down)
				{
					if (_left)
						delt += MathPI4;
					if (_right)
						delt -= MathPI4;
					if (_down && !_up)
						delt = Math.PI - delt;
				}
				else
				{
					if (_left)
						delt += MathPI2;
					if (_right)
						delt -= MathPI2;
				}
				
				// herocamera.startTimer();
				
				if (_left || _right || _up || _down)
				{
					var rad:Number = this.rotationZ + delt +initRotationZ;
					displ.x = -Math.sin(rad) * MaxSpeed;
					displ.y = Math.cos(rad) * MaxSpeed;
					time += Bobtime;
				}
				else
				{
					displ.x *= 0.85;
					displ.y *= 0.85;
					//displ.x = displ.y = 0;
					
					if (height + headbob - herocamera.z > 0.1)
						if (abs(Math.sin(time + Bobtime)) < abs(Math.sin(time - Bobtime)))
						{
							time -= Bobtime;
						}
						else
							time += Bobtime;
				}

				characterCoords = collider.calculateDestination(characterCoords, displ, col);

				x += (characterCoords.x-x)*0.3;
				y += (characterCoords.y-y)*0.3;
				z += (characterCoords.z-z)*0.3;
				
				// herocamera.stopTimer();
				
				herocamera.z = height + abs(Math.sin(time)) * headbob;
				herocamera.x = Math.cos(initX) * headbob;
				herocamera.y = Math.cos(initY) * headbob;
				//trace(herocamera.x)

			}
			public function getHerocameraX():Number{
				return x
			}
			public function getHerocameraY():Number{
				return y
			}
			[Inline]
			private static function abs(a:Number):Number
			{
				if (a < 0)
					return -a;
				return a;
			}
		}
	}