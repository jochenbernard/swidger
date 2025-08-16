import Observation

@Observable
class WidgetLayoutStore {
    var manager: WidgetLayoutManagerProtocol {
        didSet {
            update()
        }
    }

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

    func update(_ layout: WidgetLayout) {
        do {
            try manager.update(layout)
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

    func apply(_ layout: WidgetLayout) {
        do {
            try manager.apply(layout)
        } catch {
            assertionFailure(String(describing: error))
        }
    }
}
