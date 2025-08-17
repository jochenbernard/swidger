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
            WidgetLayoutIconView(
                icon: layout.icon,
                color: layout.color.color
            )
            .background(.background.quinary)
            .clipShape(Circle())

            Text(layout.name)

            Spacer()

            applyButton
                .symbolVariant(.fill)
        }
        .buttonStyle(.borderless)
        .labelStyle(.iconOnly)
        .padding(12.0)
        .contextMenu {
            applyButton

            Divider()

            editButton

            updateButton

            deleteButton
        }
    }

    private var applyButton: some View {
        Button(
            "Apply Widget Layout",
            systemImage: "play",
            action: apply
        )
    }

    private var editButton: some View {
        Button(
            "Edit Widget Layout",
            systemImage: "pencil",
            action: edit
        )
    }

    private var updateButton: some View {
        ButtonWithConfirmation(
            role: .destructive,
            action: update,
            label: Label(
                "Update Widget Layout",
                systemImage: "arrow.clockwise"
            ),
            confirmationTitle: Text("Are you sure you want to update this widget layout?"),
            confirmationMessage: Text("This will override the currently saved layout."),
            model: $viewModel.confirmation
        )
    }

    private var deleteButton: some View {
        ButtonWithConfirmation(
            role: .destructive,
            action: delete,
            label: Label(
                "Delete Widget Layout",
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

    private func update() {
        viewModel.update(layout)
    }

    private func delete() {
        viewModel.delete(layout)
    }
}

#Preview {
    let store = WidgetLayoutStore(manager: .mock)

    WidgetLayoutRow(
        .mock,
        viewModel: WidgetLayoutListViewModel(
            store: store,
            editor: WidgetLayoutEditorViewModel(store: store),
            importer: WidgetLayoutImporterViewModel(store: store),
            exporter: WidgetLayoutExporterViewModel()
        )
    )
}
