import SwiftUI

@Observable
@MainActor
class SettingsViewModel {
    private let userDefaults: UserDefaults

    private let showMenuBarIconUserDefaultsKey = "showMenuBarIcon"
    var showMenuBarIcon: Bool {
        didSet {
            userDefaults.set(
                showMenuBarIcon,
                forKey: showMenuBarIconUserDefaultsKey
            )
            if !showMenuBarIcon {
                hideDockIcon = false
            }
        }
    }

    private let hideDockIconUserDefaultsKey = "hideDockIcon"
    var hideDockIcon: Bool {
        didSet {
            userDefaults.set(
                hideDockIcon,
                forKey: hideDockIconUserDefaultsKey
            )
            NSApplication.shared.setActivationPolicy(
                hideDockIcon
                ? .accessory
                : .regular
            )
        }
    }

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults

        self.showMenuBarIcon = userDefaults.bool(forKey: showMenuBarIconUserDefaultsKey)
        self.hideDockIcon = userDefaults.bool(forKey: hideDockIconUserDefaultsKey)
    }
}
