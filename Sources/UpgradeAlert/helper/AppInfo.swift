import Foundation
/**
 * - Remark: it's possible to get more info like rating, release date, release notes etc etc see here: https://github.com/amebalabs/AppVersion/blob/master/AppVersion/Source/AppStoreVersion.swift
 * - Fixme: ⚠️️ rename to UAAppInfo?
 */
public struct AppInfo: Decodable {
   let version: String
   let trackViewUrl: String
}
