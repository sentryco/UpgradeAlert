import Foundation
/**
 * This struct is used to configure the Upgrade Alert (UA).
 * It contains all the necessary parameters to customize the alert message.
 * - Description: This struct configures the behavior and presentation of upgrade alerts within the application, allowing customization of alert titles, messages, and button labels based on the upgrade requirements.
 */
public struct UAConfig {
   /**
    * Determines whether the upgrade is mandatory or optional.
    * - Description: Indicates if the update is compulsory, requiring immediate action, or if it can be deferred.
    */
   let isRequired: Bool
   /**
    * The title of the alert.
    * - Description: The title displayed on the upgrade alert, informing the user of the nature of the alert.
    */
   let alertTitle: String
   /**
    * The message of the alert. It's a function that takes the app name and version as parameters.
    * - Description: Specifies the content of the alert message, dynamically generated based on the application's name and the new version available.
    */
   let alertMessage: UpgradeAlert.AlertMessage
   /**
    * The title of the button that allows the user to postpone the upgrade.
    * - Description: The title of the button that allows the user to defer the upgrade process, providing an option to initiate it at a later time.
    */
   let laterButtonTitle: String
   /**
    * The title of the button that initiates the upgrade.
    * - Description: The title of the button that initiates the upgrade process, prompting the user to immediately download and install the latest version of the application.
    */
   let updateButtonTitle: String
   /**
    * Initializes a new UAConfig with the given parameters.
    * - Description: Initializes a new instance of `UAConfig` with specified settings for the upgrade alert.
    * - Parameters:
    *   - isRequired: A boolean indicating whether the upgrade is mandatory.
    *   - alertTitle: The title of the alert.
    *   - alertMessage: A function that generates the alert message.
    *   - laterButtonTitle: The title of the 'Later' button.
    *   - updateButtonTitle: The title of the 'Update' button.
    */
   public init(
      isRequired: Bool,
      alertTitle: String,
      alertMessage: @escaping UpgradeAlert.AlertMessage,
      laterButtonTitle: String,
      updateButtonTitle: String
   ) {
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
    * - Description: Returns a default `UAConfig` instance with predefined
    *                values for alert title, message, and button titles,
    *                suitable for general use cases where a specific
    *                configuration is not necessary.
    */
   public static var defaultConfig: UAConfig {
      .init(
         isRequired: false, // By default, upgrades are not mandatory.
         alertTitle: "Update available", // Default alert title.
         alertMessage: { (appName: String?, version: String) in
            if let appName: String = appName ?? Bundle.name {
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
   }
}
