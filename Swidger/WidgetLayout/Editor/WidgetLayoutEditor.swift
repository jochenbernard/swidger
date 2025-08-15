import SwiftUI

private struct WidgetLayoutEditor: ViewModifier {
    @Bindable private var viewModel: WidgetLayoutEditorViewModel

    init(viewModel: WidgetLayoutEditorViewModel) {
        self.viewModel = viewModel
    }

    func body(content: Content) -> some View {
        content
            .sheet(
                item: $viewModel.item,
                content: WidgetLayoutEditorItem.init
            )
    }
}

extension View {
    func widgetLayoutEditor(viewModel: WidgetLayoutEditorViewModel) -> some View {
        modifier(WidgetLayoutEditor(viewModel: viewModel))
    }
}
