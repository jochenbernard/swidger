import Foundation

protocol WidgetLayoutManagerProtocol {
    func get(id: WidgetLayout.ID) throws -> WidgetLayout
    func getAll() throws -> [WidgetLayout]
    func add(_ layout: WidgetLayout) throws
    func edit(_ layout: WidgetLayout) throws
    func update(_ layout: WidgetLayout) throws
    func delete(id: WidgetLayout.ID) throws
    func apply(_ layout: WidgetLayout) throws
}

extension WidgetLayoutManagerProtocol where Self == MockWidgetLayoutManager {
    static var mock: MockWidgetLayoutManager {
        MockWidgetLayoutManager(
            layouts: [
                WidgetLayout(
                    id: UUID().uuidString,
                    name: "Widget Layout 1",
                    icon: .square,
                    color: .blue,
                    uiDefaults: Data()
                ),
                WidgetLayout(
                    id: UUID().uuidString,
                    name: "Widget Layout 2",
                    icon: .circle,
                    color: .brown,
                    uiDefaults: Data()
                ),
                WidgetLayout(
                    id: UUID().uuidString,
                    name: "Widget Layout 3",
                    icon: .triangle,
                    color: .gray,
                    uiDefaults: Data()
                ),
                WidgetLayout(
                    id: UUID().uuidString,
                    name: "Widget Layout 4",
                    icon: .diamond,
                    color: .green,
                    uiDefaults: Data()
                )
            ]
        )
    }
}
