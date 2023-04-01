#if os(iOS)
import UIKit

extension UIAlertController {
   func present() {
      UIApplication.shared.keyWin?.rootViewController?.present(self, animated: true, completion: nil)
   }
}

#endif
