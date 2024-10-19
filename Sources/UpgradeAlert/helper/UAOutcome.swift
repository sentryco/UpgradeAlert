import Foundation
/**
 * This enum represents the possible outcomes of an upgrade alert.
 * - Description: Enumerates the various outcomes that can occur after
 *                presenting an upgrade alert to the user, allowing for a
 *                structured response handling based on the user's decision
 *                or any error that might occur.
 * - Fixme:       ⚠️️ Consider renaming the cases to: notNow, notNeeded,
 *                appStoreOpened for better clarity.
 * - Fixme: ⚠️️ Add more detailed documentation for each case.
 */
public enum UAOutcome {
   /**
    * Represents the outcome where the app is up-to-date and no upgrade is needed.
    * - Description: Indicates that the current version of the application
    *                is the latest available version, and no update action
    *                is required.
    */
   case updateNotNeeded
   /**
    * Represents the outcome where the user has chosen to defer the upgrade.
    * - Description: Indicates that the user has chosen to delay the upgrade
    *                process, opting to not update the application at this time.
    */
   case notNow 
   /**
    * Represents the outcome where the user has opened the App Store to perform the upgrade.
    * - Description: Indicates that the user has initiated the upgrade
    *                process by opening the App Store to download the latest
    *                version of the application.
    */
   case didOpenAppStoreToUpdate 
   /**
    * Represents the outcome where an error occurred during the upgrade process.
    * - Parameter error: The error that occurred during the upgrade process.
    * - Description: Provides details about the specific error that
    *                prevented the upgrade process from completing
    *                successfully.
    */
   case error(error: UAError) 
}
