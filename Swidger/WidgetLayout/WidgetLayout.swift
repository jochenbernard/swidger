import Foundation

final class WidgetLayout: Identifiable, Sendable {
    let id: String
    let name: String
    let icon: WidgetLayoutIcon
    let color: WidgetLayoutColor
    let uiDefaults: Data

    init(
        id: String,
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

    convenience init(
        id: String,
        document: WidgetLayoutFileDocument
    ) {
        self.init(
            id: id,
            name: document.name,
            icon: document.icon,
            color: document.color,
            uiDefaults: document.uiDefaults
        )
    }

    static var mock: WidgetLayout {
        WidgetLayout(
            id: UUID().uuidString,
            name: "Widget Layout 1",
            icon: .square,
            color: .blue,
            uiDefaults: Data()
        )
    }
}
