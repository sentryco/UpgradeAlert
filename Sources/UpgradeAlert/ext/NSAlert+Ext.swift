#if os(macOS)
import Cocoa

extension NSAlert {
   /**
    * NSAlert.present(question: "Ok?", text: "Choose your answer.") { answer in
    *   print(answer)
    * }
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
