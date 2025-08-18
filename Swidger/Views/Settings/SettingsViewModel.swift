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
            updateActivationPolicy()
        }
    }

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults

        self.showMenuBarIcon = userDefaults.bool(forKey: showMenuBarIconUserDefaultsKey)
        self.hideDockIcon = userDefaults.bool(forKey: hideDockIconUserDefaultsKey)

        self.updateActivationPolicy()
    }

    private func updateActivationPolicy() {
        NSApplication.shared.setActivationPolicy(
            hideDockIcon
            ? .accessory
            : .regular
        )
    }

    func grantFullDiskAccess() {
        _ = try? FileManager.default.contentsOfDirectory(
            at: .libraryDirectory.appending(component: "Mail"),
            includingPropertiesForKeys: nil
        )

        guard let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles") else {
            return
        }

        NSWorkspace.shared.open(url)
    }
}
