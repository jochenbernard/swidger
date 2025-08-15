import Foundation

struct WidgetLayout: Identifiable {
    let id: UUID
    let name: String

    static var mock: Self {
        Self(
            id: UUID(),
            name: "Widget Layout 1"
        )
    }
}
