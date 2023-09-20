import Foundation
/**
 * Error type. So we can track if bundle id etc faults.
 * This enum is used to handle errors in a more structured way, allowing for better error handling and debugging.
 */

public enum UAError: Error {
   // This error is thrown when the URL for the App Store is invalid.
   case invalidAppStoreURL
   
   // This error is thrown when a general URL is invalid.
   case invalideURL
   
   // This error is thrown when the response from a request is invalid.
   // The description parameter provides more details about the error.
   case invalidResponse(description: String)
   
   // This error is thrown when there is an issue with the bundle.
   // The desc parameter provides more details about the error.
   case bundleErr(desc: String)
}