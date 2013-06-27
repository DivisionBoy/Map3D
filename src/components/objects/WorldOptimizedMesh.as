package components.objects {
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.loaders.ParserA3D;
	import alternativa.engine3d.materials.FillMaterial;
	import alternativa.engine3d.materials.StandardMaterial;
	import alternativa.engine3d.materials.VertexLightTextureMaterial;
	import alternativa.engine3d.objects.Mesh;
	import alternativa.engine3d.resources.BitmapTextureResource;
	
	public class WorldOptimizedMesh extends Mesh {
		
		private var build:Mesh;
		
		[Embed("data/objects3d/map_house_op.A3D", mimeType="application/octet-stream")] static private const BuildingModel1:Class;
		/*[Embed(source="assets/building_dif.jpg")] static private const BuildingTexture1:Class;
		private var buildTextureDiffuse:BitmapTextureResource = new BitmapTextureResource(new BuildingTexture1().bitmapData);
		[Embed(source="assets/building_nor.jpg")] static private const BuildingTextureNormal:Class;
		private var buildTextureNormal:BitmapTextureResource = new BitmapTextureResource(new BuildingTextureNormal().bitmapData);
		private var buildingTexture:StandardMaterial;*/
		
		public function WorldOptimizedMesh(){
			//super();
			
			var parser:ParserA3D = new ParserA3D();
			parser.parse(new BuildingModel1());
			trace(parser.objects);
			
			build = parser.objects[0] as Mesh;
			//!!build.setMaterialToAllSurfaces(buildingTexture);
			//!!addChild(build);
			for each (var object:Object3D in parser.objects) {
				if (object is Mesh){
					//trace("FFFFFFFFFFF")
					build = object as Mesh;
					//build.setMaterialToAllSurfaces(new FillMaterial(0xCCCCCC));
					addChild(build);
					//build.addEventListener(MouseEvent3D.CLICK,click3d)
				}
			}
			trace(build)
			/*if (build is Mesh){
				build.setMaterialToAllSurfaces(new FillMaterial(0xCCCCCC));
				addChild(build);
			}*/
		//	Log.mes(parser.objects+"")
//
		}
	}
}