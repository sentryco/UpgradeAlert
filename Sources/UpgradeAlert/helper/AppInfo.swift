import Foundation
/**
 * - Remark: it's possible to get more info like rating, release date, release notes etc etc see here: https://github.com/amebalabs/AppVersion/blob/master/AppVersion/Source/AppStoreVersion.swift
 * - Fixme: ⚠️️ Rename to UAAppInfo?
 * - Fixme: ⚠️️ add doc
 */
public struct AppInfo: Decodable {
   public let version: String
   public let trackViewUrl: String // make this optional? since macOS might not use it?
   /**
    * - Parameters:
    *   - version: - Fixme: ⚠️️ add doc
    *   - trackViewUrl: - Fixme: ⚠️️ add doc
    */
   public init(version: String, trackViewUrl: String) {
      self.version = version
      self.trackViewUrl = trackViewUrl
   }
}
