import Foundation

@Observable
@MainActor
class WidgetLayoutListViewModel {
    private let store: WidgetLayoutStore

    let editor: WidgetLayoutEditorViewModel

    // swiftlint:disable:next discouraged_optional_collection
    private(set) var layouts: [WidgetLayout]?

    init(store: WidgetLayoutStore) {
        self.store = store

        self.editor = WidgetLayoutEditorViewModel(store: store)

        self.trackLayouts()
    }

    private func trackLayouts() {
        withObservationTracking(updateLayouts) {
            Task { @MainActor [weak self] in
                self?.trackLayouts()
            }
        }
    }

    private func updateLayouts() {
        layouts = store.layouts?.values
            .sorted(by: { $0.id < $1.id })
            .sorted(by: { $0.name < $1.name })
    }

    func delete(indexSet: IndexSet) {
        let layouts = indexSet.compactMap({ self.layouts?[$0] })
        store.delete(layouts)
    }
}
