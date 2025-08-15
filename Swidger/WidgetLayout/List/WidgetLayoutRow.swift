import SwiftUI

struct WidgetLayoutRow: View {
    private let layout: WidgetLayout
    private let viewModel: WidgetLayoutListViewModel

    init(
        _ layout: WidgetLayout,
        viewModel: WidgetLayoutListViewModel
    ) {
        self.layout = layout
        self.viewModel = viewModel
    }

    var body: some View {
        HStack(spacing: 12.0) {
            Text(layout.name)

            Spacer()

            applyButton

            editButton
        }
        .buttonStyle(.borderless)
        .labelStyle(.iconOnly)
        .symbolVariant(.fill)
        .padding(12.0)
        .contextMenu {
            applyButton

            Divider()

            editButton
        }
    }

    private var applyButton: some View {
        Button(
            "Apply",
            systemImage: "play"
        ) {
            viewModel.apply(layout)
        }
    }

    private var editButton: some View {
        Button(
            "Edit",
            systemImage: "pencil"
        ) {
            viewModel.editor.edit(layout)
        }
    }
}

#Preview {
    WidgetLayoutRow(
        .mock,
        viewModel: WidgetLayoutListViewModel(store: .mock)
    )
}
