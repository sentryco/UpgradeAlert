import Foundation
/**
 * Error type. So we can track if bundle id etc faults.
 * This enum is used to handle errors in a more structured way, allowing for better error handling and debugging.
 * - Description: Enumerates the various errors that can occur within the UpgradeAlert system, providing specific types for different error scenarios to facilitate precise error handling.
 */
public enum UAError: Error {
   /**
    * This error is thrown when the URL for the App Store is invalid.
    * - Description: Occurs when the URL intended to direct to the App Store is malformed or not properly formatted, preventing navigation to the App Store page.
    */
   case invalidAppStoreURL
   /**
    * This error is thrown when a general URL is invalid.
    * - Description: Occurs when a general URL that is not specifically for the App Store is malformed or not properly formatted, preventing proper URL navigation or usage.
    */
   case invalideURL
   /**
    * This error is thrown when the response from a request is invalid.
    * - Parameter description: Provides more details about the error.
    * - Description: Provides a detailed explanation of what went wrong with the response, including specifics that can help in debugging the issue.
    */
   case invalidResponse(description: String)
   /**
    * This error is thrown when there is an issue with the bundle.
    * The desc parameter provides more details about the error.
    * - Description: Indicates an error related to the application's bundle, such as missing required resources or incorrect configuration settings.
    */
   case bundleErr(desc: String)
}
