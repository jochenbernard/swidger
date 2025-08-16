import SwiftUI

@main
struct SwidgerApp: App {
    @State private var viewModel = AppFactory().createAppViewModel()

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
