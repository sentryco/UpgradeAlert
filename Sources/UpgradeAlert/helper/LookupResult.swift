import Foundation
/**
 * `LookupResult` is a struct that conforms to the `Decodable` protocol.
 * - Description: Represents the result of a lookup operation in the Apple App
 *                Store API, encapsulating the relevant app information fetched.
 * - Note: It is used to parse the JSON response from the Apple App Store API.
 * - Note: The parsed data is stored in the `results` array, which contains instances of `AppInfo`.
 * - Note: This struct is part of the `UpgradeAlert` module, specifically under the `helper` directory.
 */
struct LookupResult: Decodable {
   // `results` is an array of `AppInfo` instances.
   // Each `AppInfo` instance represents the information of an app retrieved from the Apple App Store API.
   // Description: An array holding the app information fetched from the Apple App Store API.
   let results: [AppInfo]
}
