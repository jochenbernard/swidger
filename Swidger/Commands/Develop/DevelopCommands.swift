import SwiftUI

struct DevelopCommands: Commands {
    @Bindable private var viewModel: DevelopCommandsViewModel

    init(viewModel: DevelopCommandsViewModel) {
        self.viewModel = viewModel
    }

    var body: some Commands {
        CommandMenu("Develop") {
            Button(
                "Open Application Support Directory...",
                action: viewModel.openApplicationSupportDirectory
            )
            .keyboardShortcut("a", modifiers: [.command, .shift])

            Divider()

            Toggle(
                "Use mock data",
                isOn: $viewModel.useMockData
            )
            .keyboardShortcut("m", modifiers: [.command, .shift])
        }
    }
}
