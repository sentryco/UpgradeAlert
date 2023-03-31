#if os(iOS)
import UIKit

extension UIAlertController {
   func present() {
      UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: true, completion: nil)
   }
}
#endif
