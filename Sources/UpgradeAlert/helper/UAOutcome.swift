import Foundation
/**
 * - Fixme: ⚠️️ Rename to: notNow, notNeeded, appStoreOpened
 * - Fixme: ⚠️️ Add more doc
 */
public enum UAOutcome {
   case updateNotNeeded
   case notNow // user-defered
   case didOpenAppStoreToUpdate
   case error(error: UAError)
}
