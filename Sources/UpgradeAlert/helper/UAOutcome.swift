import Foundation
/**
 * - Fixme: ⚠️️ Rename to: notNow, notNeeded, appStoreOpened
 * - Fixme: ⚠️️ add doc
 */
public enum UAOutcome {
   case updateNotNeeded
   case notNow // userDefered
   case didOpenAppStoreToUpdate
   case error(error: UAError)
}
