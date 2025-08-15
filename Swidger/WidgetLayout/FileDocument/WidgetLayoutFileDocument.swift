import SwiftUI
import UniformTypeIdentifiers

struct WidgetLayoutFileDocument: Codable, FileDocument, Identifiable {
    static let filenameExtension = "wl"
    static let readableContentTypes = [UTType(filenameExtension: filenameExtension)].compactMap(\.self)

    let id: UUID
    let name: String
    let rawData: Data

    init(
        id: UUID,
        name: String,
        rawData: Data
    ) {
        self.id = id
        self.name = name
        self.rawData = rawData
    }

    init(_ layout: WidgetLayout) {
        self.init(
            id: layout.id,
            name: layout.name,
            rawData: layout.rawData
        )
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw Error.missingFileContents
        }

        let decoder = JSONDecoder()
        let document = try decoder.decode(Self.self, from: data)
        self = document
    }

    // swiftlint:disable:next unused_parameter
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        return FileWrapper(regularFileWithContents: data)
    }

    enum Error: Swift.Error {
        case missingFileContents
    }
}
