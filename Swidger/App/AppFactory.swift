import Foundation

@Observable
@MainActor
class AppFactory {
    private let fileManager = FileManager.default
    private let userDefaults = UserDefaults.standard
    private let applicationSupportDirectoryURL = URL.applicationSupportDirectory.appending(component: "Swidger")

    private let useMockDataUserDefaultsKey = "useMockData"
    var useMockData: Bool {
        didSet {
            userDefaults.set(
                useMockData,
                forKey: useMockDataUserDefaultsKey
            )
            updateManager()
        }
    }

    private var store: WidgetLayoutStore?

    init() {
        self.useMockData = userDefaults.bool(forKey: useMockDataUserDefaultsKey)
    }

    private func updateManager() {
        guard let store else {
            return
        }

        store.manager = createManager()
        store.update()
    }

    private func createMockManager() -> WidgetLayoutManagerProtocol {
        #if DEBUG
        .mock
        #else
        createActualManager()
        #endif
    }

    private func createActualManager() -> WidgetLayoutManagerProtocol {
        WidgetLayoutManager(
            fileManager: fileManager,
            directoryURL: applicationSupportDirectoryURL
        )
    }

    func createManager() -> WidgetLayoutManagerProtocol {
        if useMockData {
            createMockManager()
        } else {
            createActualManager()
        }
    }

    private func createStore() -> WidgetLayoutStore {
        guard let store else {
            let store = WidgetLayoutStore(manager: createManager())
            self.store = store
            return store
        }

        return store
    }

    func createList() -> WidgetLayoutListViewModel {
        WidgetLayoutListViewModel(store: createStore())
    }

    func createDevelopCommands() -> DevelopCommandsViewModel {
        DevelopCommandsViewModel(
            factory: self,
            applicationSupportDirectoryURL: applicationSupportDirectoryURL
        )
    }
}
