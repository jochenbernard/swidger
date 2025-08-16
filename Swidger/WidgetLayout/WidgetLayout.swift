import Foundation

final class WidgetLayout: Identifiable, Sendable {
    let id: UUID
    let name: String
    let icon: WidgetLayoutIcon
    let uiDefaults: Data

    init(
        id: UUID,
        name: String,
        icon: WidgetLayoutIcon,
        uiDefaults: Data
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.uiDefaults = uiDefaults
    }

    static var mock: WidgetLayout {
        WidgetLayout(
            id: UUID(),
            name: "Widget Layout 1",
            icon: .square,
            uiDefaults: Data()
        )
    }
}
