import SwiftUI
import SwiftUICommon

private struct WidgetLayoutExporter: ViewModifier {
    @Bindable private var viewModel: WidgetLayoutExporterViewModel

    init(viewModel: WidgetLayoutExporterViewModel) {
        self.viewModel = viewModel
    }

    func body(content: Content) -> some View {
        content
            .fileExporter(
                isPresented: .hasValue($viewModel.documents),
                documents: viewModel.documents ?? [],
                contentTypes: WidgetLayoutFileDocument.writableContentTypes,
                onCompletion: { _ in }
            )
    }
}

extension View {
    func widgetLayoutExporter(viewModel: WidgetLayoutExporterViewModel) -> some View {
        modifier(WidgetLayoutExporter(viewModel: viewModel))
    }
}
