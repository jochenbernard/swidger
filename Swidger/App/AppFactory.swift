import Foundation

@Observable
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
            updateWidgetLayoutManager()
        }
    }

    private var widgetLayoutStore: WidgetLayoutStore?

    init() {
        self.useMockData = userDefaults.bool(forKey: useMockDataUserDefaultsKey)
    }

    private func updateWidgetLayoutManager() {
        guard let widgetLayoutStore else {
            return
        }

        widgetLayoutStore.manager = createWidgetLayoutManager()
    }

    private func createMockWidgetLayoutManager() -> WidgetLayoutManagerProtocol {
        #if DEBUG
        .mock
        #else
        createActualManager()
        #endif
    }

    private func createActualWidgetLayoutManager() -> WidgetLayoutManagerProtocol {
        WidgetLayoutManager(
            fileManager: fileManager,
            directoryURL: applicationSupportDirectoryURL
        )
    }

    func createWidgetLayoutManager() -> WidgetLayoutManagerProtocol {
        if useMockData {
            createMockWidgetLayoutManager()
        } else {
            createActualWidgetLayoutManager()
        }
    }

    private func createWidgetLayoutStore() -> WidgetLayoutStore {
        guard let widgetLayoutStore else {
            let store = WidgetLayoutStore(manager: createWidgetLayoutManager())
            self.widgetLayoutStore = store
            return store
        }

        return widgetLayoutStore
    }

    @MainActor
    private func createWidgetLayoutListViewModel() -> WidgetLayoutListViewModel {
        WidgetLayoutListViewModel(store: createWidgetLayoutStore())
    }

    @MainActor
    private func createSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel(userDefaults: userDefaults)
    }

    private func createDevelopViewModel() -> DevelopViewModel {
        DevelopViewModel(
            factory: self,
            applicationSupportDirectoryURL: applicationSupportDirectoryURL
        )
    }

    @MainActor
    func createAppViewModel() -> AppViewModel {
        AppViewModel(
            list: createWidgetLayoutListViewModel(),
            settings: createSettingsViewModel(),
            develop: createDevelopViewModel()
        )
    }
}
