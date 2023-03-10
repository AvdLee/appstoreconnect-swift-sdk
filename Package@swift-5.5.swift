// swift-tools-version:5.5
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
        .package(url: "https://github.com/CreateAPI/URLQueryEncoder.git", from: "0.2.0")
    ],
    targets: [
        .testTarget(name: "AppStoreConnect-Swift-SDK-Tests", dependencies: ["AppStoreConnect-Swift-SDK"], path: "Tests"),
        .target(
            name: "AppStoreConnect-Swift-SDK",
            dependencies: ["URLQueryEncoder"],
            path: "Sources",
            exclude: ["OpenAPI/app_store_connect_api_2.3_openapi.json"])
    ]
)
