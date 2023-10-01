import Foundation
/**
 * - Fixme: ⚠️️ there is also displayName
 */
extension Bundle {
   /**
    * The name of the main bundle.
    */
   internal static let name: String? = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String
   /**
    * The version of the main bundle.
    */
   internal static let version: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
   /**
    * The build number of the main bundle.
    */
   internal static let build: String? = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
   /**
    * The identifier of the main bundle.
    */
   internal static let identifier: String? = Bundle.main.object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) as? String
   /**
    * Tests if an app is in beta
    * Description: determines if beta from receipt
    * - Note: From here: https://stackoverflow.com/a/38984554/5389500
    * - Note: More complex example: https://stackoverflow.com/a/33830605/5389500
    * - Note: Another example: https://stackoverflow.com/a/59047187/5389500
    * - Note: Might have become broken in iOS 13
    * - Note: If it fails there might be a fix here: https://stackoverflow.com/a/52232267/5389500
    * - Note: Seems like this can determine if an app is beta: https://developer.apple.com/documentation/appstoreconnectapi/list_all_builds_of_an_app
    * - Fixme: ⚠️️  Here is code that checks if something is testflight: https://gist.github.com/lukaskubanek/cbfcab29c0c93e0e9e0a16ab09586996
    * fix. we could make BundleError enum BundleError: Error { case appStoreReceiptURLNotFound }
    */
   public static var isBeta: Bool { // was named: isSimulatorOrTestFlight
      guard let path = Bundle.main.appStoreReceiptURL?.path else {
         Swift.print("isBeta - appStoreReceiptURL not found")
         return false
      }
      let isSimulator: Bool = path.contains("CoreSimulator") // can also use #if !targetEnvironment(simulator)  #else #endif here
      let isTestFlight: Bool = path.contains("sandboxReceipt")
      return isSimulator || isTestFlight
   }
}
