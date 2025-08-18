import ServiceManagement
import SwiftUI

@Observable
@MainActor
class SettingsViewModel {
    private let loginItem: SMAppService
    private let userDefaults: UserDefaults

    var openAtLogin: Bool {
        didSet {
            do {
                if openAtLogin {
                    try loginItem.register()
                } else {
                    try loginItem.unregister()
                }
            } catch {
                assertionFailure(String(describing: error))
            }
        }
    }

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

    init(
        loginItem: SMAppService,
        userDefaults: UserDefaults
    ) {
        self.loginItem = loginItem
        self.userDefaults = userDefaults

        self.openAtLogin = loginItem.status == .enabled
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
