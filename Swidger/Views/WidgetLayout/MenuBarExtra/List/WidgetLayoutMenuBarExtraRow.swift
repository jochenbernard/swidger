import SwiftUI
import SwiftUICommon

struct WidgetLayoutMenuBarExtraRow: View {
    private let layout: WidgetLayout
    @Bindable private var viewModel: WidgetLayoutListViewModel

    init(
        _ layout: WidgetLayout,
        viewModel: WidgetLayoutListViewModel
    ) {
        self.layout = layout
        self.viewModel = viewModel
    }

    var body: some View {
        MenuBarExtraButton(action: apply) {
            HStack(spacing: 4.0) {
                Image(systemName: layout.icon.systemImage)
                    .accessibilityLabel(layout.icon.systemImage)
                    .frame(size: 24.0)

                Text(layout.name)
            }
            .padding(.trailing, 4.0)
        }
    }

    private func apply() {
        viewModel.apply(layout)
    }
}

#Preview {
    let store = WidgetLayoutStore(manager: .mock)

    WidgetLayoutMenuBarExtraRow(
        .mock,
        viewModel: WidgetLayoutListViewModel(
            store: store,
            editor: WidgetLayoutEditorViewModel(store: store),
            importer: WidgetLayoutImporterViewModel(store: store),
            exporter: WidgetLayoutExporterViewModel()
        )
    )
}
