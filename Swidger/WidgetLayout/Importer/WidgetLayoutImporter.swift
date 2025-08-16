import SwiftUI

private struct WidgetLayoutImporter: ViewModifier {
    @Bindable private var viewModel: WidgetLayoutImporterViewModel

    init(viewModel: WidgetLayoutImporterViewModel) {
        self.viewModel = viewModel
    }

    func body(content: Content) -> some View {
        content.fileImporter(
            isPresented: $viewModel.isPresented,
            allowedContentTypes: WidgetLayoutFileDocument.readableContentTypes,
            allowsMultipleSelection: true,
            onCompletion: viewModel.complete
        )
    }
}

extension View {
    func widgetLayoutImporter(viewModel: WidgetLayoutImporterViewModel) -> some View {
        modifier(WidgetLayoutImporter(viewModel: viewModel))
    }
}
