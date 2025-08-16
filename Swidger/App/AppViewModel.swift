import Foundation

@Observable
@MainActor
class AppViewModel {
    private let fileManager: FileManager
    private let applicationSupportDirectoryURL: URL

    let developCommands: DevelopCommandsViewModel
    // swiftlint:disable:next implicitly_unwrapped_optional
    private(set) var list: WidgetLayoutListViewModel!

    init() {
        self.fileManager = FileManager.default
        self.applicationSupportDirectoryURL = .applicationSupportDirectory.appending(component: "Swidger")

        try? fileManager.createDirectory(
            at: applicationSupportDirectoryURL,
            withIntermediateDirectories: true
        )

        self.developCommands = DevelopCommandsViewModel(
            userDefaults: .standard,
            applicationSupportDirectoryURL: applicationSupportDirectoryURL
        )

        self.updateList()

        self.developCommands.app = self
    }

    func updateManagers() {
        updateList()
    }

    private func updateList() {
        if developCommands.useMockData {
            list = createMockList()
        } else {
            list = createList()
        }
    }

    private func createList() -> WidgetLayoutListViewModel {
        WidgetLayoutListViewModel(
            store: WidgetLayoutStore(
                manager: WidgetLayoutManager(
                    fileManager: fileManager,
                    directoryURL: applicationSupportDirectoryURL
                )
            )
        )
    }

    private func createMockList() -> WidgetLayoutListViewModel {
        #if DEBUG
        WidgetLayoutListViewModel(store: .mock)
        #else
        createList()
        #endif
    }
}
