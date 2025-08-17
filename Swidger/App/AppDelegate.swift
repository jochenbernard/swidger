import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    @MainActor let viewModel = AppFactory().createAppViewModel()

    func application(
        _: NSApplication,
        open urls: [URL]
    ) {
        for url in urls {
            viewModel.open(url: url)
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
        false
    }
}
