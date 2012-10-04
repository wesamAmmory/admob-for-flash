flash 加载显示 admob广告
admob 的flash air ane扩展，用于在flash中显示admob广告
库力求功能全面和接口简单，真机上运行良好，不支持模拟器运行和pc运行。
基于admob ios sdk v6编译，使用需要air sdk3.1或以上，
建议使用fb4.7打包，flex builder 4.7可以在pc上直接打包，无需额外设置，
如果是fb4.6或以下版本的fb需要设置iossdk 路径，并且只能在mac上打包。
能完美的显示横向广告和竖向广告，并且可以随意设置广告的位置，支持多样的广告类型和广告事件。
下面一句一句说明
package
{
	import flash.display.Sprite;
	import so.cuo.anes.admob.AdType;
	import so.cuo.anes.admob.Admob;
	[SWF(width="640", height="960", frameRate="60", backgroundColor="#cccccc")]
	public class AdmobTestSimple extends Sprite
	{
	//a14fde93a405e01为admob的app id，可以上www.admob.com注册获取
		private var gid:String="a14fde93a405e01";
		public function AdmobTestSimple()
		{
			super();
			//获取Admob引用
			var ad:Admob=Admob.getInstance();
			//测试功能在当前运行环境是否可用
			if(ad.isSupported){
			//设置广告id
				ad.setUnitId(gid);
				//https://developers.google.com/mobile-ads-sdk/docs/admob/intermediate
				//https://developers.google.com/mobile-ads-sdk/docs/admob/smart-banners
				//设置广告尺寸类型，可以参考google网址上面对尺寸的说明
				ad.setAdType(AdType.kGADAdSizeBanner);
				//设置广告显示位置
				ad.setPosition(0,100);
				//设置是横向广告还是竖向广告
				ad.setIsLandscape(true);
				//把广告添加到显示列表，和sprite.addChild(displayObject)功能类似。
				ad.addToDisplayList();
				//刷新广告，调用一次就可以。无需定时进行
				ad.refresh();
			}else{
				trace("not support");
			}
		}
	}
}

上面是基础用法，只要做到上面的已经可以正常工作了
更多的功能可以参考api文档和例子

下面还有些附加的功能
1.NativeAds.dispatcher可以添加监听器，来处理广告的各种状态
其中事件类型在NativeAdsEvent中定义，包括用户点击了广告，由于点击要离开程序，广告加载成功和失败
2.通过adobe 本机扩展  ane for admob iphone 可以获取设备号（mac地址）
调用getUUID能获得设备的唯一id，由于苹果已经不再建议使用uuid，这个接口返回的是机器的mac地址和uuid的合并字符串。
Admob.getInstance().getUUID()