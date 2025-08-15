import SwiftUI

struct WidgetLayoutList: View {
    private let viewModel: WidgetLayoutListViewModel

    init(viewModel: WidgetLayoutListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Group {
            if let layouts = viewModel.layouts {
                if !layouts.isEmpty {
                    List {
                        ForEach(layouts) { layout in
                            WidgetLayoutRow(layout)
                                .contextMenu {
                                    Button("Edit") {
                                        viewModel.editor.edit(layout)
                                    }
                                }
                        }
                        .onDelete(perform: viewModel.delete)
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
        .widgetLayoutEditor(viewModel: viewModel.editor)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(
                    "Add Widget Layout",
                    systemImage: "plus",
                    action: viewModel.editor.create
                )
                .keyboardShortcut("n")
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
