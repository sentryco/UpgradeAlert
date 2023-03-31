import XCTest
@testable import UpgradeAlert

final class UpgradeAlertTests: XCTestCase {
   /**
    * Test parsing json from remote server
    * - Fixme: ⚠️️ Add code from NTPTime project
    * - Fixme: ⚠️️ Needs a window to test this etc
    * - remark: replace url - your url here
    */
   func testExample() throws {
      guard Bundle.isBeta else { Swift.print("App is beta or simulator, skip checking for update"); return }
      UpgradeAlert.isRequired = false // Require users to update
      UpgradeAlert.alertTitle = "Update required" // alert title
      UpgradeAlert.alertMessage = { version in "Version: \(version) is out!" } // alert msg
      UpgradeAlert.laterButtonTitle = "Later" // skip button title
      UpgradeAlert.updateButtonTitle = "Update Now" // go to appstore btn
      UpgradeAlert.checkForUpdates { outcome in // check apple endpoint if there is a new update
         if case .error(let err) = outcome {
            Swift.print("Err: \(err.localizedDescription)")
         } else { // opportunity to track user action here with GA etc
            Swift.print("Outcome: \(String(describing: outcome))") // notNow, notNeeded, appStoreOpened
         }
      }
   }
}
