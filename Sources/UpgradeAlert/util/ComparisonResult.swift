import Foundation
/**
 * This enum represents the result of a version comparison.
 * It can either be 'compatible' or 'requiresUpgrade'.
 * - Note: The 'compatible' case indicates that the local and remote versions are compatible, while the 'requiresUpgrade' case indicates that the remote version requires an upgrade.
 * - Note: For more information on version comparison, see: https://stackoverflow.com/a/27932531
 * - Note: For more advanced version comparison, see: https://stackoverflow.com/questions/70964328/compare-app-versions-after-update-using-decimals-like-2-5-2/70964516#70964516
 */
public enum ComparisonResult {
   case compatible // The local and remote versions are compatible
   case requiresUpgrade // The remote version requires an upgrade
}
extension ComparisonResult {
	/**
    * * This function compares two version strings.
	 * It uses the 'compare' function with 'numeric' options to compare the versions.
	 * - Note: from here: https://stackoverflow.com/a/55141421/5389500
	 * - Remark: Sample does not cover versions with extra zeros.(Ex: "1.0.0" & "1.0")
	 * - Note: Handles more cases: https://github.com/DragonCherry/VersionCompare
    * - Parameters:
    *   - current: "1.3" The current version of the app.
    *   - appStore: "1.2.9" The version of the app in the App Store.
    */
   static func compareVersion(current: String, appStore: String) -> ComparisonResult {
   	let versionCompare = current.compare(appStore, options: .numeric)
      switch versionCompare {
      case .orderedSame:// The current version is the same as the App Store version.
         //print("same version")
         return .compatible
      case .orderedAscending:// The current version is older than the App Store version.
         // will execute the code here
         // print("ask user to update")
         return .requiresUpgrade
      case .orderedDescending: // app-store listing hasn't updated yet, The current version is newer than the App Store version. This is an unexpected case.
         // execute if current > appStore
         // print("don't expect happen...")
         return .compatible
      }
   }
}

// potentially add skippable etc:
 /// Update-suggestion UI Alert Type, used to set the desired update workflow
 // public enum AlertType {
 //     /// Update can be skipped or postponed, presented buttons: Update, Skip, Cancel + Never(must be explicitly enabled with `neverEnabled` property)
 //     case skippable
 //     /// Update can't be skipped but can be postponed, presented buttons: Update, Cancel + Never(must be explicitly enabled with `neverEnabled` property)
 //     case unskippable
 //     /// Update can't be skipped or postponed, presented buttons: Update. App UI will be completely **BLOCKED**, use carefully
 //     case blocking
 // }
