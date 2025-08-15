import SwiftUI

@main
struct SwidgerApp: App {
    @State private var viewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            WidgetLayoutList(viewModel: viewModel.list)
        }
    }
}
