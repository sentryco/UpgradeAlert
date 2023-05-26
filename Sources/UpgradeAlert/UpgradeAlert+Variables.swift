import Foundation
/**
 * Getters
 */
extension UpgradeAlert {
   /**
    * appInfo request url
    * - Fixme: ⚠️️ Rename to appInfoRequestURL?
    */
   internal static var requestURL: URL? {
      guard let bundleId: String = Bundle.identifier else { return nil }
      let requestURLStr: String = "https://itunes.apple.com/lookup?bundleId=\(bundleId)" // might need country code
      return .init(string: requestURLStr)
   }
}
/**
 * Typealias
 */
extension UpgradeAlert {
   /**
    * - Fixme: ⚠️️ Add appName as a parm as well
    * - Fixme: ⚠️️ Rename to UAAlertMessage?
    */
   public typealias AlertMessage = (_ appName: String?, _ version: String) -> String
   public typealias Complete = (_ outcome: UAOutcome) -> Void
   public static let defaultComplete: Complete = { outcome in Swift.print("default complete - outcome: \(String(describing: outcome))")}
}
/**
 * Setter
 */
extension UpgradeAlert {
   /**
    * UpgradeAlert config
    */
   public static var config: UAConfig = .defaultConfig
}
