import ServiceManagement

@Observable
class AppFactory {
    private let loginItem = SMAppService.mainApp
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
        createActualWidgetLayoutManager()
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

    private func createWidgetLayoutEditorViewModel(store: WidgetLayoutStore) -> WidgetLayoutEditorViewModel {
        WidgetLayoutEditorViewModel(store: store)
    }

    private func createWidgetLayoutImporterViewModel(store: WidgetLayoutStore) -> WidgetLayoutImporterViewModel {
        WidgetLayoutImporterViewModel(store: store)
    }

    private func createWidgetLayoutExporterViewModel() -> WidgetLayoutExporterViewModel {
        WidgetLayoutExporterViewModel()
    }

    @MainActor
    private func createWidgetLayoutListViewModel(
        store: WidgetLayoutStore,
        importer: WidgetLayoutImporterViewModel
    ) -> WidgetLayoutListViewModel {
        WidgetLayoutListViewModel(
            store: store,
            editor: createWidgetLayoutEditorViewModel(store: store),
            importer: importer,
            exporter: createWidgetLayoutExporterViewModel()
        )
    }

    @MainActor
    private func createSettingsViewModel() -> SettingsViewModel {
        SettingsViewModel(
            loginItem: loginItem,
            userDefaults: userDefaults
        )
    }

    private func createDevelopViewModel() -> DevelopViewModel {
        DevelopViewModel(
            factory: self,
            applicationSupportDirectoryURL: applicationSupportDirectoryURL
        )
    }

    @MainActor
    func createAppViewModel() -> AppViewModel {
        let store = createWidgetLayoutStore()
        let importer = createWidgetLayoutImporterViewModel(store: store)

        return AppViewModel(
            store: store,
            importer: importer,
            list: createWidgetLayoutListViewModel(
                store: store,
                importer: importer
            ),
            settings: createSettingsViewModel(),
            develop: createDevelopViewModel()
        )
    }
}
