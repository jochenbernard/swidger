import SwiftUI

struct MenuBarExtraView: View {
    @Environment(\.openSettings)
    private var openSettingsAction

    private let viewModel: WidgetLayoutListViewModel

    init(viewModel: WidgetLayoutListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(spacing: .zero) {
                WidgetLayoutMenuBarExtraList(viewModel: viewModel)

                divider

                button(
                    action: openSettings,
                    title: "Settings...",
                    keyboardShortcut: "⌘ ,"
                )
                .keyboardShortcut(",")

                divider

                button(
                    action: quit,
                    title: "Quit Swidger",
                    keyboardShortcut: "⌘ Q"
                )
                .keyboardShortcut("Q")
            }
            .frame(minWidth: 160.0)
            .fixedSize(
                horizontal: true,
                vertical: false
            )
            .padding(4.0)
        }
    }

    private func button(
        action: @escaping () -> Void,
        title: LocalizedStringKey,
        keyboardShortcut: String
    ) -> some View {
        MenuBarExtraButton(action: action) {
            HStack {
                Text(title)

                Spacer()

                Text(keyboardShortcut)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 4.0)
        }
    }

    private var divider: some View {
        Divider()
            .padding(4.0)
    }

    private func openSettings() {
        openSettingsAction()
        NSApplication.shared.activate()
    }

    private func quit() {
        NSApplication.shared.terminate(nil)
    }
}

#Preview {
    let store = WidgetLayoutStore(manager: .mock)

    MenuBarExtraView(
        viewModel: WidgetLayoutListViewModel(
            store: store,
            editor: WidgetLayoutEditorViewModel(store: store),
            importer: WidgetLayoutImporterViewModel(store: store),
            exporter: WidgetLayoutExporterViewModel()
        )
    )
}
