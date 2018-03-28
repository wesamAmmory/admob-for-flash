package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import so.cuo.platform.admob.Admob;
	import so.cuo.platform.admob.AdmobEvent;
	import so.cuo.platform.admob.AdmobPosition;
	import so.cuo.platform.admob.AdmobSize;
	import so.cuo.platform.admob.ExtraParameter;

	public class demo extends Sprite
	{
		private var admob:Admob;
		public var bannerID:String="ca-app-pub-3940256099942544/2934735716";
		public var fullID:String="ca-app-pub-3940256099942544/4411468910";
		public var nativeID:String="ca-app-pub-3940256099942544/2247696110";
		public var videoID:String="ca-app-pub-3940256099942544/1712485313";
		public var extraParam:ExtraParameter;

		public var xPosition:TextField
		public var yPosition:TextField
		public var bannerType:TextField

		public function demo()
		{
			super();
			initUI();
			admob=Admob.getInstance();
			if (admob.supportDevice)
			{
				admob.setKeys(bannerID,fullID);
				admob.addEventListener(AdmobEvent.onInterstitialReceive, onAdEvent);
				admob.addEventListener(AdmobEvent.onBannerReceive, onAdEvent);
				admob.enableTrace=true;
				trace(admob.getScreenSize(), admob.getScreenSize().height);
				log.text+="supported\n";
			}else{
				trace("--------- not support");
				log.text+="not supported\n";
			}
			
			extraParam=new ExtraParameter();
//			extraParam.testDeviceID="true";
//			extraParam.isChildApp=true;
			
			showStartAuto();
		}
		
		private function showStartAuto():void
		{
		//	admob.showNativeBannerAbsolute(nativeID,new AdmobSize(320,132),0,260);
			admob.cacheInterstitial(extraParam);
			admob.showBanner(AdmobSize.BANNER_320x50,AdmobPosition.BOTTOM_CENTER);
			admob.showBannerAbsolute(AdmobSize.BANNER_320x50,0,250,null,"classicBanner");
			
		}
		
		private function initUI():void
		{
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			var ui:UI=new UI(onClick);
			addChild(ui);
			ui.addButton("relation", 20, 40);
			ui.addButton("absolute", 160, 40);
			ui.addButton("hide", 300, 40);
			
			xPosition=ui.addButton("8", 20, 120);
			yPosition=ui.addButton("300", 160, 120);
			bannerType=ui.addButton("bannerType", 300, 120);
			
			ui.addButton("native", 20, 240);
			ui.addButton("hidenative", 160, 240);
			
			ui.addButton("interstitial", 20, 320);
			ui.addButton("showVideo", 160, 320);

			xPosition.type=yPosition.type=bannerType.type=TextFieldType.INPUT;
			xPosition.border=yPosition.border=bannerType.border=true;
		}

		private function onAdEvent(event:AdmobEvent):void
		{
			if (event.type == AdmobEvent.onBannerReceive)
			{
				trace(event.instanceName,event.data.width, event.data.height);
			}
			if (event.type == AdmobEvent.onInterstitialReceive)
			{
				admob.showInterstitial();
			}
		}

		private function onClick(label:String):void
		{
			
//			trace("click flash stage-------1", stage.stageWidth, stage.stageHeight, stage.orientation);
			trace("click button "+label);
			if (!admob.supportDevice)
			{
				trace("not support device");
				return
			}
			else
			{
				var xPositionValue:int=parseInt(xPosition.text);
				var yPositionValue:int=parseInt(yPosition.text);
				var bannerTypeValue:int=parseInt(bannerType.text);
				var adsize:AdmobSize;
				if (bannerTypeValue == 1)
				{
					adsize=AdmobSize.BANNER_320x50;
				}
				if (bannerTypeValue == 2)
				{
					adsize=AdmobSize.BANNER_320x100;
				}
				if (bannerTypeValue == 3)
				{
					adsize=AdmobSize.BANNER_300X250;
				}
				if (bannerTypeValue == 4)
				{
					adsize=AdmobSize.BANNER_468X60;
				}
				if (bannerTypeValue == 5)
				{
					adsize=AdmobSize.BANNER_728X90;
				}
				if (bannerTypeValue == 6)
				{
					adsize=AdmobSize.SMART_BANNER;
				}
				if (adsize == null)
				{
					adsize=AdmobSize.BANNER_STANDARD;
				}
				if (label == "hide")
				{
					admob.hideBanner();
					admob.hideBanner("classicBanner");
				}
				if (label == "absolute")
				{
					admob.showBannerAbsolute(adsize, xPositionValue, yPositionValue, extraParam);
				}
				else if (label == "relation")
				{
					if (xPositionValue > 9)
						xPositionValue=9;
					if (xPositionValue < 1)
						xPositionValue=1;
					admob.showBanner(adsize, xPositionValue,0, extraParam);
				}
				else if (label == "interstitial")
				{
					if (admob.isInterstitialReady())
					{
						admob.showInterstitial();
					}
					else
					{
						admob.cacheInterstitial(extraParam);
					}
				}
				else if (label == "native")
				{
//					admob.showNativeBanner(nativeID,new AdmobSize(320,100),AdmobPosition.MIDDLE_CENTER,0);
				//	admob.showNativeBannerAbsolute(nativeID,new AdmobSize(320,132),0,260);
				}
				else if (label == "hidenative")
				{
//					admob.hideNativeBanner("nativebanner");
				//	admob.hideNativeBanner();
				}
				else if(label=="showVideo"){
					if(admob.isVideoReady()){
						admob.showVideo();
					}else{
						admob.cacheVideo(videoID);
					}
				}
			}
		}
	}
}
