#if os(iOS)
import UIKit

extension UIAlertController {
   /**
    * - Note: sometimes there is no vc: https://stackoverflow.com/a/30509569/5389500
    * - Fixme: ⚠️️ Maybe use presentedVC if rootvc has one etc?
    */
   internal func present() {
//      Swift.print("present")
      let keyWin = UIApplication.shared.keyWin
//      Swift.print("keyWin:  \(String(describing: keyWin))")
      let rootVC = keyWin?.rootViewController
//      Swift.print("rootVC:  \(String(describing: rootVC))")
      let presentedVC = rootVC?.presentedViewController
//      Swift.print("presentedVC:  \(presentedVC)")
      (presentedVC ?? rootVC)?.present(self, animated: true, completion: nil)
   }
}
#endif
