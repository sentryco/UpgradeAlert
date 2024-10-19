import XCTest
@testable import UpgradeAlert
/**
 * `UpgradeAlertTests` is a test class for the UpgradeAlert module.
 * - Note: It contains unit tests to verify the functionality of the UpgradeAlert module.
 */
final class UpgradeAlertTests: XCTestCase {
   /**
    * Test parsing json from remote server
    * - Description: This test verifies the functionality of the
    *                `checkForUpdates` method by simulating an update check
    *                and capturing the outcome.
    * - Fixme: ⚠️️ Add exception handling code from NTPTime repo. This is needed to handle any exceptions that might occur while parsing the JSON.
    * - Fixme: ⚠️️ This test requires a window to run. Make sure to set up a window before running this test.
    * - remark: replace url - your url here
    */
   func testUpdateCheck() throws {
      // Skip the test if the app is in beta or running on a simulator because the update check will not work in these environments.
      guard Bundle.isBeta else {
         Swift.print("App is beta or simulator, skip checking for update")
         return
      }
      // Call the checkForUpdates function of the UpgradeAlert module and handle the outcome.
      UpgradeAlert.checkForUpdates { (outcome: UAOutcome) in
         if case .error(let err) = outcome {
            Swift.print("Err: \(err.localizedDescription)")
         } else {
            // Opportunity to track user action here with GA etc
            Swift.print("Outcome: \(String(describing: outcome))") // notNow, notNeeded, appStoreOpened
         }
      }
   }
}
