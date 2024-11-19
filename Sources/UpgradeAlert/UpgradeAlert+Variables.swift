import Foundation
/**
 * Getters
 */
extension UpgradeAlert {
   /**
    * Computed property to generate the request URL for app information.
    * - Note: It uses the bundle identifier of the current app to create the URL.
    * - Description: This property constructs a URL used to fetch information
    *                about the application from the iTunes API based on the
    *                application's bundle identifier.
    * - Returns: A URL pointing to the app's information on iTunes.
    * - Note: This URL might need a country code for region-specific apps.
    * - Fixme: ⚠️️ Consider renaming this to appInfoRequestURL for clarity.
    * - fix: maybe move url to const?
    */
   internal static var requestURL: URL? {
      guard let bundleId: String = Bundle.identifier else { return nil }
      let requestURLStr: String = "https://itunes.apple.com/lookup?bundleId=\(bundleId)" // might need country code
      return .init(string: requestURLStr)
   }
}
/**
 * Typealias
 */
extension UpgradeAlert {
   /**
    * Typealias for a function that generates an alert message.
    * - Description: Defines a function type used to generate a custom alert
    *                message based on the app's name and version.
    * - Parameters:
    *   - appName: The name of the app. This can be nil.
    *   - version: The version of the app.
    * - Returns: A string that is the alert message.
    * - Fixme: ⚠️️ Consider renaming this to UAAlertMessage for consistency.
    */
   public typealias AlertMessage = (_ appName: String?, _ version: String) -> String
   /**
    * Typealias for a completion handler function.
    * - Description: Defines a closure used as a completion handler to process
    *                the outcome of an update check or alert interaction.
    * - Parameters:
    *   - outcome: The outcome of the operation, encapsulated in a UAOutcome  object.
    * - Note: This function does not return a value.
    */
   public typealias Complete = (_ outcome: UAOutcome) -> Void
   /**
    * Default completion handler function.
    * - Abstract: This function simply prints the outcome of the operation.
    * - Description: This default completion handler logs the outcome of the
    *                operation to the console, providing a simple way to
    *                observe the results of the update check or alert
    *                interaction.
    */
   public static var defaultComplete: Complete {
      { (outcome: UAOutcome) in
         Swift.print("default complete - outcome: \(String(describing: outcome))")
      }
   }
}
/**
 * Setter
 */
extension UpgradeAlert {
   /**
    * Static property to hold the configuration for UpgradeAlert.
    * - Description: Holds the configuration settings for the UpgradeAlert
    *                system, which can be customized as needed.
    * - Note: By default, it uses the default configuration defined in UAConfig.
    */
   public static var config: UAConfig { .defaultConfig }
}
