import Observation

@Observable
@MainActor
class WidgetLayoutEditorViewModel {
    private let store: WidgetLayoutStore

    var item: WidgetLayoutEditorItemViewModel?

    init(store: WidgetLayoutStore) {
        self.store = store
    }

    func edit(_ layout: WidgetLayout) {
        item = createItem(layout: layout)
    }

    func edit(id: WidgetLayout.ID) {
        guard let layout = store.layouts?[id] else {
            return
        }

        edit(layout)
    }

    func create() {
        item = createItem(layout: nil)
    }

    private func createItem(layout: WidgetLayout?) -> WidgetLayoutEditorItemViewModel {
        WidgetLayoutEditorItemViewModel(
            store: store,
            layout: layout
        )
    }
}
