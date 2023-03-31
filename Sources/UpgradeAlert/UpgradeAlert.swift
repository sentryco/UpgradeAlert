import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import Cocoa
#endif
/**
 * - Discussion: What if a user doesn't want to update and there is no other option than to update?
 * - Discussion: If the app always show popup when getting focus. Then activate flight-mode. Launch the app again.
 * - Remark: title and message are optional, default values are used if nil etc
 * - Remark: Even if the website is not update with the latest versions. Apps will continue to work etc.
 * - Fixme: ⚠️️ add config as a struct? add alert config as a struct? or not?
 * - Fixme: ⚠️️ add the 1 day delay. will require release date to be parsed
 */
public final class UpgradeAlert {}

extension UpgradeAlert {
   /**
    * Check for updates
    * - Remark: shows alert with one or two btns
    * - Parameter: withConfirmation You can force the update by calling, Or the user can choose if they want to update now or later by calling
    *  Version of the app you want to mark for the update. For example, 1.0.0 // This is the version you want the user to force upgrade to a newer version.
    * - Fixme: ⚠️️ add onAppStoreOpenComplete -> ability to track how many update etc
    * - Fixme: ⚠️️ use Result instead etc
    */
	public static func checkForUpdates(complete: Complete? = defaultComplete) { // complete: (_ appInfo: AppInfo?, error: NSError?)
		DispatchQueue.global(qos: .background).async { // network calls goes on the background thread
         getAppInfo { appInfo, error in
            guard let localVersion: String = Bundle.version, error == nil else { complete?(.error(error: error ?? .bundleErr(desc: "Err, bundle.version"))); return } // guard let currentVersion: String = Bundle.version else { throw NSError(domain: "Err, bundle", code: 0) }
            guard let appInfo: AppInfo = appInfo, error == nil else { complete?(.error(error: error ?? .invalidResponse(description: "Err, no appInfo"))); return }
				let needsUpdate: Bool = ComparisonResult.compareVersion(current: localVersion, appStore: appInfo.version) == .requiresUpgrade
				guard needsUpdate else { complete?(.updateNotNeeded); return } // No update needed, don't prompt user
				DispatchQueue.main.async {  // UI goes on the main thread
					Self.showAlert(appInfo: appInfo, complete: complete)
				}
         } // call network
		}
	}
}
/**
 * Network
 */
extension UpgradeAlert {
   /**
    * let url = URL(string: "http://www.")
    * - Remark: the url will work if the app is available for all markets. but if the app is removed from some countries. the url wont work. language code must be added etc: see: https://medium.com/usemobile/get-app-version-from-app-store-and-more-e43c5055156a
    * - Note: more url and json parsing here: https://github.com/appupgrade-dev/app-upgrade-ios-sdk/blob/main/Sources/AppUpgrade/AppUpgradeApi.swift
    * - - Fixme: ⚠️️ add timeout interval and local chache pollacy: https://github.com/amebalabs/AppVersion/blob/master/AppVersion/Source/AppStoreVersion.swift
    * - Note: https://medium.com/usemobile/get-app-version-from-app-store-and-more-e43c5055156a
    * - Note: Discussing this solution: https://stackoverflow.com/questions/6256748/check-if-my-app-has-a-new-version-on-appstore
    */
   private static func getAppInfo(completion: ((AppInfo?, UAError?) -> Void)?) { /*urlStr: String, */
      guard let url: URL = requestURL else { completion?(nil, UAError.invalideURL); return }
      let task = URLSession.shared.dataTask(with: url) { data, _, error in
         do {
            guard let data = data, error == nil else { throw NSError(domain: error?.localizedDescription ?? "data not available", code: 0) }
            let result = try JSONDecoder().decode(LookupResult.self, from: data)
            guard let info: AppInfo = result.results.first else { throw NSError(domain: "no app info", code: 0) }
            completion?(info, nil)
         } catch {
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
    * - Fixme: ⚠️️ unify alert code?
    * - Remark: For macOS it coud be wise to add some comment regarding setting system-wide autoupdate to avoid future alert popups etc
    * - Remark: Can be used: "itms-apps://itunes.apple.com/app/\(appId)")
    */
   private static func showAlert(appInfo: AppInfo, complete: Complete? = defaultComplete) { // Fix mark ios
      #if os(iOS)
      guard let appStoreURL: URL = .init(string: appInfo.trackViewUrl) else { complete?(.error(error: .invalidAppStoreURL)); return } // Needed when opeing the app in appstore
      let alertController = UIAlertController(title: alertTitle, message: alertMessage(appInfo.version), preferredStyle: .alert)
      if !isRequired { // aka withConfirmation
         let notNowButton = UIAlertAction(title: laterButtonTitle, style: .default) { (_: UIAlertAction) in
            complete?(.notNow)
         }
         alertController.addAction(notNowButton)
      }
      let updateButton = UIAlertAction(title: updateButtonTitle, style: .default) { (_: UIAlertAction) in
         UIApplication.shared.open(appStoreURL, options: [:], completionHandler: { _ in complete?(.didOpenAppStoreToUpdate) })
      }
      alertController.addAction(updateButton)
      alertController.present()
      #elseif os(macOS)
      NSAlert.present(question: alertTitle, text: alertMessage(appInfo.version), okTitle: updateButtonTitle, cancelTitle: isRequired ? nil : laterButtonTitle) { answer in
         Swift.print("answer: \(answer)")
         if answer == true {
            guard let url: URL = .init(string: "macappstore://showUpdatesPage") else { complete?(.error(error: .invalidAppStoreURL)); return } // "macappstore://itunes.apple.com/app/id403961173?mt=12"
            NSWorkspace.shared.open(url) // from here: https://stackoverflow.com/a/5656762/5389500
         }
      }
      #endif
   }
}
