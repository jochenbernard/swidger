import SwiftUI
import SwiftUICommon

struct WidgetLayoutListCommands: Commands {
    @Bindable private var viewModel: WidgetLayoutListViewModel

    init(viewModel: WidgetLayoutListViewModel) {
        self.viewModel = viewModel
    }

    var body: some Commands {
        CommandGroup(after: .newItem) {
            addButton

            Divider()

            editButton

            Divider()

            deleteButton

            Divider()

            importButton

            exportButton
        }
    }

    private var addButton: some View {
        Button(
            "Add Widget Layout",
            systemImage: "plus",
            action: viewModel.editor.create
        )
        .keyboardShortcut("n")
    }

    private var editButton: some View {
        Button(
            "Edit Widget Layout",
            systemImage: "pencil",
            action: viewModel.editSelection
        )
        .keyboardShortcut("e")
        .disabled(viewModel.selection.count != 1)
    }

    private var deleteButton: some View {
        ButtonWithConfirmation(
            role: .destructive,
            action: viewModel.deleteSelection,
            label: Label(
                "Delete Widget Layouts",
                systemImage: "trash"
            ),
            confirmationTitle: Text("Are you sure you want to delete the selected widget layouts?"),
            model: $viewModel.confirmation
        )
        .keyboardShortcut(.delete)
        .disabled(viewModel.selection.isEmpty)
    }

    private var importButton: some View {
        Button(
            "Import Widget Layouts...",
            systemImage: "square.and.arrow.down",
            action: {}
        )
        .keyboardShortcut("i", modifiers: [.command, .shift])
        .disabled(true)
    }

    private var exportButton: some View {
        Button(
            "Export Widget Layouts...",
            systemImage: "square.and.arrow.up",
            action: viewModel.exportSelection
        )
        .keyboardShortcut("e", modifiers: [.command, .shift])
        .disabled(viewModel.selection.isEmpty)
    }
}
