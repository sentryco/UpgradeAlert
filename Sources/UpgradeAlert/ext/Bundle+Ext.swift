import Foundation
/**
 * - Fixme: ⚠️️ there is also displayName
 */
extension Bundle {
   /**
    * The name of the main bundle.
    * - Description: Retrieves the name of the main bundle of the application.
    * Example: `let appName = Bundle.name`
    */
   internal static let name: String? = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String
   /**
    * The version of the main bundle.
    * - Description: Retrieves the version number of the main bundle of the application.
    * Example: `let appVersion = Bundle.version`
    */
   internal static let version: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
   /**
    * The build number of the main bundle.
    * - Description: Retrieves the build number of the main bundle of the application.
    * Example: `let buildNumber = Bundle.build`
    */
   internal static let build: String? = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
   /**
    * The identifier of the main bundle.
    * - Description: Retrieves the unique identifier of the main bundle of the application.
    * Example: `let bundleIdentifier = Bundle.identifier`
    */
   internal static let identifier: String? = Bundle.main.object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) as? String
   /**
    * Tests if an app is in beta
    * - Abstract: determines if beta from receipt
    * - Description: Determines if the application is a beta version by
    *               checking the app store receipt URL for specific substrings that
    *               identify simulator or TestFlight environments.
    * - Note: From here: https://stackoverflow.com/a/38984554/5389500
    * - Note: More complex example: https://stackoverflow.com/a/33830605/5389500
    * - Note: Another example: https://stackoverflow.com/a/59047187/5389500
    * - Note: Might have become broken in iOS 13
    * - Note: If it fails there might be a fix here: https://stackoverflow.com/a/52232267/5389500
    * - Note: Seems like this can determine if an app is beta: https://developer.apple.com/documentation/appstoreconnectapi/list_all_builds_of_an_app
    * - Fixme: ⚠️️  Here is code that checks if something is testflight: https://gist.github.com/lukaskubanek/cbfcab29c0c93e0e9e0a16ab09586996
    * fix. we could make BundleError enum BundleError: Error { case appStoreReceiptURLNotFound }
    * Example: `let isBeta = Bundle.isBeta`
    */
   public static var isBeta: Bool { // was named: isSimulatorOrTestFlight
      // Retrieves the path of the app store receipt URL, if it exists.
      guard let path: String = Bundle.main.appStoreReceiptURL?.path else {
         Swift.print("isBeta - appStoreReceiptURL not found")
         return false
      }
      // Determines if the application is running in a simulator environment by checking for "CoreSimulator" in the app store receipt URL path.
      let isSimulator: Bool = path.contains("CoreSimulator") // Can also use #if !targetEnvironment(simulator)  #else #endif here
      // Determines if the app is distributed via TestFlight by checking for "sandboxReceipt" in the app store receipt URL path.
      let isTestFlight: Bool = path.contains("sandboxReceipt")
      return isSimulator || isTestFlight
   }
}
