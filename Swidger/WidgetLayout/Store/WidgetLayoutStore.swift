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

    func delete(_ layout: WidgetLayout) {
        do {
            try manager.delete(layout)
        } catch {
            assertionFailure(String(describing: error))
        }
        update()
    }

    func apply(_ layout: WidgetLayout) {
        do {
            try manager.apply(layout)
        } catch {
            assertionFailure(String(describing: error))
        }
    }

    static var mock: WidgetLayoutStore {
        let layouts = (0..<4).map { index in
            WidgetLayout(
                id: UUID(),
                name: "Widget Layout \(index + 1)",
                uiDefaults: Data()
            )
        }

        return WidgetLayoutStore(
            manager: MockWidgetLayoutManager(
                layouts: layouts
            )
        )
    }
}
