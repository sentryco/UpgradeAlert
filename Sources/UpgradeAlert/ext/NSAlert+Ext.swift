#if os(macOS)
import Cocoa

extension NSAlert {
   /**
    * Presents a warning alert to the user with customizable text, buttons, and completion handler.
    * - Description: Displays a modal alert dialog on macOS with customizable
    *                titles for the buttons and a completion handler to capture
    *                the user's response.
    * ## Examples:
    * NSAlert.present(question: "Ok?", text: "Choose your answer.") { answer in
    *   print(answer)
    * }
    * 
    * - Parameters:
    *   - question: The main text of the alert.
    *   - text: The informative text of the alert.
    *   - okTitle: The text for the OK button. Defaults to "OK".
    *   - cancelTitle: The text for the cancel button. Defaults to "Cancel".
    *   - view: The view to present the alert from. If nil, the alert is
    *           presented from the first window of the application.
    *   - complete: A closure that is called when the user dismisses the alert.
    *               The closure takes a single Boolean parameter that is true if
    *               the user clicked the OK button and false otherwise.
    */
   internal static func present(
      question: String,
      text: String,
      okTitle: String? = "OK",
      cancelTitle: String? = "Cancel",
      view: NSView? = nil,
      complete: ((_ answer: Bool) -> Void)?
   ) {
      let alert: NSAlert = .init() // Initializes a new NSAlert object.
      alert.messageText = question // Sets the primary message text of the alert.
      alert.informativeText = text // Sets the secondary, informative text of the alert.
      alert.alertStyle = .warning // Sets the alert style to warning, indicating the nature of the alert.
      // Add OK button to the alert
      if let okTitle: String = okTitle { alert.addButton(withTitle: okTitle) }
      // Add Cancel button to the alert
      if let cancelTitle: String = cancelTitle { alert.addButton(withTitle: cancelTitle) }
      // Present the alert from the provided view's window, or from the first window of the application if no view is provided
      if let win: NSWindow = view?.window ?? NSApplication.shared.windows.first {
         // Begin the alert and handle the user's response in the completion handler
         alert.beginSheetModal(for: win, completionHandler: { (modalResponse: NSApplication.ModalResponse) -> Void in
            if modalResponse == .alertFirstButtonReturn {
               complete?(true) // User clicked OK
            } else {
               complete?(false) // User clicked Cancel or closed the alert
            }
         })
      } else {
         Swift.print("no window") // No window was available to present the alert
      }
   }
}
#endif
