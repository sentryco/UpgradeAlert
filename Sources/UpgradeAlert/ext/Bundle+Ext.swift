import Foundation
/**
 * - Fixme: ⚠️️ there is also displayName
 */
extension Bundle {
   internal static let name: String? = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String // The name of the main bundle
   internal static let version: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String // The version of the main bundle
   internal static let build: String? = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String // The build number of the main bundle
   internal static let identifier: String? = Bundle.main.object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) as? String // The identifier of the main bundle
   /**
    * Tests if an app is in beta
    * Description: determines if beta from receipt
    * - Note: From here: https://stackoverflow.com/a/38984554/5389500 (The link is a Stack Overflow answer that provides a solution for checking if an app is running on a simulator or TestFlight. The solution involves getting the path of the app store receipt URL and checking if it contains "CoreSimulator" or "sandboxReceipt".)
    * - Note: More complex example: https://stackoverflow.com/a/33830605/5389500 (The link is a Stack Overflow answer that provides a solution for getting the app version and build number from the main bundle. The solution involves using the CFBundleShortVersionString and CFBundleVersion keys to retrieve the version and build number, respectively.)
    * - Note: Another example: https://stackoverflow.com/a/59047187/5389500 (The link is a Stack Overflow answer that provides a solution for checking if an app is running on a simulator or TestFlight. The solution involves getting the path of the app store receipt URL and checking if it contains "CoreSimulator" or "sandboxReceipt".)
    * - Note: Might have become broken in iOS 13
    * - Note: If it fails there might be a fix here: https://stackoverflow.com/a/52232267/5389500
    * - Note: Seems like this can determine if an app is beta: https://developer.apple.com/documentation/appstoreconnectapi/list_all_builds_of_an_app
    * - Fixme: ⚠️️ Here is code that checks if something is testflight: https://gist.github.com/lukaskubanek/cbfcab29c0c93e0e9e0a16ab09586996
    * - Fixme. ⚠️️ we could make BundleError enum BundleError: Error { case appStoreReceiptURLNotFound }
    */
   public static var isBeta: Bool { // was named: isSimulatorOrTestFlight
      guard let path = Bundle.main.appStoreReceiptURL?.path else { // Get the path of the app store receipt URL, if it's not available, print an error message and return false
         Swift.print("isBeta - appStoreReceiptURL not found")
         return false
      }
      let isSimulator: Bool = path.contains("CoreSimulator") // Check if the path contains "CoreSimulator", indicating that the app is running on a simulator
      let isTestFlight: Bool = path.contains("sandboxReceipt") // Check if the path contains "sandboxReceipt", indicating that the app is running on TestFlight
      return isSimulator || isTestFlight // Return true if the app is running on a simulator or TestFlight, false otherwise
   }
}
