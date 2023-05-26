import Foundation
/**
 * Easier config of UA
 */
public struct UAConfig {
   let isRequired: Bool // isSkippable, encouraged // Boolean flag if selected means this is going to be a force upgrade. If not selected indicates it's not a force upgrade.
   let alertTitle: String // - Fixme: ⚠️️ rename to title?
   let alertMessage: UpgradeAlert.AlertMessage // - Fixme: ⚠️️ rename to message?
   let laterButtonTitle: String
   let updateButtonTitle: String
   /**
    * - Fixme: ⚠️️ add doc
    * - Fixme: ⚠️️ change title based on isRequired state?
    * - Parameters:
    *   - isRequired: - Fixme: ⚠️️ add doc
    *   - alertTitle: I.e: "New version" or "Update Available"
    *   - alertMessage: I.e: { appName, version in "Version: \(version) is out!" }
    *   - laterButtonTitle: I.e: "Not now"
    *   - updateButtonTitle: I.e: "Update"
    */
   public init(isRequired: Bool, alertTitle: String, alertMessage: @escaping UpgradeAlert.AlertMessage, laterButtonTitle: String, updateButtonTitle: String) {
      self.isRequired = isRequired
      self.alertTitle = alertTitle
      self.alertMessage = alertMessage
      self.laterButtonTitle = laterButtonTitle
      self.updateButtonTitle = updateButtonTitle
   }
}
/**
 * Const
 */
extension UAConfig {
   /**
    * Default config for the alert
    */
   public static let defaultConfig: UAConfig = {
      .init(
         isRequired: false, // Require users to update
         alertTitle: "Update available", // alert title
         alertMessage: { appName, version in
            if let appName = appName ?? Bundle.name {
               return "\(appName) Version \(version) is available on the AppStore." // An optional message which you want to show to the user when user will be alerted for the force update.
            } else {
               return "Version \(version) is available on the AppStore."
            }
         },
         laterButtonTitle: "Later", // Skip button title
         updateButtonTitle: "Update Now" // Go to appstore btn
      )
   }()
}
