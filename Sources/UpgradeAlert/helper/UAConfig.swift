import Foundation
/**
 * Easier config of UA
 */
public struct UAConfig {
   let isRequired: Bool
   let alertTitle: String
   let alertMessage: UpgradeAlert.AlertMessage
   let laterButtonTitle: String
   let updateButtonTitle: String
   /**
    * - Fixme: ⚠️️ add doc
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
    * Default config
    */
   public static let defaultConfig: UAConfig = {
      .init(
         isRequired: false, // Require users to update
         alertTitle: "Update required", // alert title
         alertMessage: { version in "Version: \(version) is out!" }, // alert msg
         laterButtonTitle: "Later", // skip button title
         updateButtonTitle: "Update Now" // go to appstore btn
      )
   }()
}
