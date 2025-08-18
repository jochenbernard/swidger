import SwiftUI

struct WidgetLayoutMenuBarExtraList: View {
    @Bindable private var viewModel: WidgetLayoutListViewModel

    init(viewModel: WidgetLayoutListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        if let layouts = viewModel.layouts {
            if !layouts.isEmpty {
                ForEach(layouts) { layout in
                    WidgetLayoutMenuBarExtraRow(
                        layout,
                        viewModel: viewModel
                    )
                }
            } else {
                ContentUnavailableView(
                    "No Widget Layouts",
                    systemImage: "widget.extralarge"
                )
            }
        } else {
            ProgressView()
        }
    }
}

#Preview {
    let store = WidgetLayoutStore(manager: .mock)

    WidgetLayoutMenuBarExtraList(
        viewModel: WidgetLayoutListViewModel(
            store: store,
            editor: WidgetLayoutEditorViewModel(store: store),
            importer: WidgetLayoutImporterViewModel(store: store),
            exporter: WidgetLayoutExporterViewModel()
        )
    )
}
