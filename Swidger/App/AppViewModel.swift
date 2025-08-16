import Foundation

struct AppViewModel {
    let list: WidgetLayoutListViewModel
    let developCommands: DevelopCommandsViewModel

    @MainActor
    init() {
        let factory = AppFactory()

        self.list = factory.createList()
        self.developCommands = factory.createDevelopCommands()
    }
}
