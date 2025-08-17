import AppIntents

struct WidgetLayoutEntityQuery: EntityQuery {
    func entities(for identifiers: [WidgetLayoutAppEntity.ID]) -> [WidgetLayoutAppEntity] {
        let manager = AppFactory().createWidgetLayoutManager()
        return identifiers
            .compactMap({ try? manager.get(id: $0) })
            .map(WidgetLayoutAppEntity.init)
    }

    func suggestedEntities() throws -> [WidgetLayoutAppEntity] {
        try AppFactory()
            .createWidgetLayoutManager()
            .getAll()
            .map(WidgetLayoutAppEntity.init)
    }
}
