import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif
/**
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
    * - Remark: shows alert with one or two btns
    * - Parameter: withConfirmation You can force the update by calling, Or the user can choose if they want to update now or later by calling
    * - Remark: Version of the app you want to mark for the update. For example, 1.0.0 // This is the version you want the user to force upgrade to a newer version.
    * - Fixme: ⚠️️ Add onAppStoreOpenComplete -> ability to track how many update etc
    * - Fixme: ⚠️️ Use Result instead etc
    * - Parameter complete: A closure that is called when the update check is complete. It returns an optional AppInfo object and an optional NSError object. If an error occurs during the update check, the NSError object describes the error. If the update check is successful, the AppInfo object contains information about the app.
    */
	public static func checkForUpdates(complete: Complete? = defaultComplete) { // complete: (_ appInfo: AppInfo?, error: NSError?)
		// Perform network calls on a background thread
      DispatchQueue.global(qos: .background).async { // Execute the following code in the background
         getAppInfo { appInfo, error in // Call the getAppInfo function with a completion handler that receives appInfo and error parameters
            // Fetch app information
            guard let localVersion: String = Bundle.version, error == nil else { // Check if localVersion is not nil and there is no error
               complete?(.error(error: error ?? .bundleErr(desc: "Err, bundle.version"))); // If not, return an error
               return // Exit the function
            }
            guard let appInfo: AppInfo = appInfo, error == nil else { // Check if appInfo is not nil and there is no error
               complete?(.error(error: error ?? .invalidResponse(description: "Err, no appInfo"))); // If not, return an error
               return // Exit the function
            }
            // Check if there is a new version available
				let needsUpdate: Bool = ComparisonResult.compareVersion(current: localVersion, appStore: appInfo.version) == .requiresUpgrade
            guard needsUpdate else { complete?(.updateNotNeeded); return } // Check if an update is needed, if not, return without prompting the user
				// If an update is needed, show an alert on the main thread
            DispatchQueue.main.async { // Execute the following code on the main thread
               Self.showAlert(appInfo: appInfo, complete: complete) // Call the showAlert function with the appInfo and complete parameters
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
    * Retrieves information about the app from the App Store.
    * - Remark: The URL will work if the app is available for all markets, but if the app is removed from some countries, the URL won't work. The language code must be added. For more information, see: https://medium.com/usemobile/get-app-version-from-app-store-and-more-e43c5055156a
    * - Note: More url and json parsing here: https://github.com/appupgrade-dev/app-upgrade-ios-sdk/blob/main/Sources/AppUpgrade/AppUpgradeApi.swift
    * - Note: https://medium.com/usemobile/get-app-version-from-app-store-and-more-e43c5055156a
    * - Note: Discussing this solution: https://stackoverflow.com/questions/6256748/check-if-my-app-has-a-new-version-on-appstore
    * - Fixme: ⚠️️ Add timeout interval and local cache pollacy: https://github.com/amebalabs/AppVersion/blob/master/AppVersion/Source/AppStoreVersion.swift
    * - Parameter completion: A closure that is called when the app information retrieval is complete. It returns an optional AppInfo object and an optional UAError object. If an error occurs during the retrieval, the UAError object describes the error. If the retrieval is successful, the AppInfo object contains information about the app.
    * - Fixme: ⚠️ make alias for type
    * ## Examples:
    * let url = URL(string: "http://www.")
    */
   private static func getAppInfo(completion: ((AppInfo?, UAError?) -> Void)?) { /*urlStr: String, */
      // Check if the request URL is valid
      guard let url: URL = requestURL else { completion?(nil, UAError.invalideURL); return }
      // Create a data task to fetch app information
      let task = URLSession.shared.dataTask(with: url) { data, _, error in
         do {
            guard let data = data, error == nil else { throw NSError(domain: error?.localizedDescription ?? "data not available", code: 0) } // Check if data is not nil and there is no error, if not, throw an error
            let result = try JSONDecoder().decode(LookupResult.self, from: data) // Decode the data using JSONDecoder
            guard let info: AppInfo = result.results.first else { throw NSError(domain: "no app info", code: 0) } // Check if there is app info, if not, throw an error
            completion?(info, nil) // Call the completion handler with the app info and no error
         } catch {
            // Handle potential errors during data fetching and decoding
            completion?(nil, UAError.invalidResponse(description: error.localizedDescription))
         }
      }
      task.resume() // Start the data task to fetch app information
   }
}

/**
 * Alert
 */
extension UpgradeAlert {
   /**
    * Presents an alert to the user that prompts them to update the app.
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
    *   - appInfo: An AppInfo object that contains information about the app. This information is used to populate the alert.
    *   - complete: A closure that is called when the user interacts with the alert. It returns an optional Complete object that describes the user's action (e.g., whether they chose to update now, update later, or encountered an error).
    */
   public static func showAlert(appInfo: AppInfo, complete: Complete? = defaultComplete) { // Fix mark ios
      #if os(iOS)
      // Create an alert with the app information
      let alert = UIAlertController(title: config.alertTitle, message: config.alertMessage(nil, appInfo.version), preferredStyle: .alert)
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
         guard UIApplication.shared.canOpenURL(appStoreURL) else { Swift.print("err, can't open url"); return } // Check if the App Store URL can be opened, if not, print an error message and return
         UIApplication.shared.open(appStoreURL, options: [:], completionHandler: { _ in complete?(.didOpenAppStoreToUpdate) }) // Open the App Store URL and call the completion handler with the .didOpenAppStoreToUpdate action
      }
      alert.addAction(updateButton)
      // Present the alert
      alert.present()
      #elseif os(macOS)
      NSAlert.present(question: config.alertTitle, text: config.alertMessage(nil, appInfo.version), okTitle: config.updateButtonTitle, cancelTitle: config.isRequired ? nil : config.laterButtonTitle) { answer in
         if answer == true { // answer
            // - Fixme: ⚠️️ move appStoreURL into const?
            guard let appStoreURL: URL = .init(string: "macappstore://showUpdatesPage") else { complete?(.error(error: .invalidAppStoreURL)); return } // "macappstore://itunes.apple.com/app/id403961173?mt=12"
            NSWorkspace.shared.open(appStoreURL) // From here: https://stackoverflow.com/a/5656762/5389500
         }
      }
      #endif
   }
}