import SwiftUI
import SwiftUICommon

struct WidgetLayoutRow: View {
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
        HStack(spacing: 12.0) {
            WidgetLayoutIconView(layout.icon)

            Text(layout.name)

            Spacer()

            Group {
                applyButton

                editButton

                deleteButton
            }
            .symbolVariant(.fill)
        }
        .buttonStyle(.borderless)
        .labelStyle(.iconOnly)
        .padding(12.0)
        .contextMenu {
            applyButton

            Divider()

            editButton

            Divider()

            deleteButton
        }
    }

    private var applyButton: some View {
        Button(
            "Apply",
            systemImage: "play",
            action: apply
        )
    }

    private var editButton: some View {
        Button(
            "Edit",
            systemImage: "pencil",
            action: edit
        )
    }

    private var deleteButton: some View {
        ButtonWithConfirmation(
            role: .destructive,
            action: delete,
            label: Label(
                "Delete",
                systemImage: "trash"
            ),
            confirmationTitle: Text("Are you sure you want to delete this widget layout?"),
            model: $viewModel.confirmation
        )
    }

    private func apply() {
        viewModel.apply(layout)
    }

    private func edit() {
        viewModel.editor.edit(layout)
    }

    private func delete() {
        viewModel.delete(layout)
    }
}

#Preview {
    WidgetLayoutRow(
        .mock,
        viewModel: WidgetLayoutListViewModel(store: .mock)
    )
}
