import SwiftUI
import SwiftUICommon

struct WidgetLayoutListCommands: Commands {
    @Bindable private var viewModel: WidgetLayoutListViewModel

    init(viewModel: WidgetLayoutListViewModel) {
        self.viewModel = viewModel
    }

    var body: some Commands {
        CommandGroup(after: .newItem) {
            Button(
                "Add Widget Layout",
                systemImage: "plus",
                action: viewModel.editor.create
            )
            .keyboardShortcut("n")

            Divider()

            Button(
                "Edit Widget Layout",
                systemImage: "pencil",
                action: viewModel.editSelection
            )
            .keyboardShortcut("e")
            .disabled(viewModel.selection.count != 1)

            Divider()

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
    }
}
