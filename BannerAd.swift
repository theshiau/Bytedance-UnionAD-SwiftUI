import SwiftUI
import BUAdSDK
import AppTrackingTransparency
import AdSupport

final class BannerAdViewController: NSObject, UIViewControllerRepresentable,  BUNativeExpressBannerViewDelegate {

    var slotID: String
    var width: CGFloat
    var height: CGFloat

    init(slotID: String, width: CGFloat, height: CGFloat) {
        self.slotID = slotID
        self.width = width
        self.height = height
    }

    func makeUIViewController(context: Context) -> UIViewController {

        let slotID = self.slotID
        let viewController = UIViewController()
        let bannerView = BUNativeExpressBannerView(slotID: slotID, rootViewController: viewController, adSize: CGSize(width: width, height: height), isSupportDeepLink: true)

        viewController.view.addSubview(bannerView)
        bannerView.frame = CGRect(x:0, y:0, width: width, height: height)
        bannerView.delegate = self

        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                DispatchQueue.main.async {
                    bannerView.loadAdData()
                }
            })
        } else {
            bannerView.loadAdData()
        }
        
        return viewController
    }
    
    func nativeExpressBannerAdViewRenderSuccess(_ bannerAdView: BUNativeExpressBannerView?) {
        print("")
    }

    func nativeExpressBannerAdViewRenderFail(_ bannerAdView: BUNativeExpressBannerView?, error: Error?) {
       print("")
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct BannerAd: View {

    var slotID: String
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        HStack {
            Spacer()
            BannerAdViewController(slotID: slotID, width: width, height: height)
                .frame(width: width, height: height, alignment: .center)
            Spacer()
        }
    }
}