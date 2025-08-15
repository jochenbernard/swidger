class MockWidgetLayoutManager: WidgetLayoutManagerProtocol {
    private var layouts: [WidgetLayout.ID: WidgetLayout]

    init(layouts: [WidgetLayout]) {
        self.layouts = layouts.reduce(into: [:]) { layouts, layout in
            layouts[layout.id] = layout
        }
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

    func delete(_ layouts: [WidgetLayout]) {
        for layout in layouts {
            self.layouts.removeValue(forKey: layout.id)
        }
    }
}
