struct MockWidgetLayoutManager: WidgetLayoutManagerProtocol {
    private let layouts: [WidgetLayout]

    init(layouts: [WidgetLayout]) {
        self.layouts = layouts
    }

    func getAll() -> [WidgetLayout] {
        layouts
    }
}
