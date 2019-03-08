// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "AppStoreConnect-Swift-SDK",
    products: [
        .library(
            name: "AppStoreConnect-Swift-SDK",
            targets: ["AppStoreConnect-Swift-SDK"])
    ],
    targets: [
        .target(
            name: "AppStoreConnect-Swift-SDK",
            path: "Sources"),
        .testTarget(
            name: "AppStoreConnect-Swift-SDKTests",
            dependencies: ["AppStoreConnect-Swift-SDK"],
            path: "Example/CocoaPods-AppStoreConnect-Swift-SDK/Tests")
    ]
)
