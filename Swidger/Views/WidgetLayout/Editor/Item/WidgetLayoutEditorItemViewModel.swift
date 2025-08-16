import Foundation

@Observable
@MainActor
class WidgetLayoutEditorItemViewModel: Identifiable {
    private let store: WidgetLayoutStore
    private let layout: WidgetLayout?

    var name: String
    var icon: WidgetLayoutIcon
    var color: WidgetLayoutColor

    var mode: Mode {
        if layout != nil {
            .edit
        } else {
            .create
        }
    }

    var trimmedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var isValid: Bool {
        let name = trimmedName
        return (
            !name.isEmpty &&
            store.layouts?.contains { existingLayout in
                existingLayout.value.id != layout?.id &&
                existingLayout.value.name == name
            } == false
        )
    }

    init(
        store: WidgetLayoutStore,
        layout: WidgetLayout?
    ) {
        self.store = store
        self.layout = layout

        self.name = layout?.name ?? ""
        self.icon = layout?.icon ?? .square
        self.color = layout?.color ?? .blue
    }

    func confirm() {
        guard isValid else {
            return
        }

        if let layout {
            edit(layout)
        } else {
            create()
        }
    }

    private func edit(_ layout: WidgetLayout) {
        store.edit(
            WidgetLayout(
                id: layout.id,
                name: name,
                icon: icon,
                color: color,
                uiDefaults: layout.uiDefaults
            )
        )
    }

    private func create() {
        store.add(
            WidgetLayout(
                id: UUID().uuidString,
                name: name,
                icon: icon,
                color: color,
                uiDefaults: Data()
            )
        )
    }

    enum Mode {
        case edit
        case create
    }
}
