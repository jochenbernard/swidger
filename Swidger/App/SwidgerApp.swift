import SwiftUI

@main
struct SwidgerApp: App {
    @State private var viewModel = AppViewModel()

    var body: some Scene {
        Window(
            "Swidger",
            id: "swidger"
        ) {
            WidgetLayoutList(viewModel: viewModel.list)
        }
        .commands {
            WidgetLayoutListCommands(viewModel: viewModel.list)

            #if DEBUG
            DevelopCommands(viewModel: viewModel.developCommands)
            #endif
        }
    }
}
