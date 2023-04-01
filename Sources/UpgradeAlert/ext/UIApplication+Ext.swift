#if os(iOS)
import UIKit
/**
 * Window and status-bar (iOS 15 etc)
 */
extension UIApplication {
   /**
    * - Remark: Key Scene can be found by doing `keyWin.windowScene`
    */
   internal var keyWin: UIWindow? {
      UIApplication
         .shared
         .connectedScenes
         .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
         .first { $0.isKeyWindow }
   }
}
#endif

