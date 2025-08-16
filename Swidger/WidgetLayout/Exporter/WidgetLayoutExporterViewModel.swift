import Observation

@Observable
@MainActor
class WidgetLayoutExporterViewModel {
    // swiftlint:disable:next discouraged_optional_collection
    var documents: [WidgetLayoutFileDocument]?

    func export(_ layouts: [WidgetLayout]) {
        documents = layouts.map(WidgetLayoutFileDocument.init)
    }
}
