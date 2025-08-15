import Foundation

@Observable
@MainActor
class WidgetLayoutStore {
    private let manager: WidgetLayoutManagerProtocol

    // swiftlint:disable:next discouraged_optional_collection
    private(set) var layouts: [WidgetLayout.ID: WidgetLayout]?

    init(manager: WidgetLayoutManagerProtocol) {
        self.manager = manager

        self.update()
    }

    func update() {
        layouts = manager.getAll().reduce(into: [:]) { layouts, layout in
            layouts[layout.id] = layout
        }
    }

    static var mock: WidgetLayoutStore {
        let layouts = (0..<4).map { index in
            WidgetLayout(
                id: UUID(),
                name: "Widget Layout \(index + 1)"
            )
        }

        return WidgetLayoutStore(
            manager: MockWidgetLayoutManager(
                layouts: layouts
            )
        )
    }
}
