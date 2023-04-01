import Foundation

extension Bundle {
	 internal static let name: String? = Bundle.main.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String
    internal static let version: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    internal static let build: String? = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    internal static let identifier: String? = Bundle.main.object(forInfoDictionaryKey: kCFBundleIdentifierKey as String) as? String
   /**
    * Tests if an app is in beta
    * Description: determines if beta from receipt
    * - Note: From here: https://stackoverflow.com/a/38984554/5389500
    * - Note: More complex example: https://stackoverflow.com/a/33830605/5389500
    * - Note: Another example: https://stackoverflow.com/a/59047187/5389500
    * - Note: Might have become broken in iOS 13
    * - Note: If it fails there might be a fix here: https://stackoverflow.com/a/52232267/5389500
    * fix: make this a var
    - seems like this can determine if an app is beta: https://developer.apple.com/documentation/appstoreconnectapi/list_all_builds_of_an_app
    */
   public static var isBeta: Bool { // isSimulatorOrTestFlight
      guard let path = Bundle.main.appStoreReceiptURL?.path else {
         Swift.print("isBeta - appStoreReceiptURL not found")
         return false
      }
//      Swift.print("isBeta - path: \(path)")
      let isSimulator: Bool = path.contains("CoreSimulator") // can also use #if !targetEnvironment(simulator)  #else #endif here
//      Swift.print("isSimulator:  \(isSimulator)")
      let isTestFlight: Bool = path.contains("sandboxReceipt")
//      Swift.print("isTestFlight:  \(isTestFlight)")
      return isSimulator || isTestFlight
   }
}
/**
 * Generates version from bundle
 * fix use the bundle version code from  get version from bundle. See DBLib, seclib, etc
 fix	use var
 */
 // static func getVersion(key: String) -> String? {
 //     guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
 //       fatalError("Couldn't find file 'Info.plist'.")
 //     }
 //     // 2 - Add the file to a dictionary
 //     let plist = NSDictionary(contentsOfFile: filePath)
 //     // Check if the variable on plist exists
 //     guard let value = plist?.object(forKey: key) as? String else {
 //       fatalError("Couldn't find key '\(key)' in 'Info.plist'.")
 //     }
 //     return value
 // }
 // static var appName: String? {
	//  guard let appName = getBundle(key: "CFBundleName") else { return nil } //Bundle.appName()
	//  return appName
 // }
