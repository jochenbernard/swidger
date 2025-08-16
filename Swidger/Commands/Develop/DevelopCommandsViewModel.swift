import SwiftUI

@Observable
@MainActor
class DevelopCommandsViewModel {
    private let userDefaults: UserDefaults
    private let applicationSupportDirectoryURL: URL
    weak var app: AppViewModel?

    private let useMockDataUserDefaultsKey = "useMockData"
    var useMockData: Bool {
        didSet {
            app?.updateManagers()
        }
    }

    init(
        userDefaults: UserDefaults,
        applicationSupportDirectoryURL: URL
    ) {
        self.userDefaults = userDefaults
        self.applicationSupportDirectoryURL = applicationSupportDirectoryURL

        self.useMockData = userDefaults.bool(forKey: useMockDataUserDefaultsKey)

        self.trackUseMockData()
    }

    private func trackUseMockData() {
        withObservationTracking(updateUseMockData) {
            Task { @MainActor [weak self] in
                self?.trackUseMockData()
            }
        }
    }

    private func updateUseMockData() {
        userDefaults.set(
            useMockData,
            forKey: useMockDataUserDefaultsKey
        )
    }

    func openApplicationSupportDirectory() {
        NSWorkspace.shared.open(applicationSupportDirectoryURL)
    }
}
