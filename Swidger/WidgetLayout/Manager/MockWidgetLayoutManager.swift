class MockWidgetLayoutManager: WidgetLayoutManagerProtocol {
    private var layouts: [WidgetLayout.ID: WidgetLayout]

    init(layouts: [WidgetLayout]) {
        self.layouts = layouts.reduce(into: [:]) { layouts, layout in
            layouts[layout.id] = layout
        }
    }

    func get(id: WidgetLayout.ID) throws -> WidgetLayout {
        guard let layout = layouts[id] else {
            throw Error.notFound
        }

        return layout
    }

    func getAll() -> [WidgetLayout] {
        Array(layouts.values)
    }

    func add(_ layout: WidgetLayout) {
        layouts[layout.id] = layout
    }

    func edit(_ layout: WidgetLayout) {
        layouts[layout.id] = layout
    }

    func delete(_ layout: WidgetLayout) {
        layouts.removeValue(forKey: layout.id)
    }

    func apply(_: WidgetLayout) {}

    enum Error: Swift.Error {
        case notFound
    }
}
