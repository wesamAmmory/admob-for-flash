package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import so.cuo.anes.admob.AdEvent;
	import so.cuo.anes.admob.AdSize;
	import so.cuo.anes.admob.Admob;
	
	public class BannerTest extends Sprite
	{
		private var format:TextFormat;

		private var remove:TextField;
		private var info:TextField;
		
		private var iabBannerLabel:TextField;
		private var bannerLabel:TextField;
		private var mrectLabel:TextField;
		private var smartLabel:TextField;
		private var leaderboardLabel:TextField;
		
		private var gid:String="your id";
//		private var gid:String="your id"; 
		private var admob:Admob=Admob.getInstance();
		/**
		 * admob banner ad demo ，show you how to add different type of ad size
		 */
		public function BannerTest()
		{
			super();
			this.format=new TextFormat(null,16,0x000000);
			
			
			
			this.leaderboardLabel=createLabel("leaderboard",4);
			this.mrectLabel=this.createLabel("mrect",3);
			this.smartLabel=this.createLabel("smart",2);
			this.iabBannerLabel=this.createLabel("iabBanner",1);
			this.bannerLabel=this.createLabel("banner",0);
			
			this.remove=this.createLabel("hide",5);
			this.info=this.createLabel("info",6);
			info.y=300;
			info.x=0;
			info.width=900;
			
			if(admob.isSupported){
				//get screen size info and mac for ios or device id for android
				info.text="screen width:"+admob.getScreenSize().width+"  height:"+admob.getScreenSize().height+" mac address:"+admob.getMacAddress();
				//add ad event listener
				admob.dispatcher.addEventListener(AdEvent.onDismissScreen,onAdEvent);
				admob.dispatcher.addEventListener(AdEvent.onFailedToReceiveAd,onAdEvent);
				admob.dispatcher.addEventListener(AdEvent.onLeaveApplication,onAdEvent);
				admob.dispatcher.addEventListener(AdEvent.onPresentScreen,onAdEvent);
				admob.dispatcher.addEventListener(AdEvent.onReceiveAd,onAdEvent);
				//landscape true  portrait  false
				admob.setIsLandscape(true);
			}
			
		}
		
		protected function onAdEvent(event:Event):void
		{
			trace(event.type);
			if(event.type==AdEvent.onReceiveAd){
				trace(admob.getAdSize().width,admob.getAdSize().height);
			}
		}
		private function createLabel(label:String,c:int):TextField{
			var l:TextField=new TextField();
			l.defaultTextFormat=format;
			l.text=label;
			l.selectable=false;
			l.width=80;
			l.height=32;
			this.addChild(l);
			l.x=c*80;
			l.border=true;
			l.addEventListener(MouseEvent.CLICK,clickButton);
			return l;
		}
		
		protected function clickButton(event:MouseEvent):void
		{
			if(!admob.isSupported)return;
			trace("click show ad ,please wait to load");
			var t:TextField=event.currentTarget as TextField;
			if(t==this.remove){
				admob.removeFromStage();
			}else{
				var adsize:AdSize=AdSize.BANNER;
				//you can create adsize like this too  
				//var adsize:AdSize=new AdSize(320,50);
				//ad size list https://developers.google.com/mobile-ads-sdk/docs/admob/smart-banners
				if(t==this.iabBannerLabel)
					adsize=AdSize.IAB_BANNER;
				if(t==this.leaderboardLabel)
					adsize=AdSize.IAB_LEADERBOARD;
				if(t==this.mrectLabel)
					adsize=AdSize.IAB_MRECT;
				if(t==this.smartLabel)
					adsize=AdSize.SMART_BANNER;
				//create a adview with size and admob id，if you not change adsize,Usually only created once
				admob.createADView(adsize,gid);
				//For android, you need to find a suitable location in order to have enough space to display ads, 
				//otherwise will not be able to load ads
//				admob.addToStage(0,0);
				admob.addToStage(200,0);//320-50-50 ,480
				admob.load(false);
			}
		}
	}
}