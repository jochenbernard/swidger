import Observation

@Observable
class WidgetLayoutEditorViewModel {
    private let store: WidgetLayoutStore

    var item: WidgetLayoutEditorItemViewModel?

    init(store: WidgetLayoutStore) {
        self.store = store
    }

    @MainActor
    func edit(_ layout: WidgetLayout) {
        item = createItem(layout: layout)
    }

    @MainActor
    func create() {
        item = createItem(layout: nil)
    }

    @MainActor
    private func createItem(layout: WidgetLayout?) -> WidgetLayoutEditorItemViewModel {
        WidgetLayoutEditorItemViewModel(
            store: store,
            layout: layout
        )
    }
}
