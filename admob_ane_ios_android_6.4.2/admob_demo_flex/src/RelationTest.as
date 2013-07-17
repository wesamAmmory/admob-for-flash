package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import so.cuo.anes.admob.AdEvent;
	import so.cuo.anes.admob.AdSize;
	import so.cuo.anes.admob.Admob;
	
	public class RelationTest extends Sprite
	{
		private var format:TextFormat;
		private var landscapeLabel:TextField;
		private var portraitLabel:TextField;
		private var topLabel:TextField;
		private var bottomLabel:TextField;
		
		
		private var admob:Admob=Admob.getInstance();
		private var gid:String="your id";
		private var isLandscape:Boolean=true;
		private var position:Point=new Point(0,0);
	
		public function RelationTest()
		{
			super();
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			this.format=new TextFormat(null,32,0x000000);
			this.landscapeLabel=this.createLabel("landscape",1);
			this.portraitLabel=this.createLabel("portrait",2);
			this.topLabel=this.createLabel("top",3);
			this.bottomLabel=this.createLabel("bottom",4);
			initAdmob();
		}
		
		private function createLabel(label:String,c:int):TextField{
			var l:TextField=new TextField();
			l.defaultTextFormat=format;
			l.text=label;
			l.selectable=false;
			l.width=120;
			l.height=48;
			this.addChild(l);
			l.x=c*150;
			l.y=80;
			l.border=true;
			l.addEventListener(MouseEvent.CLICK,clickButton);
			return l;
		}
		protected function clickButton(event:MouseEvent):void
		{
			var screen:Rectangle=admob.getScreenSize();
			var adsize:AdSize=admob.getAdSize();
			trace(screen.width,screen.height,adsize.width,adsize.height);
			var t:TextField=event.currentTarget as TextField;
			if(t==this.portraitLabel){
				this.isLandscape=false;
				admob.setIsLandscape(isLandscape);
			}
			else if(t==this.landscapeLabel){
				this.isLandscape=true;
				admob.setIsLandscape(isLandscape);
			}
			else if(t==this.topLabel){
				this.position=this.getTopCenter(adsize,screen);
			}
			else if(t==this.bottomLabel){
				this.position=this.getBottomCenter(adsize,screen);
			}
			admob.addToStage(position.x,position.y);
		}
		
		//----------------------------------------------
		private function initAdmob():void
		{
			if(admob.isSupported){
				admob.dispatcher.addEventListener(AdEvent.onReceiveAd,onAdEvent);
				admob.setIsLandscape(isLandscape);
				admob.createADView(AdSize.BANNER,gid);
				admob.addToStage(position.x,position.y);//320-50-50 ,480
				admob.load(false);
			}
		}
		protected function onAdEvent(event:AdEvent):void
		{
			this.topLabel.mouseEnabled=this.bottomLabel.mouseEnabled=true;
			admob.addToStage(position.x,position.y);
		}
		private function getBottomCenter(adsize:AdSize,screen:Rectangle):Point{
			var _pos:Point=new Point();
			if(this.isIOS&&isLandscape){
				_pos.x=0;
				_pos.y=(screen.height-adsize.width)/2;
			}else{
				_pos.x=(screen.width-adsize.width)/2;
				_pos.y=(screen.height-adsize.height);
			}
			return _pos;
		}
		private function getTopCenter(adsize:AdSize,screen:Rectangle):Point{
			var _pos:Point=new Point();
			if(this.isIOS&&isLandscape){
				_pos.x=screen.width-adsize.height;
				_pos.y=(screen.height-adsize.width)/2;
			}else{
				_pos.x=(screen.width-adsize.width)/2;
				_pos.y=0;
			}
			return _pos;
		}
		//---------------------------------------------------------------
		private function  get isAndroid():Boolean{
			return Capabilities.manufacturer.indexOf('Android') > -1;
		}
		private function  get isIOS():Boolean{
			return Capabilities.manufacturer.indexOf('iOS') > -1;
		}
	}
}