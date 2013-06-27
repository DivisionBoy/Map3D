package controls.ui {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import model.ResourceManager;
	
	public class SingleButtonIco extends Sprite {
		
		/*[Embed(source = 'assets/ui/options.jpg')]
		private var OptionsClass:Class;
		private var OptionsImage:Bitmap = new OptionsClass();*/
		
		
		public function SingleButtonIco(sourceName:String) {
			super();
			//addChild(OptionsImage)
			//buttonMode = true;
			mouseChildren = false;
			mouseEnabled = false;
			var button:ResourceManager = new ResourceManager(sourceName);
			//buttonUp.addEventListener(CommonEvent.LOAD_COMPLETE, loadedButtonUp);
			addChild(button);
		}
	}
}