class MockWidgetLayoutManager: WidgetLayoutManagerProtocol {
    private var layouts: [WidgetLayout]

    init(layouts: [WidgetLayout]) {
        self.layouts = layouts
    }

    func getAll() -> [WidgetLayout] {
        layouts
    }

    func add(_ layout: WidgetLayout) {
        layouts.append(layout)
    }
}
