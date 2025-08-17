struct AppViewModel {
    let list: WidgetLayoutListViewModel
    let settings: SettingsViewModel
    let develop: DevelopViewModel

    @MainActor var showMenuBarIcon: Bool {
        get { settings.showMenuBarIcon }
        set { settings.showMenuBarIcon = newValue }
    }
}
