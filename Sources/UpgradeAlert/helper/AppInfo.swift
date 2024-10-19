import Foundation

/**
 * This struct represents the basic information about an application.
 * - Abstract: It includes the current version of the application and the URL
 *             to the application's page on the App Store.
 * - Description: This struct encapsulates essential details about the
 *                application, such as its current version and the URL to its App Store
 *                page, facilitating easy access to its public listing for update and
 *                review purposes.
 * - Remark: More information such as rating, release date, release notes etc.
 *           can be fetched. For more details, see:
 *           https://github.com/amebalabs/AppVersion/blob/master/AppVersion/Source/AppStoreVersion.swift
 * - Fixme: ⚠️️  Consider renaming this struct to UAAppInfo for better clarity.
 * - Fixme: ⚠️️ Add more detailed documentation for this struct and its properties.
 */
public struct AppInfo: Decodable {
   /**
    * The current version of the application.
    * - Description: Specifies the version of the application as a string,
    *                which is used to determine if an update is needed.
    */
   public let version: String
   /**
    * The URL to the application's page on the App Store.
    * - Abstract: This might be optional for macOS applications as they might
    *             not have an App Store page.
    * - Description: Specifies the URL to the application's page on the App
    *                Store, which can be used to direct users to update or
    *                review the app.
    */
   public let trackViewUrl: String
   /**
    * Initializes a new instance of `AppInfo`.
    * - Description: Initializes a new instance of `AppInfo` with the specified
    *                version and App Store URL.
    * - Parameters:
    *   - version: The current version of the application.
    *   - trackViewUrl: The URL to the application's page on the App Store.
    */
   public init(version: String, trackViewUrl: String) {
      self.version = version
      self.trackViewUrl = trackViewUrl
   }
}
