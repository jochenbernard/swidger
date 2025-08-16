protocol WidgetLayoutManagerProtocol {
    func get(id: WidgetLayout.ID) throws -> WidgetLayout
    func getAll() throws -> [WidgetLayout]
    func add(_ layout: WidgetLayout) throws
    func edit(_ layout: WidgetLayout) throws
    func delete(id: WidgetLayout.ID) throws
    func apply(_ layout: WidgetLayout) throws
}
