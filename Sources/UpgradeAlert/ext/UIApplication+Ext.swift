#if os(iOS)
import UIKit
/**
 * Extension to UIApplication to handle window and status-bar related functionalities (iOS 15 etc).
 */
extension UIApplication {
   /**
    * Key window property.
    * - Description: Retrieves the primary window of the application that is
    *                currently receiving user events.
    * - Remark: The key scene can be found by accessing `keyWin.windowScene`.
    * - Returns: The key window if it exists, otherwise nil.
    */
   internal var keyWin: UIWindow? {
      self
         // Retrieves all connected scenes of the application.
         .connectedScenes
         // Flatten the array of windows from each UIWindowScene
         .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
         // Find the first window that is the key window
         .first { $0.isKeyWindow }
   }
}
#endif
