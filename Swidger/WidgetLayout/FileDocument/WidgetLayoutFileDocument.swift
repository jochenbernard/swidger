import SwiftUI
import UniformTypeIdentifiers

struct WidgetLayoutFileDocument: Codable, FileDocument, Identifiable {
    static let filenameExtension = "wl"
    static let readableContentTypes = [UTType(filenameExtension: filenameExtension)].compactMap(\.self)

    let id: UUID
    let name: String
    let icon: WidgetLayoutIcon
    let color: WidgetLayoutColor
    let uiDefaults: Data

    init(
        id: UUID,
        name: String,
        icon: WidgetLayoutIcon,
        color: WidgetLayoutColor,
        uiDefaults: Data
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.color = color
        self.uiDefaults = uiDefaults
    }

    init(_ layout: WidgetLayout) {
        self.init(
            id: layout.id,
            name: layout.name,
            icon: layout.icon,
            color: layout.color,
            uiDefaults: layout.uiDefaults
        )
    }

    init(file: FileWrapper) throws {
        guard let fileContents = file.regularFileContents else {
            throw Error.missingFileContents
        }

        let decoder = JSONDecoder()
        let document = try decoder.decode(Self.self, from: fileContents)
        self = document
    }

    init(configuration: ReadConfiguration) throws {
        try self.init(file: configuration.file)
    }

    func fileWrapper() throws -> FileWrapper {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        let wrapper = FileWrapper(regularFileWithContents: data)
        wrapper.preferredFilename = name
        return wrapper
    }

    // swiftlint:disable:next unused_parameter
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        try fileWrapper()
    }

    enum Error: Swift.Error {
        case missingFileContents
    }
}
