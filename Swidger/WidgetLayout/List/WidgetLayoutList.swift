import SwiftUI
import SwiftUICommon

struct WidgetLayoutList: View {
    @Bindable private var viewModel: WidgetLayoutListViewModel

    init(viewModel: WidgetLayoutListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Group {
            if let layouts = viewModel.layouts {
                if !layouts.isEmpty {
                    List(
                        layouts,
                        selection: $viewModel.selection
                    ) { layout in
                        WidgetLayoutRow(
                            layout,
                            viewModel: viewModel
                        )
                    }
                    .scrollContentBackground(.hidden)
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
        .widgetLayoutImporter(viewModel: viewModel.importer)
        .widgetLayoutExporter(viewModel: viewModel.exporter)
        .widgetLayoutEditor(viewModel: viewModel.editor)
        .confirmation(model: $viewModel.confirmation)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(
                    "Add Widget Layout",
                    systemImage: "plus",
                    action: viewModel.editor.create
                )
            }
        }
    }
}

#Preview {
    WidgetLayoutList(
        viewModel: WidgetLayoutListViewModel(
            store: .mock
        )
    )
}
