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

    private func get(fileURL: URL) throws -> WidgetLayout {
        let file = try FileWrapper(
            url: fileURL,
            options: .immediate
        )
        let document = try WidgetLayoutFileDocument(file: file)
        return WidgetLayout(document)
    }

    func get(id: WidgetLayout.ID) throws -> WidgetLayout {
        try get(fileURL: fileURL(for: id))
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
                try? get(fileURL: fileURL)
            }
    }

    func add(_ layout: WidgetLayout) throws {
        let uiDefaults = if layout.uiDefaults.isEmpty {
            try notificationCenterManager.getUIDefaults()
        } else {
            layout.uiDefaults
        }
        let document = WidgetLayoutFileDocument(
            id: layout.id,
            name: layout.name,
            icon: layout.icon,
            color: layout.color,
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
        let document = WidgetLayoutFileDocument(layout)
        let file = try document.fileWrapper()
        let fileURL = fileURL(for: layout)
        try file.write(
            to: fileURL,
            options: .atomic,
            originalContentsURL: fileURL
        )
    }

    func update(_ layout: WidgetLayout) throws {
        let uiDefaults = try notificationCenterManager.getUIDefaults()
        let document = WidgetLayoutFileDocument(
            id: layout.id,
            name: layout.name,
            icon: layout.icon,
            color: layout.color,
            uiDefaults: uiDefaults
        )
        let file = try document.fileWrapper()
        let fileURL = fileURL(for: layout)
        try file.write(
            to: fileURL,
            options: .atomic,
            originalContentsURL: fileURL
        )
    }

    func delete(id: WidgetLayout.ID) throws {
        let fileURL = fileURL(for: id)
        try fileManager.removeItem(at: fileURL)
    }

    func apply(_ layout: WidgetLayout) throws {
        try notificationCenterManager.setUIDefaults(layout.uiDefaults)
    }

    private func fileURL(for layout: WidgetLayout) -> URL {
        fileURL(for: layout.id)
    }

    private func fileURL(for id: WidgetLayout.ID) -> URL {
        directoryURL
            .appending(component: id.uuidString)
            .appendingPathExtension(WidgetLayoutFileDocument.filenameExtension)
    }
}
