protocol WidgetLayoutManagerProtocol {
    func getAll() throws -> [WidgetLayout]
    func add(_ layout: WidgetLayout) throws
    func edit(_ layout: WidgetLayout) throws
    func delete(_ layouts: [WidgetLayout])
    func apply(_ layout: WidgetLayout) throws
}
