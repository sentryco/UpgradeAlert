#if os(iOS)
import UIKit

extension UIAlertController {
   /**
    * Present alert
    * - Description: Presents the alert controller modally on the currently
    *                active view controller or the root view controller if no other
    *                controllers are presented.
    * Fix: throw error if vc is not available?
    */
   internal func present() {
      Self.presentedOrRootVC?.present(self, animated: true, completion: nil)
   }
}
/**
 * Private helper
 */
extension UIAlertController {
   /**
    * Presented or root view-controller
    * - Description: Retrieves the currently presented view controller or the
    *                root view controller if no other view controller is
    *                presented.
    * - Note: Sometimes there is no vc: https://stackoverflow.com/a/30509569/5389500
    */
   fileprivate static var presentedOrRootVC: UIViewController? {
      let keyWin = UIApplication.shared.keyWin
      // Swift.print("keyWin:  \(String(describing: keyWin))")
      let rootVC = keyWin?.rootViewController
      // Swift.print("rootVC:  \(String(describing: rootVC))")
      let presentedVC = rootVC?.presentedViewController
      // Swift.print("presentedVC:  \(presentedVC)")
      return presentedVC ?? rootVC
   }
}
#endif
