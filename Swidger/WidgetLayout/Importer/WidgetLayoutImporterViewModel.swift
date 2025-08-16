import Foundation

@Observable
@MainActor
class WidgetLayoutImporterViewModel {
    private let store: WidgetLayoutStore

    var isPresented = false

    init(store: WidgetLayoutStore) {
        self.store = store
    }

    func present() {
        isPresented = true
    }

    func complete(result: Result<[URL], any Error>) {
        switch result {
        case .success(let urls):
            for url in urls {
                try? importFrom(url: url)
            }

        case .failure:
            break
        }
    }

    private func importFrom(url: URL) throws {
        let file = try FileWrapper(
            url: url,
            options: .immediate
        )
        let document = try WidgetLayoutFileDocument(file: file)
        let name = firstAvailableName(forPreferredName: document.name)
        let layout = WidgetLayout(
            id: UUID().uuidString,
            name: name,
            icon: document.icon,
            color: document.color,
            uiDefaults: document.uiDefaults
        )
        store.add(layout)
    }

    private func firstAvailableName(forPreferredName preferredName: String) -> String {
        guard let layouts = store.layouts else {
            return preferredName
        }

        let names = layouts
            .filter({ $0.value.name.starts(with: preferredName) })
            .map(\.value.name)

        guard names.contains(preferredName) else {
            return preferredName
        }

        var attempt = 1
        while names.contains("\(preferredName) \(attempt)") {
            attempt += 1
        }

        return "\(preferredName) \(attempt)"
    }
}
