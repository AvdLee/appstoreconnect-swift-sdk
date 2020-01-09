// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "SPM-AppStoreConnect-Swift-SDK",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_12)
    ],
    dependencies: [
        .package(path: "../../")
    ],
    targets: [
        .target(name: "SPM-AppStoreConnect-Swift-SDK", dependencies: ["AppStoreConnect-Swift-SDK"])
    ]
)
