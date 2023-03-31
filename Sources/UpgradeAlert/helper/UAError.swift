import Foundation
/**
 * error type. so we can track if bundle id etc faults.
 */
public enum UAError: Error {
   case invalidAppStoreURL
   case invalideURL
   case invalidResponse(description: String)
   case bundleErr(desc: String)
}
// maybe just have two? invalidBundleInfo, invalidResponse
