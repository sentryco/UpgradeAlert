#if os(macOS)
import Cocoa

extension NSAlert {
   /**
    * ## Examples:
    * NSAlert.present(question: "Ok?", text: "Choose your answer.") { answer in
    *   print(answer)
    * }
    * Presents an alert to the user.
    * - Parameters:
    *   - message: The main text of the alert.
    *   - title: The title of the alert.
    *   - okTitle: The text for the OK button. Defaults to "OK".
    *   - cancelTitle: The text for the cancel button. Defaults to "Cancel".
    *   - view: The view to present the alert from. If nil, the alert is presented from the first window of the application.
    *   - complete: A closure that is called when the user dismisses the alert. The closure takes a single Boolean parameter that is true if the user clicked the OK button and false otherwise.
    */
   internal static func present(question: String, text: String, okTitle: String? = "OK", cancelTitle: String? = "Cancel", view: NSView? = nil, complete: ((_ answer: Bool) -> Void)?) {
      let alert = NSAlert()
      alert.messageText = question
      alert.informativeText = text
      alert.alertStyle = .warning
      if let okTitle = okTitle { alert.addButton(withTitle: okTitle) }
      if let cancelTitle = cancelTitle { alert.addButton(withTitle: cancelTitle) }
      if let win: NSWindow = view?.window ?? NSApplication.shared.windows.first {
         alert.beginSheetModal(for: win, completionHandler: { (modalResponse: NSApplication.ModalResponse) -> Void in
            if modalResponse == .alertFirstButtonReturn {
               complete?(true)
            } else {
               complete?(false)
            }
         })
      } else {
         Swift.print("no window")
      }
   }
}
#endif
//if anAlert.runModal() == .alertFirstButtonReturn {
//   return .terminateNow
//}
//return .terminateLater
