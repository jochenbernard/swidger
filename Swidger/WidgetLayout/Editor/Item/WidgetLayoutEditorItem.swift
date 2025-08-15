import SwiftUI

struct WidgetLayoutEditorItem: View {
    @Environment(\.dismiss)
    private var dismiss

    @Bindable private var viewModel: WidgetLayoutEditorItemViewModel

    init(viewModel: WidgetLayoutEditorItemViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Form {
            TextField(
                "Name",
                text: $viewModel.name
            )
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(
                    "Cancel",
                    action: cancel
                )
            }

            ToolbarItem(placement: .confirmationAction) {
                Group {
                    switch viewModel.mode {
                    case .edit:
                        Button(
                            "Edit Widget Layout",
                            action: confirm
                        )

                    case .create:
                        Button(
                            "Add Widget Layout",
                            action: confirm
                        )
                    }
                }
                .disabled(!viewModel.isValid)
            }
        }
    }

    private func cancel() {
        dismiss()
    }

    private func confirm() {
        dismiss()
        viewModel.confirm()
    }
}

#Preview {
    WidgetLayoutEditorItem(
        viewModel: WidgetLayoutEditorItemViewModel(
            store: .mock,
            layout: nil
        )
    )
}
