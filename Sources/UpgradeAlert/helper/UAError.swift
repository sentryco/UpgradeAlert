import Foundation
/**
 * Error type. so we can track if bundle id etc faults.
 *  - Fixme: ⚠️️ maybe just have two? invalidBundleInfo, invalidResponse
 */
public enum UAError: Error {
   case invalidAppStoreURL
   case invalideURL
   case invalidResponse(description: String)
   case bundleErr(desc: String)
}
