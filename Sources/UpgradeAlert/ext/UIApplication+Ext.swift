#if os(iOS)
import UIKit
/**
 * Extension to UIApplication to handle window and status-bar related functionalities (iOS 15 etc).
 */
extension UIApplication {
   /**
    * Key window property.
    * - Remark: The key scene can be found by accessing `keyWin.windowScene`.
    * - Returns: The key window if it exists, otherwise nil.
    */
   internal var keyWin: UIWindow? {
      self
         .connectedScenes // Get the set of connected scenes
         .flatMap { ($0 as? UIWindowScene)?.windows ?? [] } // Flatten the array of windows from each UIWindowScene
         .first { $0.isKeyWindow } // Find the first window that is the key window
   }
}
#endif