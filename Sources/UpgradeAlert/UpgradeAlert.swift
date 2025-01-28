import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif
/**
 * - Description: The `UpgradeAlert` class manages the update notification
 *                process within an application. It checks for new versions of
 *                the app on the App Store, compares it with the current
 *                version, and alerts the user if an update is necessary.
 * - Remark: What if a user doesn't want to update and there is no other option than to update?
 * - Remark: If the app always show popup when getting focus. Then activate flight-mode. Launch the app again.
 * - Remark: Title and message are optional, default values are used if nil etc
 * - Remark: Even if the website is not update with the latest versions. Apps will continue to work etc.
 * - Fixme: ⚠️️ Add config as a struct? add alert config as a struct? or not?
 * - Fixme: ⚠️️ Add the 1 day delay. Will require release date to be parsed etc. Also this has pros and cons in terms of rollout speed etc
 */
public final class UpgradeAlert {}

extension UpgradeAlert {
   /**
    * Check for updates
    * - Description: Initiates a check for new versions of the app available
    *                on the App Store. If a newer version is found, it prompts
    *                the user with an update alert.
    * - Remark: shows alert with one or two btns
    * - Remark: Version of the app you want to mark for the update.
    *           For example, 1.0.0 // This is the version you want the user
    *           to force upgrade to a newer version.
    * - Fixme: ⚠️️ Add onAppStoreOpenComplete -> ability to track how many update etc
    * - Fixme: ⚠️️ Use Result instead etc
    * - Parameter complete: A closure that is called when the update check
    *                       is complete. It returns an optional AppInfo object
    *                       and an optional NSError object. If an error occurs
    *                       during the update check, the NSError object describes
    *                       the error. If the update check is successful, the
    *                       AppInfo object contains information about the app.
    */
	public static func checkForUpdates(complete: Complete? = defaultComplete) { // complete: (_ appInfo: AppInfo?, error: NSError?)
		// Perform network calls on a background thread
		DispatchQueue.global(qos: .background).async {
         getAppInfo { (appInfo: AppInfo?, error: UAError?) in
            // Fetch app information
            guard let localVersion: String = Bundle.version, // Check if local version is available
               error == nil // Check if there is no error
            else {
               complete?(.error(error: error ?? .bundleErr(desc: "Err, bundle.version"))); // If there is an error, complete with error
               return // Return from the function
            }
            guard let appInfo: AppInfo = appInfo, // Check if appInfo is available
               error == nil // Check if there is no error
            else {
               complete?(.error(error: error ?? .invalidResponse(description: "Err, no appInfo"))); // If there is an error, complete with error
               return // Return from the function
            }
            // Check if there is a new version available
				let needsUpdate: Bool = ComparisonResult.compareVersion(current: localVersion, appStore: appInfo.version) == .requiresUpgrade
            guard needsUpdate else {
               complete?(.updateNotNeeded); // If no update is needed, complete with updateNotNeeded and return
               return // Return from the function
            } // No update needed, don't prompt user
				// If an update is needed, show an alert on the main thread
				DispatchQueue.main.async {
					Self.showAlert(appInfo: appInfo, complete: complete)
				}
         }
		}
	}
}
/**
 * Network
 */
extension UpgradeAlert {
   /**
    * A typealias for the completion handler used in network calls to fetch `AppInfo`.
    * - Description: This completion handler is invoked after attempting to fetch app information from the App Store. It provides either the `AppInfo` object upon success or a `UAError` if an error occurred during the fetch operation.
    * - Parameters:
    *   - AppInfo?: An optional `AppInfo` object containing the app's metadata retrieved from the App Store.
    *   - UAError?: An optional `UAError` describing any error encountered during the network request.
    * - Remark: This typealias simplifies the signature of completion handlers used in asynchronous network operations within the `UpgradeAlert` module.
    */
   typealias Completion = (AppInfo?, UAError?) -> Void
   typealias Completion = (AppInfo?, UAError?) -> Void
   /**
    * - Description: Retrieves the app information from the App Store using a network request. This function fetches the JSON data from the App Store API and decodes it to `AppInfo` format, handling errors appropriately.
    * let url = URL(string: "http://www.")
    * - Remark: The url will work if the app is available for all markets. but if the app is removed from some countries. the url wont work. language code must be added etc: see: https://medium.com/usemobile/get-app-version-from-app-store-and-more-e43c5055156a
    * - Note: More url and json parsing here: https://github.com/appupgrade-dev/app-upgrade-ios-sdk/blob/main/Sources/AppUpgrade/AppUpgradeApi.swift
    * - Note: https://medium.com/usemobile/get-app-version-from-app-store-and-more-e43c5055156a
    * - Note: Discussing this solution: https://stackoverflow.com/questions/6256748/check-if-my-app-has-a-new-version-on-appstore
    * - Fixme: ⚠️️ Add timeout interval and local cache pollacy: https://github.com/amebalabs/AppVersion/blob/master/AppVersion/Source/AppStoreVersion.swift
    * - Parameter completion: A closure that is called when the app information retrieval is complete. It returns an optional AppInfo object and an optional UAError object. If an error occurs during the retrieval, the UAError object describes the error. If the retrieval is successful, the AppInfo object contains information about the app.
    * - Fixme: ⚠️ make alias for type
    */
   private static func getAppInfo(completion: Completion?) { /*urlStr: String, */
      // Check if the request URL is valid
      guard let url: URL = getRequestURL() else { completion?(nil, UAError.invalideURL); return }
      // Create a data task to fetch app information
      let task = URLSession.shared.dataTask(with: url) { data, _, error in
         do {
            guard let data = data, // Check if data is available
               error == nil // Check if there is no error
            else {
               throw NSError(domain: error?.localizedDescription ?? "data not available", code: 0) // If there is an error, throw an NSError with the error description or "data not available"
            }
            let result = try JSONDecoder().decode(LookupResult.self, from: data)
            guard let info: AppInfo = result.results.first else { // Get the first app info from the result
               throw NSError(domain: "no app info", code: 0) // If there is no app info, throw an NSError with the description "no app info"
            }
            // ⚠️️ new
            // The App Store metadata may be updated before the app binary is available, causing users to see an update prompt before they can download the update.
            // Check the currentVersionReleaseDate from the App Store response and delay prompting users if the update is very recent.
            let dateFormatter = ISO8601DateFormatter()
            if let releaseDate = dateFormatter.date(from: info.currentVersionReleaseDate) {
               let daysSinceRelease = Calendar.current.dateComponents([.day], from: releaseDate, to: Date()).day ?? 0
               if daysSinceRelease < 1 {
                     completion?(info, nil) // Do not prompt the user yet
                     return
               }
            }
            completion?(info, nil)
         } catch {
            // Handle potential errors during data fetching and decoding
            completion?(nil, UAError.invalidResponse(description: error.localizedDescription))
         }
      }
      task.resume()
   }
}
/**
 * Alert
 */
extension UpgradeAlert {
   /**
    * Example code for iOS: mark with os fence
    * - Description: Presents an alert to the user with options based on the app's update requirements. The alert informs the user about the availability of a new version and provides options to update immediately or defer the update.
    * - Remark: For macOS it coud be wise to add some comment regarding setting system-wide autoupdate to avoid future alert popups etc
    * - Remark: Can be used: "itms-apps://itunes.apple.com/app/\(appId)")
    * - Remark: "itms-apps://itunes.apple.com/app/apple-store/id375380948?mt=8"
    * - Remark: Can be used. "https://apps.apple.com/app/id\(appId)"
    * - Remark: This is public so that we can debug it before the app is released etc
    * - Note: https://stackoverflow.com/a/2337601/5389500
    * - Fixme: ⚠️️ use SKStoreProductViewController?
    * - Fixme: ⚠️️ Unify alert code? one call etc? See AlertKind for inspo etc
    * ## Examples:
    * UpgradeAlert.showAlert(appInfo: .init(version: "1.0.1", trackViewUrl: "https://apps.apple.com/app/id/com.MyCompany.MyApp")) // UA prompt alert test. so we can see how it looks etc.
    * - Parameters:
    *   - appInfo:  An AppInfo object that contains information about the app. This information is used to populate the alert.
    *   - complete: called after user press cancel or ok button ( A closure that is called when the user interacts with the alert. It returns an optional Complete object that describes the user's action (e.g., whether they chose to update now, update later, or encountered an error)
    */
   public static func showAlert(appInfo: AppInfo, complete: Complete? = defaultComplete) { // Fix mark ios
      #if os(iOS)
      // Create an alert with the app information
      let alert = UIAlertController(
         title: config.alertTitle, // Set the alert title from the config
         message: config.alertMessage(nil, appInfo.version), // Set the alert message from the config and the app version
         preferredStyle: .alert // Set the alert style to alert
      )
      if !config.isRequired { // aka withConfirmation
         // If the update is not required, add a "Not Now" button
         let notNowButton = UIAlertAction(title: config.laterButtonTitle, style: .default) { (_: UIAlertAction) in
            complete?(.notNow) // not now action
         }
         alert.addAction(notNowButton)
      }
      // Add an "Update" button that opens the app's page in the App Store
      let updateButton = UIAlertAction(title: config.updateButtonTitle, style: .default) { (_: UIAlertAction) in // update action
         guard let appStoreURL: URL = .init(string: appInfo.trackViewUrl) else { complete?(.error(error: .invalidAppStoreURL)); return } // Needed when opeing the app in appstore
         guard UIApplication.shared.canOpenURL(appStoreURL) else { Swift.print("err, can't open url"); return }
         UIApplication.shared.open(appStoreURL, options: [:], completionHandler: { _ in complete?(.didOpenAppStoreToUpdate) })
      }
      alert.addAction(updateButton)
      // Present the alert
      alert.present()
      #elseif os(macOS)
      NSAlert.present(
         question: config.alertTitle, // Set the alert question from the config
         text: config.alertMessage(nil, appInfo.version), // Set the alert text from the config and the app version
         okTitle: config.updateButtonTitle, // Set the alert OK button title from the config
         cancelTitle: config.isRequired ? nil : config.laterButtonTitle // Set the alert cancel button title from the config if it's not required
      ) { answer in // Present the alert and handle the user's answer
         if answer == true { // answer
            // - Fixme: ⚠️️ move appStoreURL into const?
            guard let appStoreURL: URL = .init(string: "macappstore://showUpdatesPage") else { complete?(.error(error: .invalidAppStoreURL)); return } // "macappstore://itunes.apple.com/app/id403961173?mt=12"
            NSWorkspace.shared.open(appStoreURL) // From here: https://stackoverflow.com/a/5656762/5389500
         }
      }
      #endif
   }
}
