#if os(iOS)
import UIKit

extension UIAlertController {
   /**
    * Present alert
    * - Fixme: ⚠️️ throw error if vc is not available?
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
    * - Note: Sometimes there is no vc: https://stackoverflow.com/a/30509569/5389500 (The link is a Stack Overflow answer that provides an extension to UIAlertController that allows for the creation of an alert with a text field. The solution involves creating a new UIAlertController instance with a text field, adding an action to the alert that retrieves the text field's value, and presenting the alert.)
    */
   fileprivate static var presentedOrRootVC: UIViewController? {
      let keyWin = UIApplication.shared.keyWin // Get the key window of the shared application
      // Swift.print("keyWin:  \(String(describing: keyWin))")
      let rootVC = keyWin?.rootViewController // Get the root view controller of the key window
      // Swift.print("rootVC:  \(String(describing: rootVC))")
      let presentedVC = rootVC?.presentedViewController // Get the presented view controller of the root view controller
      // Swift.print("presentedVC:  \(presentedVC)")
      return presentedVC ?? rootVC // Return the presented view controller if it exists, otherwise return the root view controller
   }
}
#endif
