import AppIntents

struct WidgetLayoutAppEntity: AppEntity {
    static let typeDisplayRepresentation = TypeDisplayRepresentation(
        name: "Widget Layout"
    )

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: LocalizedStringResource(stringLiteral: layout.name),
            image: DisplayRepresentation.Image(systemName: layout.icon.systemImage)
        )
    }

    let layout: WidgetLayout

    var id: String {
        layout.id
    }

    init(_ layout: WidgetLayout) {
        self.layout = layout
    }

    static let defaultQuery = WidgetLayoutEntityQuery()
}
