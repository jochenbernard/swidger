import SwiftUI

struct WidgetLayoutManager: WidgetLayoutManagerProtocol {
    private let fileManager: FileManager
    private let directoryURL: URL

    private let notificationCenterManager = NotificationCenterManager()

    init(
        fileManager: FileManager,
        directoryURL: URL
    ) {
        self.fileManager = fileManager
        self.directoryURL = directoryURL
    }

    func getAll() throws -> [WidgetLayout] {
        try fileManager
            .contentsOfDirectory(
                at: directoryURL,
                includingPropertiesForKeys: nil
            )
            .filter { fileURL in
                fileURL.pathExtension == WidgetLayoutFileDocument.filenameExtension
            }
            .compactMap { fileURL in
                try? FileWrapper(
                    url: fileURL,
                    options: .immediate
                )
            }
            .compactMap { file in
                try? WidgetLayoutFileDocument(file: file)
            }
            .map { document in
                WidgetLayout(
                    id: document.id,
                    name: document.name,
                    uiDefaults: document.uiDefaults
                )
            }
    }

    func add(_ layout: WidgetLayout) throws {
        let uiDefaults = try notificationCenterManager.getUIDefaults()
        let document = WidgetLayoutFileDocument(
            id: layout.id,
            name: layout.name,
            uiDefaults: uiDefaults
        )
        let file = try document.fileWrapper()
        try file.write(
            to: fileURL(for: layout),
            options: .atomic,
            originalContentsURL: nil
        )
    }

    func edit(_ layout: WidgetLayout) throws {
        let document = WidgetLayoutFileDocument(
            id: layout.id,
            name: layout.name,
            uiDefaults: layout.uiDefaults
        )
        let file = try document.fileWrapper()
        let fileURL = fileURL(for: layout)
        try file.write(
            to: fileURL,
            options: .atomic,
            originalContentsURL: fileURL
        )
    }

    func delete(_ layouts: [WidgetLayout]) {
        layouts
            .map(fileURL)
            .forEach { fileURL in
                try? fileManager.removeItem(at: fileURL)
            }
    }

    func apply(_ layout: WidgetLayout) throws {
        try notificationCenterManager.setUIDefaults(layout.uiDefaults)
    }

    private func fileURL(for layout: WidgetLayout) -> URL {
        directoryURL
            .appending(component: layout.id.uuidString)
            .appendingPathExtension(WidgetLayoutFileDocument.filenameExtension)
    }
}
