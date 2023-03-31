#if os(iOS)
import UIKit

extension UIApplication {
   /**
    * open appstore
    */
   public static func openAppStore(appId: String) {
      if let url = URL(string: "https://apps.apple.com/app/id\(appId)"),
         UIApplication.shared.canOpenURL(url) {
         UIApplication.shared.open(url, options: [:]) { opened in
            if opened {
               debugPrint("App Upgrade: Opened App Store.")
            }
         }
      } else {
         Swift.print("App Upgrade: Can't Open App Store on Simulator.")
      }
   }
}
#endif
