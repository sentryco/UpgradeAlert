![mit](https://img.shields.io/badge/License-MIT-brightgreen.svg)
![platform](https://img.shields.io/badge/Platform-iOS/macOS-blue.svg)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift)
[![Tests](https://github.com/sentryco/UpgradeAlert/actions/workflows/Tests.yml/badge.svg)](https://github.com/sentryco/UpgradeAlert/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/3cf70bb0-e669-4ad2-b772-e76175cd23c1)](https://codebeat.co/projects/github-com-sentryco-upgradealert-main)

# 🔔 UpgradeAlert

> Easily update your app

## Table of Contents
- [Problem](#problem)
- [Solution](#solution)
- [Screenshots](#screenshots)
- [Example](#example)
- [FAQ](#faq)
- [Gotchas](#gotchas)
- [Todo](#todo)
- [License](#license)

### Problem:
- 🖥 macOS app does not auto update by default, unless user has set this specifically in app-store.
- 📲 iOS auto update by default, but a few might have turned it off.
- 🕸 Users might be stuck on old OS. that we no longer support. In that case we need to "soft-brick" the app
- 🪦 Supporting 6+ month old app versions in your backend
- 🥶 Supporting multiple versions of your app you will result in bloated app code that is hard to iterate on
- 🤬 Users will stop complaining about issues that are already fixed in the last update
- 🥵 Users will stop giving bad reviews because of errors with old software
- 🔥 Avoid crashes by staying compatible with the latest device API changes and platform updates
- 🚨 Getting urgent security updates out to as many users as possible as quickly as possible

### Solution:
- When the current app version is outdated. The user is prompted with a link to AppStore where the user can update
- Two different alerts can be prompted. One where there is an option to update later and one where the user required to update
- You can customize alert title, message and button text

> **Warning**  
> Setting `isRequired = true` bricks the app until it's updated

### Screenshots:

**For iOS:**

<img width="405" alt="ios" src="iOS.png">  

**For macOS:**

<img width="480" alt="ios" src="macOS.png">

### Example:
```swift
import UpgradeAlert

guard Bundle.isBeta else { Swift.print("App is beta or simulator, skip checking for update"); return }
UpgradeAlert.config = UAConfig( // Config the alert
   isRequired: false, // Require users to update
   alertTitle: "Update required", // alert title
   alertMessage: { version in "Version: \(version) is out!" }, // alert msg
   laterButtonTitle: "Later", // skip button title
   updateButtonTitle: "Update Now" // go to appstore btn
)
UpgradeAlert.checkForUpdates { outcome in // check apple endpoint if there is a new update
   if case .err(let err) = outcome {
      Swift.print("Err: \(err.localizedDescription)")
   } else { // opportunity to track user action here with GA etc
      swift.print("Outcome: \(String(describing: outcome))") // notNow, notNeeded, appStoreOpened
   }
}
```
**For debugging**

```swift
// UA prompt alert test. so we can see how it looks etc.
UpgradeAlert.showAlert(appInfo: .init(version: "1.0.1", trackViewUrl: "https://apps.apple.com/app/id/com.MyCompany.MyApp"))
```

### FAQ:
**Q:** What is an Upgrade-Wall?  
**A:** Upgrade-Wall or Update-Wall is a system/service that prevents mobile app users from using the app who are still using the older versions of the app.

**Q:** Why do we need Upgrade-Wall?  
**A:** A required upgrade may be required when there are breaking changes in the backend API which will result in an app crash or when there are security issues in older apps and a new version of the app is released and you may want to require users to update to the newly released version. Also in cases where you want to encourage users to update your app to the newly released versions because you have launched a new cool feature and want users to explore and use it. In these scenarios, Upgrade-Wall is necessary to have in place.

**Q:** How to Implement Upgrade-Wall?  
**A:** Upgrade-Wall can be implemented with two strategies, hard and soft Upgrade-Walls. A Hard Upgrade-Wall completely restricts the users from using the app and requires them to update the app. A Soft Upgrade-Wall offers greater flexibility to users, generally giving users the freedom to either update the app or skip the update to a later time. Both the strategies can be implemented by showing a popup/alert to users. When the user opens the app, Hard Upgrade-Wall will show a non-dismissible popup with only an update button. Users cannot skip the popup and will have only one option to update the app. On pressing the update button the app should open the play store or AppStore of the app from where the user can update the app to the latest version. Soft Upgrade-Wall will show a dismissible popup to the user with options to either update the app or skip. Users can skip and continue using the app. An example of Hard Upgrade-Wall and Soft Upgrade-Wall. You can skip the pain of building an Upgrade-Wall yourself and use solutions which are already there.

### Gotchas:
- For macOS `applicationDidBecomeActive` will be called after dismissing the UpgradeAlert, make sure you init UpgradeAlert from another method or else it will create an inescapable loop. This does not apply for iOS.

### Todo:
- Add screenshot from a test app? ✅ 
- Add support for testflight. There is a repo in issues with a link to another repo that recently added support for this
- Add country-code to json. en -> english etc. (later)
- Add localization support
- Add support for: SKStoreProductViewController allowing the update to be initiated in-app. see https://github.com/rwbutler/Updates/ for code
- Maybe add 1 day delay to showing update alert: to avoid an issue where Apple updates the JSON faster than the app binary propogates to the App Store. https://github.com/amebalabs/AppVersion/blob/master/AppVersion/Source/%20Extensions/Date%2BAppVersion.swift
- Doc params
- Clean up comments
- Add support for swiftui
- Error Handling and Reporting: The current implementation of error handling in various parts of the codebase could be improved for better clarity and functionality. For instance: UpgradeAlert.swift: The method checkForUpdates uses a simple closure that returns an optional error. This could be enhanced by using a Result type to make the success and error handling paths clearer and more robust. 
- UIAlertController+Ext.swift: The present method does not handle the scenario where there is no view controller available to present the alert. This could lead to silent failures in presenting critical update alerts.
- Refactoring and Code Simplification_ Refactoring some parts of the code could improve readability and maintainability. For example: UpgradeAlert+Variables.swift: The method for generating the request URL could be simplified or made more robust by handling potential errors more gracefully.
- NSAlert+Ext.swift: The method for presenting alerts in macOS could be refactored to reduce duplication and improve error handling.
- Testing and Coverage Improving tests to cover edge cases and error scenarios would enhance the reliability of the application. For instance:
- UpgradeAlertTests.swift: The test cases could be expanded to cover more scenarios, including error handling and user interaction outcomes.
- Upgrade this to Swift 6.0 (Might be a bit tricky)
- Add a way to inject text for alert. so we can localize text from the caller etc.as we might want to use .modules with localizations etc
- Enhance Error Handling with Swift's Result Type
Issue: The current implementation of asynchronous methods uses custom closures with optional parameters for error handling. This can be improved by leveraging Swift's Result type, which provides a clearer and more structured way to handle success and failure cases.
Improvement: Refactor asynchronous methods to use Result instead of optional parameters. This will make the code more readable and maintainable.

```
public final class UpgradeAlert {
    public static func checkForUpdates(completion: @escaping (Result<Void, UAError>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            getAppInfo { result in
                switch result {
                case .success(let appInfo):
                    let needsUpdate = ComparisonResult.compareVersion(
                        current: Bundle.version ?? "0",
                        appStore: appInfo.version
                    ) == .requiresUpgrade
                    guard needsUpdate else {
                        completion(.success(()))
                        return
                    }
                    DispatchQueue.main.async {
                        showAlert(appInfo: appInfo, completion: completion)
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
```

- Use Result in getAppInfo Method
Issue: The getAppInfo method currently uses a closure with optional parameters for error handling.
Improvement: Modify getAppInfo to use Result<AppInfo, UAError> in its completion handler.
Updated Code:

```swift
private static func getAppInfo(completion: @escaping (Result<AppInfo, UAError>) -> Void) {
    guard let url = requestURL else {
        completion(.failure(.invalidURL))
        return
    }
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
        if let error = error {
            completion(.failure(.invalidResponse(description: error.localizedDescription)))
            return
        }
        guard let data = data else {
            completion(.failure(.invalidResponse(description: "No data received")))
            return
        }
        do {
            let result = try JSONDecoder().decode(LookupResult.self, from: data)
            if let appInfo = result.results.first {
                completion(.success(appInfo))
            } else {
                completion(.failure(.invalidResponse(description: "No app info available")))
            }
        } catch {
            completion(.failure(.invalidResponse(description: error.localizedDescription)))
        }
    }
    task.resume()
}
```

