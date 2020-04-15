// swift-tools-version:5.1
// We're hiding dev, test, and danger dependencies with // dev to make sure they're not fetched by users of this package.

import PackageDescription

let package = Package(
    name: "AppStoreConnect-Swift-SDK",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_12)
    ],
    products: [
        // dev .library(name: "DangerDeps", type: .dynamic, targets: ["DangerDependencies"]),
        .library(name: "AppStoreConnect-Swift-SDK", targets: ["AppStoreConnect-Swift-SDK"])
    ],
    dependencies: [
        // dev .package(url: "https://github.com/danger/swift", from: "3.0.0"),
        // dev .package(path: "Submodules/WeTransfer-iOS-CI/Danger-Swift")
        ],
    targets: [
        // dev .target(name: "DangerDependencies", dependencies: ["Danger", "WeTransferPRLinter"], path: "Submodules/WeTransfer-iOS-CI/Danger-Swift", sources: ["DangerFakeSource.swift"]),
        // dev .testTarget(name: "AppStoreConnect-Swift-SDK-Tests", dependencies: ["AppStoreConnect-Swift-SDK"], path: "Tests", exclude: ["LinuxMain.swift"]),
        .target(name: "AppStoreConnect-Swift-SDK", path: "Sources")
    ]
)
