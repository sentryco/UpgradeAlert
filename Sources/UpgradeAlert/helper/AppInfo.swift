import Foundation

/**
 * This struct represents the basic information about an application.
 * It includes the current version of the application and the URL to the application's page on the App Store.
 * 
 * - Remark: More information such as rating, release date, release notes etc. can be fetched. For more details, see: https://github.com/amebalabs/AppVersion/blob/master/AppVersion/Source/AppStoreVersion.swift
 * - Fixme: ⚠️️  Consider renaming this struct to UAAppInfo for better clarity.
 * - Fixme: ⚠️️ Add more detailed documentation for this struct and its properties.
 */
public struct AppInfo: Decodable {
   /**
    * The current version of the application.
    */
   public let version: String
   /**
    * The URL to the application's page on the App Store.
    * This might be optional for macOS applications as they might not have an App Store page.
    */
   public let trackViewUrl: String
   /**
    * Initializes a new instance of `AppInfo`.
    * - Parameters:
    *   - version: The current version of the application.
    *   - trackViewUrl: The URL to the application's page on the App Store.
    */
   public init(version: String, trackViewUrl: String) {
      self.version = version
      self.trackViewUrl = trackViewUrl
   }
}
