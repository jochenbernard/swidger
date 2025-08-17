import Observation
import SwiftUICommon

@Observable
@MainActor
class WidgetLayoutListViewModel {
    private let store: WidgetLayoutStore

    let editor: WidgetLayoutEditorViewModel
    let importer: WidgetLayoutImporterViewModel
    let exporter: WidgetLayoutExporterViewModel

    // swiftlint:disable:next discouraged_optional_collection
    private(set) var layouts: [WidgetLayout]?

    var selection = Set<WidgetLayout.ID>()
    var confirmation: ConfirmationModel?

    init(
        store: WidgetLayoutStore,
        editor: WidgetLayoutEditorViewModel,
        importer: WidgetLayoutImporterViewModel,
        exporter: WidgetLayoutExporterViewModel
    ) {
        self.store = store

        self.editor = editor
        self.importer = importer
        self.exporter = exporter

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
        layouts = store.layouts?.values.sorted(by: { $0.name < $1.name })
    }

    func apply(_ layout: WidgetLayout) {
        store.apply(layout)
    }

    func editSelection() {
        guard
            selection.count == 1,
            let id = selection.first,
            let layout = store.layouts?[id]
        else {
            return
        }

        editor.edit(layout)
    }

    func update(_ layout: WidgetLayout) {
        store.update(layout)
    }

    func updateSelection() {
        guard
            selection.count == 1,
            let id = selection.first,
            let layout = store.layouts?[id]
        else {
            return
        }

        update(layout)
    }

    func delete(_ layout: WidgetLayout) {
        store.delete(id: layout.id)
    }

    func deleteSelection() {
        store.delete(ids: selection)
    }

    func exportSelection() {
        let layouts = selection.compactMap({ store.layouts?[$0] })
        exporter.export(layouts)
    }
}
