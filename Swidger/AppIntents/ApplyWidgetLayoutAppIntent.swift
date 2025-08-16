import AppIntents

struct ApplyWidgetLayoutAppIntent: AppIntent {
    static let title: LocalizedStringResource = "Apply Widget Layout"

    static var parameterSummary: some ParameterSummary {
        Summary("Apply \(\.$layout) widget layout")
    }

    @Parameter private var layout: WidgetLayoutAppEntity

    @MainActor
    func perform() throws -> some IntentResult {
        try AppFactory()
            .createManager()
            .apply(layout.layout)
        return .result()
    }
}
