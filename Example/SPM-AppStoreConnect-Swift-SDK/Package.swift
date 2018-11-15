// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "SPM-AppStoreConnect-Swift-SDK",
    dependencies: [
        .package(path: "../../")
    ],
    targets: [
        .target(name: "SPM-AppStoreConnect-Swift-SDK", dependencies: ["AppStoreConnect-Swift-SDK"])
    ]
)
