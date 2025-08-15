import Foundation

@MainActor
struct AppViewModel {
    let list = WidgetLayoutListViewModel(
        store: WidgetLayoutStore(
            manager: WidgetLayoutManager(
                fileManager: .default,
                directoryURL: .applicationSupportDirectory
            )
        )
    )
}
