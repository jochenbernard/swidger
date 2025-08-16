import Foundation

final class WidgetLayout: Identifiable, Sendable {
    let id: UUID
    let name: String
    let icon: WidgetLayoutIcon
    let color: WidgetLayoutColor
    let uiDefaults: Data

    init(
        id: UUID,
        name: String,
        icon: WidgetLayoutIcon,
        color: WidgetLayoutColor,
        uiDefaults: Data
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.color = color
        self.uiDefaults = uiDefaults
    }

    convenience init(_ document: WidgetLayoutFileDocument) {
        self.init(
            id: document.id,
            name: document.name,
            icon: document.icon,
            color: document.color,
            uiDefaults: document.uiDefaults
        )
    }

    static var mock: WidgetLayout {
        WidgetLayout(
            id: UUID(),
            name: "Widget Layout 1",
            icon: .square,
            color: .blue,
            uiDefaults: Data()
        )
    }
}
