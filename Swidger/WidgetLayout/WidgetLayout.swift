import Foundation

final class WidgetLayout: Identifiable, Sendable {
    let id: UUID
    let name: String
    let rawData: Data

    init(
        id: UUID,
        name: String,
        rawData: Data
    ) {
        self.id = id
        self.name = name
        self.rawData = rawData
    }

    convenience init(_ document: WidgetLayoutFileDocument) {
        self.init(
            id: document.id,
            name: document.name,
            rawData: document.rawData
        )
    }

    static var mock: WidgetLayout {
        WidgetLayout(
            id: UUID(),
            name: "Widget Layout 1",
            rawData: Data()
        )
    }
}
