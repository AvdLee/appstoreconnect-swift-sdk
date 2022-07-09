// swift-tools-version:5.5
// We're hiding dev, test, and danger dependencies with // dev to make sure they're not fetched by users of this package.
import PackageDescription

let package = Package(
    name: "AppStoreConnect-Swift-SDK",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "AppStoreConnect-Swift-SDK", targets: ["AppStoreConnect-Swift-SDK"])
    ],
    dependencies: [
        .package(url: "https://github.com/CreateAPI/URLQueryEncoder.git", from: "0.2.0"),
        .package(url: "https://github.com/kean/Get.git", from: "0.8.0")
    ],
    targets: [
        // dev .testTarget(name: "AppStoreConnect-Swift-SDK-Tests", dependencies: ["AppStoreConnect-Swift-SDK"], path: "Tests", exclude: ["LinuxMain.swift"]),
        .target(
            name: "AppStoreConnect-Swift-SDK",
            dependencies: ["URLQueryEncoder", "Get"],
            path: "Sources",
            exclude: ["OpenAPI/app_store_connect_api_1.8_openapi.json"])
    ]
)
