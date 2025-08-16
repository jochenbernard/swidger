import AppIntents

@MainActor
struct WidgetLayoutEntityQuery: EntityQuery {
    func entities(for identifiers: [WidgetLayoutAppEntity.ID]) -> [WidgetLayoutAppEntity] {
        let manager = AppFactory().createManager()
        return identifiers
            .compactMap({ try? manager.get(id: $0) })
            .map(WidgetLayoutAppEntity.init)
    }

    func suggestedEntities() throws -> [WidgetLayoutAppEntity] {
        try AppFactory()
            .createManager()
            .getAll()
            .map(WidgetLayoutAppEntity.init)
    }
}
