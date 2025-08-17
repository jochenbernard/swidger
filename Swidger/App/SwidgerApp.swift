import SwiftUI

@main
struct SwidgerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @State private var viewModel = AppFactory().createAppViewModel()

    var body: some Scene {
        Window(
            "Swidger",
            id: "swidger"
        ) {
            WidgetLayoutList(viewModel: viewModel.list)
                .onOpenURL { url in
                    try? viewModel.list.importer.importFrom(url: url)
                }
        }
        .commands {
            WidgetLayoutListCommands(viewModel: viewModel.list)

            #if DEBUG
            DevelopCommands(viewModel: viewModel.develop)
            #endif
        }

        MenuBarExtra(
            "Swidger",
            systemImage: "widget.small",
            isInserted: $viewModel.showMenuBarIcon
        ) {
            WidgetLayoutMenuBarExtraList(viewModel: viewModel.list)
        }
        .menuBarExtraStyle(.window)

        Settings {
            SettingsView(viewModel: viewModel.settings)
        }
    }
}
