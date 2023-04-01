#if os(iOS)
import UIKit

extension UIAlertController {
   // - Fixme: ⚠️️ maybe use presentedVC if rootvc has one etc?
   internal func present() {
//      Swift.print("present")
      let keyWin = UIApplication.shared.keyWin
//      Swift.print("keyWin:  \(String(describing: keyWin))")
      let rootVC = keyWin?.rootViewController
//      Swift.print("rootVC:  \(String(describing: rootVC))")
      let presentedVC = rootVC?.presentedViewController
//      Swift.print("presentedVC:  \(presentedVC)")
      presentedVC?.present(self, animated: true, completion: nil)
   }
}
#endif
