import Foundation
/**
 * - Remark: it's possible to get more info like rating, release date, release notes etc etc see here: https://github.com/amebalabs/AppVersion/blob/master/AppVersion/Source/AppStoreVersion.swift
 * - Fixme: ⚠️️ rename to UAAppInfo?
 */
public struct AppInfo: Decodable {
   public let version: String
   public let trackViewUrl: String
   public init(version: String, trackViewUrl: String) {
      self.version = version
      self.trackViewUrl = trackViewUrl
   }
}
