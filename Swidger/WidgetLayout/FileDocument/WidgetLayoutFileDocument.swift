import SwiftUI
import UniformTypeIdentifiers

struct WidgetLayoutFileDocument: Codable, FileDocument, Identifiable {
    static let filenameExtension = "wl"
    static let readableContentTypes = [UTType(filenameExtension: filenameExtension)].compactMap(\.self)

    let id: UUID
    let name: String
    let uiDefaults: Data

    init(
        id: UUID,
        name: String,
        uiDefaults: Data
    ) {
        self.id = id
        self.name = name
        self.uiDefaults = uiDefaults
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
        return FileWrapper(regularFileWithContents: data)
    }

    // swiftlint:disable:next unused_parameter
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        try fileWrapper()
    }

    enum Error: Swift.Error {
        case missingFileContents
    }
}
