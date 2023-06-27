#if os(macOS)
import Cocoa

extension NSAlert {
   /**
    * ## Examples:
    * NSAlert.present(question: "Ok?", text: "Choose your answer.") { answer in
    *   print(answer)
    * }
    * - Parameters:
    *   - question: - Fixme: ⚠️️ rename to message
    *   - text: - Fixme: ⚠️️ rename to title
    *   - okTitle: - Fixme: ⚠️️ add doc
    *   - cancelTitle: - Fixme: ⚠️️ add doc
    *   - view: - Fixme: ⚠️️ add doc
    *   - complete: - Fixme: ⚠️️ add doc
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
