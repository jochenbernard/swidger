import SwiftUI

struct SettingsView: View {
    @Bindable private var viewModel: SettingsViewModel

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Form {
            Button(
                "Grant Full Disk Access",
                action: viewModel.grantFullDiskAccess
            )

            Toggle(
                "Show menu bar icon",
                isOn: $viewModel.showMenuBarIcon
            )

            Toggle(
                "Hide dock icon",
                isOn: $viewModel.hideDockIcon
            )
            .disabled(!viewModel.showMenuBarIcon)
            .padding(.leading, 20.0)
        }
        .padding()
    }
}

#Preview {
    SettingsView(
        viewModel: SettingsViewModel(
            userDefaults: .standard
        )
    )
}
