import Foundation

struct NotificationCenterManager {
    private let defaultsExecutableURL = URL(filePath: "/usr/bin/defaults")
    private let killallExecutableURL = URL(filePath: "/usr/bin/killall")
    private let defaultsDomain = "com.apple.notificationcenterui"

    func getUIDefaults() throws -> Data {
        try runProcess(
            executableURL: defaultsExecutableURL,
            arguments: [
                "export",
                defaultsDomain,
                "-"
            ],
            input: nil
        )
    }

    func setUIDefaults(_ uiDefaults: Data) throws {
        try runProcess(
            executableURL: defaultsExecutableURL,
            arguments: [
                "import",
                defaultsDomain,
                "-"
            ],
            input: uiDefaults
        )
        try restart()
    }

    private func restart() throws {
        try runProcess(
            executableURL: killallExecutableURL,
            arguments: ["NotificationCenter"],
            input: nil
        )
    }

    @discardableResult
    private func runProcess(
        executableURL: URL,
        arguments: [String],
        input: Data?
    ) throws -> Data {
        let process = Process()
        let standardInput = Pipe()
        let standardError = Pipe()
        let standardOutput = Pipe()
        process.standardInput = standardInput
        process.standardError = standardError
        process.standardOutput = standardOutput
        process.executableURL = executableURL
        process.arguments = arguments

        try process.run()

        if let input {
            let fileHandle = standardInput.fileHandleForWriting
            try fileHandle.write(contentsOf: input)
            try fileHandle.close()
        }

        process.waitUntilExit()

        guard process.terminationStatus == .zero else {
            throw ProcessError(
                executableURL: executableURL,
                arguments: arguments,
                error: try? standardError.fileHandleForReading.readToEnd().flatMap { data in
                    String(
                        data: data,
                        encoding: .utf8
                    )
                }
            )
        }

        return (try? standardOutput.fileHandleForReading.readToEnd()) ?? Data()
    }

    struct ProcessError: Error {
        let executableURL: URL
        let arguments: [String]
        let error: String?
    }
}
