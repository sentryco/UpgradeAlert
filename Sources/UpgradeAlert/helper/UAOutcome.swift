import Foundation
/**
 * This enum represents the possible outcomes of an upgrade alert.
 * - Fixme: ⚠️️ Consider renaming the cases to: notNow, notNeeded, appStoreOpened for better clarity.
 * - Fixme: ⚠️️ Add more detailed documentation for each case.
 */
public enum UAOutcome {
   /**
    * Represents the outcome where the app is up-to-date and no upgrade is needed.
    */
   case updateNotNeeded
   /**
    * Represents the outcome where the user has chosen to defer the upgrade.
    */
   case notNow 
   /**
    * Represents the outcome where the user has opened the App Store to perform the upgrade.
    */
   case didOpenAppStoreToUpdate 
   /**
    * Represents the outcome where an error occurred during the upgrade process.
    * - Parameter error: The error that occurred during the upgrade process.
    */
   case error(error: UAError) 
}
