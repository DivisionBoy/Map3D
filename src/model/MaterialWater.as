package model {
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.Resource;
	import alternativa.engine3d.core.VertexAttributes;
	import alternativa.engine3d.primitives.Plane;
	import alternativa.engine3d.resources.BitmapTextureResource;
	
	import eu.nekobit.alternativa3d.materials.WaterMaterial;
	
	import flash.display.Stage3D;
	import flash.media.Camera;
	
	public class MaterialWater extends Object3D {
		private var waterMaterial:WaterMaterial;
		private var plane:Plane;
		
		[Embed(source="assets/normal1.png")]
		static private const Normal1:Class;
		
		
		
		private var hideFromReflection:Vector.<Object3D> = new Vector.<Object3D>();
		private var _stage3D:Stage3D;
		private var _camera:Camera3D;
		private var normalRes:BitmapTextureResource;
		
		public function MaterialWater(object:Object3D, stage3D:Stage3D, camera:Camera3D) {
			super();
			var uvs:Vector.<Number> = new <Number>[
				0,30,0,0,30,30,30,0 
			];
			_stage3D = stage3D;
			_camera = camera;
			/*var ground:TextureMaterial = new TextureMaterial(new BitmapTextureResource(new Ground().bitmapData));
			
			// Underwater plane with ground texture
			underwaterPlane = new Plane(1000, 1000, 1, 1, false, false, null, ground);
			underwaterPlane.z = -1000;
			underwaterPlane.x = -3000;
			underwaterPlane.y = -3000;
			
			underwaterPlane.geometry.setAttributeValues(VertexAttributes.TEXCOORDS[0], uvs);
			uploadResources(underwaterPlane.getResources());
			scene.addChild(underwaterPlane);
			hideFromReflection.push(underwaterPlane);*/
			//trace(object)
			hideFromReflection.push(object);
			//
			normalRes = new BitmapTextureResource(new Normal1().bitmapData);
			waterMaterial = new WaterMaterial(normalRes, normalRes);
			plane = new Plane(3500, 10000, 1, 1, false, false, null, waterMaterial);
			plane.geometry.setAttributeValues(VertexAttributes.TEXCOORDS[0], uvs);
			plane.z =  -620;
			plane.x = -6500;
			plane.y = 10000;
			uploadResources(plane.getResources());
			addChild(plane);
			
		}
		private function uploadResources(resources:Vector.<Resource>):void {
			for each(var res:Resource in resources) {
				if(!res.isUploaded) {
					res.upload(_stage3D.context3D);
				}				
			}
		}
		public function update():void {
			waterMaterial.update(_stage3D, _camera, plane, hideFromReflection);
		}
		/*public function dispose():void {
			for each(var res:Resource in plane.getResources(true)) {
				if(!res.isUploaded) {
					res.dispose();
				}				
			}
			normalRes.dispose();
			
		}*/
			
	}
}