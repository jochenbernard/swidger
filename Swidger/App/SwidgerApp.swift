import SwiftUI

@main
struct SwidgerApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate

    private var viewModel: AppViewModel {
        appDelegate.viewModel
    }

    var body: some Scene {
        Window(
            "Swidger",
            id: "swidger"
        ) {
            WidgetLayoutList(viewModel: viewModel.list)
        }
        .handlesExternalEvents(matching: [])
        .defaultLaunchBehavior(
            viewModel.settings.hideDockIcon
            ? .suppressed
            : .presented
        )
        .commands {
            WidgetLayoutListCommands(viewModel: viewModel.list)

            #if DEBUG
            DevelopCommands(viewModel: viewModel.develop)
            #endif
        }

        MenuBarExtra(
            "Swidger",
            systemImage: "widget.small",
            isInserted: Binding(
                get: { viewModel.settings.showMenuBarIcon },
                set: { viewModel.settings.showMenuBarIcon = $0 }
            )
        ) {
            WidgetLayoutMenuBarExtraList(viewModel: viewModel.list)
        }
        .menuBarExtraStyle(.window)

        Settings {
            SettingsView(viewModel: viewModel.settings)
        }
    }
}
