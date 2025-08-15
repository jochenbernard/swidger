import Foundation

final class WidgetLayout: Identifiable, Sendable {
    let id: UUID
    let name: String
    let uiDefaults: Data

    init(
        id: UUID,
        name: String,
        uiDefaults: Data
    ) {
        self.id = id
        self.name = name
        self.uiDefaults = uiDefaults
    }

    static var mock: WidgetLayout {
        WidgetLayout(
            id: UUID(),
            name: "Widget Layout 1",
            uiDefaults: Data()
        )
    }
}
