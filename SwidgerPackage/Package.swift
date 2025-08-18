// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "SwidgerPackage",
    platforms: [.macOS(.v15)],
    products: [
        .library(
            name: "SwidgerPackage",
            targets: ["SwidgerPackage"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/jochenbernard/swift-common",
            branch: "feature/confirmation-message"
        )
    ],
    targets: [
        .target(
            name: "SwidgerPackage",
            dependencies: [
                .product(
                    name: "FoundationCommon",
                    package: "swift-common"
                ),
                .product(
                    name: "SwiftUICommon",
                    package: "swift-common"
                )
            ]
        )
    ]
)
