import Foundation
/**
 * This enum represents the possible outcomes of an upgrade alert.
 * - Fixme: ⚠️️ Consider renaming the cases to: notNow, notNeeded, appStoreOpened for better clarity.
 * - Fixme: ⚠️️ Add more detailed documentation for each case.
 */
public enum UAOutcome {
   case updateNotNeeded // The app is up-to-date, no upgrade is needed.
   case notNow // The user has chosen to defer the upgrade.
   case didOpenAppStoreToUpdate // The user has opened the App Store to perform the upgrade.
   case error(error: UAError) // An error occurred during the upgrade process.
}