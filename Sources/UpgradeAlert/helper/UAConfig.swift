import Foundation

/**
 * This struct is used to configure the Upgrade Alert (UA).
 * It contains all the necessary parameters to customize the alert message.
 */
public struct UAConfig {
   // Determines whether the upgrade is mandatory or optional.
   let isRequired: Bool 
   
   // The title of the alert.
   let alertTitle: String 
   
   // The message of the alert. It's a function that takes the app name and version as parameters.
   let alertMessage: UpgradeAlert.AlertMessage 
   
   // The title of the button that allows the user to postpone the upgrade.
   let laterButtonTitle: String
   
   // The title of the button that initiates the upgrade.
   let updateButtonTitle: String

   /**
    * Initializes a new UAConfig with the given parameters.
    *
    * - Parameters:
    *   - isRequired: A boolean indicating whether the upgrade is mandatory.
    *   - alertTitle: The title of the alert.
    *   - alertMessage: A function that generates the alert message.
    *   - laterButtonTitle: The title of the 'Later' button.
    *   - updateButtonTitle: The title of the 'Update' button.
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
 * Extension of UAConfig to provide a default configuration.
 */
extension UAConfig {
   /**
    * Provides a default configuration for the alert.
    * This can be used when no specific configuration is provided.
    */
   public static let defaultConfig: UAConfig = {
      .init(
         isRequired: false, // By default, upgrades are not mandatory.
         alertTitle: "Update available", // Default alert title.
         alertMessage: { appName, version in
            if let appName = appName ?? Bundle.name {
               // Default alert message when app name is available.
               return "\(appName) Version \(version) is available on the AppStore."
            } else {
               // Default alert message when app name is not available.
               return "Version \(version) is available on the AppStore."
            }
         },
         laterButtonTitle: "Later", // Default 'Later' button title.
         updateButtonTitle: "Update Now" // Default 'Update' button title.
      )
   }()
}