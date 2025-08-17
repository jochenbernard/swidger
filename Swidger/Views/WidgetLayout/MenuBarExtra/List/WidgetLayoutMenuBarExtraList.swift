import SwiftUI

struct WidgetLayoutMenuBarExtraList: View {
    @Bindable private var viewModel: WidgetLayoutListViewModel

    init(viewModel: WidgetLayoutListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        if let layouts = viewModel.layouts {
            if !layouts.isEmpty {
                ScrollView {
                    VStack(spacing: .zero) {
                        ForEach(layouts) { layout in
                            WidgetLayoutMenuBarExtraRow(
                                layout,
                                viewModel: viewModel
                            )
                        }
                    }
                    .frame(minWidth: 128.0)
                    .fixedSize(
                        horizontal: true,
                        vertical: false
                    )
                    .padding(4.0)
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
