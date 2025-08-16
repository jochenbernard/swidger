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
        do {
            layouts = try manager.getAll().reduce(into: [:]) { layouts, layout in
                layouts[layout.id] = layout
            }
        } catch {
            assertionFailure(String(describing: error))
        }
    }

    func add(_ layout: WidgetLayout) {
        do {
            try manager.add(layout)
        } catch {
            assertionFailure(String(describing: error))
        }
        update()
    }

    func edit(_ layout: WidgetLayout) {
        do {
            try manager.edit(layout)
        } catch {
            assertionFailure(String(describing: error))
        }
        update()
    }

    func delete(id: WidgetLayout.ID) {
        do {
            try manager.delete(id: id)
        } catch {
            assertionFailure(String(describing: error))
        }
        update()
    }

    func delete(ids: Set<WidgetLayout.ID>) {
        for id in ids {
            do {
                try manager.delete(id: id)
            } catch {
                assertionFailure(String(describing: error))
            }
        }
        update()
    }

    func delete(_ layout: WidgetLayout) {
        delete(id: layout.id)
    }

    func apply(_ layout: WidgetLayout) {
        do {
            try manager.apply(layout)
        } catch {
            assertionFailure(String(describing: error))
        }
    }

    static var mock: WidgetLayoutStore {
        WidgetLayoutStore(
            manager: MockWidgetLayoutManager(
                layouts: [
                    WidgetLayout(
                        id: UUID(),
                        name: "Widget Layout 1",
                        icon: .square,
                        color: .blue,
                        uiDefaults: Data()
                    ),
                    WidgetLayout(
                        id: UUID(),
                        name: "Widget Layout 2",
                        icon: .circle,
                        color: .brown,
                        uiDefaults: Data()
                    ),
                    WidgetLayout(
                        id: UUID(),
                        name: "Widget Layout 3",
                        icon: .triangle,
                        color: .gray,
                        uiDefaults: Data()
                    ),
                    WidgetLayout(
                        id: UUID(),
                        name: "Widget Layout 4",
                        icon: .diamond,
                        color: .green,
                        uiDefaults: Data()
                    )
                ]
            )
        )
    }
}
