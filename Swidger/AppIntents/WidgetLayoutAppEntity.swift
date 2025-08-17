import AppIntents

struct WidgetLayoutAppEntity: AppEntity {
    static let defaultQuery = WidgetLayoutEntityQuery()
    static let typeDisplayRepresentation = TypeDisplayRepresentation(
        name: "Widget Layout"
    )

    let layout: WidgetLayout

    var id: WidgetLayout.ID {
        layout.id
    }

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: LocalizedStringResource(stringLiteral: layout.name),
            image: DisplayRepresentation.Image(systemName: layout.icon.systemImage)
        )
    }

    init(_ layout: WidgetLayout) {
        self.layout = layout
    }
}
