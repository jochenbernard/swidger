import SwiftUI

@Observable
@MainActor
class DevelopCommandsViewModel {
    private let factory: AppFactory
    private let applicationSupportDirectoryURL: URL

    var useMockData: Bool {
        get { factory.useMockData }
        set { factory.useMockData = newValue }
    }

    init(
        factory: AppFactory,
        applicationSupportDirectoryURL: URL
    ) {
        self.factory = factory
        self.applicationSupportDirectoryURL = applicationSupportDirectoryURL
    }

    func openApplicationSupportDirectory() {
        NSWorkspace.shared.open(applicationSupportDirectoryURL)
    }
}
