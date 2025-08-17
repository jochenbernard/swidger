import Foundation

struct AppViewModel {
    private let store: WidgetLayoutStore
    private let importer: WidgetLayoutImporterViewModel

    let list: WidgetLayoutListViewModel
    let settings: SettingsViewModel
    let develop: DevelopViewModel

    init(
        store: WidgetLayoutStore,
        importer: WidgetLayoutImporterViewModel,
        list: WidgetLayoutListViewModel,
        settings: SettingsViewModel,
        develop: DevelopViewModel
    ) {
        self.store = store
        self.importer = importer

        self.list = list
        self.settings = settings
        self.develop = develop
    }

    func open(url: URL) {
        if url.scheme == "swidger" {
            applyFrom(url: url)
        } else {
            importFrom(url: url)
        }
    }

    private func applyFrom(url: URL) {
        guard
            let components = URLComponents(
                url: url,
                resolvingAgainstBaseURL: true
            ),
            components.host == "apply-widget-layout",
            let name = components.queryItems?.first(where: { $0.name == "name" })?.value,
            let layout = store.layouts?.first(where: { $0.value.name == name })?.value
        else {
            return
        }

        store.apply(layout)
    }

    private func importFrom(url: URL) {
        do {
            try importer.importFrom(url: url)
        } catch {
            assertionFailure(String(describing: error))
        }
    }
}
