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
- 🖥 macOS apps do not auto-update by default unless the user has enabled this in the App Store settings.
- 📲 While iOS apps auto-update by default, some users may have disabled this feature.
- 🕸 Users may be stuck on an old OS version that is no longer supported.
- 🪦 Supporting outdated app versions can burden your backend and complicate code maintenance.
- 🥶 Supporting multiple versions of your app you will result in bloated app code that is hard to iterate on
- 🤬 Users may complain about issues already fixed in newer versions.
- 🥵 Outdated apps may lead to negative reviews due to bugs that have been resolved.
- 🔥 Avoid crashes by ensuring compatibility with the latest device APIs and platform updates.
- 🚨 Deliver urgent security updates to users promptly.

### Solution:
- When the current app version is outdated, the user is prompted with a link to the App Store to update.
- Two different alerts can be displayed: one where the user has the option to update later, and one where the update is mandatory.
- You can customize the alert title, message, and button texts.

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

// Skip checking for updates if the app is running in beta (e.g., simulator or TestFlight)
guard !Bundle.isBeta else {
    Swift.print("App is beta or simulator, skip checking for update")
    return
}

// Configure the alert
UpgradeAlert.config = UAConfig(
    isRequired: false, // Require users to update
    alertTitle: "Update required", // Alert title
    alertMessage: { appName, version in "Version \(version) is out!" }, // Alert message
    laterButtonTitle: "Later", // Skip button title
    updateButtonTitle: "Update Now" // Go to App Store button
)

// Check Apple endpoint to see if there is a new update
UpgradeAlert.checkForUpdates { outcome in
    switch outcome {
    case .error(let error):
        Swift.print("Error: \(error.localizedDescription)")
    case .notNow:
        Swift.print("User chose to update later.")
    case .updateNotNeeded:
        Swift.print("App is up-to-date.")
    case .didOpenAppStoreToUpdate:
        Swift.print("Redirected user to App Store for update.")
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
**A:** An **Upgrade-Wall** (or **Update-Wall**) is a system that prevents mobile app users from using the app if they are still on older versions. It ensures that all users operate on the latest version of the app.

**Q:** Why do we need an Upgrade-Wall?  
**A:** An Upgrade-Wall is necessary when you need users to update to a new version due to breaking changes, security issues, or to promote new features. For instance:

- **Breaking Changes:** If there are significant changes in the backend API that would cause older versions of the app to crash.
- **Security Issues:** When older app versions have vulnerabilities that are fixed in newer releases.
- **Feature Promotion:** To encourage users to experience new features you've introduced.

In these scenarios, an Upgrade-Wall ensures users update to the latest version, providing a consistent and secure experience.

**Q:** How do you implement an Upgrade-Wall?  
**A:** An Upgrade-Wall can be implemented using two strategies: **hard** and **soft** Upgrade-Walls.

- **Hard Upgrade-Wall:** Completely restricts users from using the app until they update.

  - Displays a non-dismissible popup with only an **Update** button when the app is opened.
  - Users cannot skip this popup and must update to continue.
  - Pressing the **Update** button redirects to the App Store or Play Store to download the latest version.

- **Soft Upgrade-Wall:** Offers flexibility, allowing users to choose whether to update immediately or later.

  - Shows a dismissible popup with options to **Update** or **Skip**.
  - Users can skip the update and continue using the app.
  - Encourages but does not force the update.

Both strategies involve showing a popup or alert to users upon opening the app. You can streamline this process by utilizing existing solutions that provide Upgrade-Wall functionality.

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

```swift
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

- Improve NSAlert Presentation
Issue: In NSAlert+Ext.swift, the code can be refactored to reduce duplication and handle more cases.
Improvement: Create a general method to 

```swift
extension NSAlert {
    internal static func present(
        messageText: String,
        informativeText: String,
        style: NSAlert.Style,
        buttons: [String],
        completion: ((NSApplication.ModalResponse) -> Void)? = nil
    ) {
        let alert = NSAlert()
        alert.messageText = messageText
        alert.informativeText = informativeText
        alert.alertStyle = style
        buttons.forEach { alert.addButton(withTitle: $0) }
        if let window = NSApplication.shared.windows.first {
            alert.beginSheetModal(for: window, completionHandler: completion)
        } else {
            print("Error: No window available to present alert.")
        }
    }
}
```
- Add Support for SwiftUI Alerts
Issue: The current implementation does not support SwiftUI, limiting its use in SwiftUI-based apps.
Improvement: Add methods to present alerts using SwiftUI.
Example Implementation:

```swift
import SwiftUI

@available(iOS 13.0, macOS 10.15, *)
public struct UpgradeAlertView: View {
    @State private var isPresented = false
    public var body: some View {
        Text("") // Placeholder
            .alert(isPresented: $isPresented) {
                Alert(
                    title: Text(config.alertTitle),
                    message: Text(config.alertMessage(nil, appInfo.version)),
                    primaryButton: .default(Text(config.updateButtonTitle), action: {
                        // Handle update action
                    }),
                    secondaryButton: config.isRequired ? nil : .cancel(Text(config.laterButtonTitle))
                )
            }
            .onAppear {
                isPresented = true
            }
    }
}
```