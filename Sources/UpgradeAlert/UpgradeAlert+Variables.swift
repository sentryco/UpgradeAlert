import Foundation
/**
 * Getters
 */
extension UpgradeAlert {
   /**
    * Computed property to generate the request URL for app information.
    * It uses the bundle identifier of the current app to create the URL.
    * - Returns: A URL pointing to the app's information on iTunes.
    * - Note: This URL might need a country code for region-specific apps.
    * - Fixme: ⚠️️ Consider renaming this to appInfoRequestURL for clarity.
    */
   internal static var requestURL: URL? {
      guard let bundleId: String = Bundle.identifier else { return nil } // Get the bundle identifier of the app, if it's not available, return nil
      let requestURLStr: String = "https://itunes.apple.com/lookup?bundleId=\(bundleId)" // Create a URL string with the bundle identifier
      return .init(string: requestURLStr) // Return the URL as a URL object
   }
}
/**
 * Typealias
 */
extension UpgradeAlert {
   /**
    * Typealias for a function that generates an alert message.
    * - Parameters:
    *   - appName: The name of the app. This can be nil.
    *   - version: The version of the app.
    * - Returns: A string that is the alert message.
    * - Fixme: ⚠️️ Consider adding appName as a parameter for more flexibility.
    * - Fixme: ⚠️️ Consider renaming this to UAAlertMessage for consistency.
    */
   public typealias AlertMessage = (_ appName: String?, _ version: String) -> String
   /**
    * Typealias for a completion handler function.
    * - Parameters:
    *   - outcome: The outcome of the operation, encapsulated in a UAOutcome object.
    * - Note: This function does not return a value.
    */
   public typealias Complete = (_ outcome: UAOutcome) -> Void
   /**
    * Default completion handler function.
    * This function simply prints the outcome of the operation.
    */
   public static let defaultComplete: Complete = { outcome in Swift.print("default complete - outcome: \(String(describing: outcome))")}
}
/**
 * Setter
 */
extension UpgradeAlert {
   /**
    * Static property to hold the configuration for UpgradeAlert.
    * - Note: By default, it uses the default configuration defined in UAConfig.
    */
   public static var config: UAConfig = .defaultConfig
}