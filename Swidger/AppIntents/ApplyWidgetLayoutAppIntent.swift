import AppIntents

struct ApplyWidgetLayoutAppIntent: AppIntent {
    static let title: LocalizedStringResource = "Apply Widget Layout"
    static var parameterSummary: some ParameterSummary {
        Summary("Apply \(\.$layout) widget layout")
    }

    @Parameter private var layout: WidgetLayoutAppEntity

    func perform() throws -> some IntentResult {
        try AppFactory()
            .createWidgetLayoutManager()
            .apply(layout.layout)
        return .result()
    }
}
