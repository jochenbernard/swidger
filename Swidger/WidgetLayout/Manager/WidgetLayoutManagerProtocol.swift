protocol WidgetLayoutManagerProtocol {
    func getAll() -> [WidgetLayout]
    func add(_ layout: WidgetLayout)
    func edit(_ layout: WidgetLayout)
    func delete(_ layouts: [WidgetLayout])
}
