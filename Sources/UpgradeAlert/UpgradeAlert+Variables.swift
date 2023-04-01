import Foundation
/**
 * Variables
 */
extension UpgradeAlert {
   internal static var isRequired = false // isSkippable, encouraged // Boolean flag if selected means this is going to be a force upgrade. If not selected indicates it's not a force upgrade.
   internal static var updateButtonTitle: String = "Update Available"
   internal static var laterButtonTitle: String = "Not now"
   // - Fixme: ⚠️️ rename to title
   internal static var alertTitle: String = "New version"
}
/**
 * Getters
 */
extension UpgradeAlert {
   /**
    * Alert message
    * - Fixme: ⚠️️ rename to message?
    */
   internal static var alertMessage: AlertMessage = { version in
      if let appName = Bundle.name {
         return "\(appName) Version \(version) is available on the AppStore." // An optional message which you want to show to the user when user will be alerted for the force update.
      } else {
         return "Version \(version) is available on AppStore."
      }
   }
   /**
    * appInfo request url
    * - Fixme: ⚠️️ rename to appInfoRequestURL?
    */
   internal static var requestURL: URL? {
      guard let bundleId = Bundle.identifier else { return nil }
      let requestURLStr = "https://itunes.apple.com/lookup?bundleId=\(bundleId)" // might need country code
      return .init(string: requestURLStr)
   }
}
/**
 * Typealias
 */
extension UpgradeAlert {
   /**
    * - Fixme: ⚠️️ : add appName as a parm as well
    * - Fixme: ⚠️️ rename to UAAlertMessage?
    */
   public typealias AlertMessage = (_ version: String) -> String
   public typealias Complete = (_ outcome: UAOutcome) -> Void
   public static let defaultComplete: Complete = { _ in }
}
/**
 * Setter
 */
extension UpgradeAlert {
   public static var config: UAConfig = .defaultConfig {
      didSet {
         Self.isRequired = config.isRequired
         Self.alertTitle = config.alertTitle
         Self.alertMessage = config.alertMessage
         Self.laterButtonTitle = config.laterButtonTitle
         Self.updateButtonTitle = config.updateButtonTitle
      }
   }
}
