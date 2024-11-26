// swift-tools-version:5.6
import PackageDescription

var dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/CreateAPI/URLQueryEncoder.git", from: "0.2.0"),
    .package(url: "https://github.com/apple/swift-crypto.git", from: "2.5.0")
]

var targetDependencies: [Target.Dependency] = [
    .productItem(name: "URLQueryEncoder", package: "URLQueryEncoder"),
    .productItem(name: "Crypto", package: "swift-crypto")
]

#if os(Linux)
dependencies.append(.package(url: "https://github.com/OpenCombine/OpenCombine.git", from: "0.14.0"))
targetDependencies.append(.product(name: "OpenCombine", package: "OpenCombine"))
#endif

let package = Package(
    name: "AppStoreConnect-Swift-SDK",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14)
    ],
    products: [
        .library(name: "AppStoreConnect-Swift-SDK", targets: ["AppStoreConnect-Swift-SDK"])
    ],
    dependencies: dependencies,
    targets: [
        .testTarget(name: "AppStoreConnect-Swift-SDK-Tests", dependencies: ["AppStoreConnect-Swift-SDK"], path: "Tests"),
        .target(
            name: "AppStoreConnect-Swift-SDK",
            dependencies: targetDependencies,
            path: "Sources",
            exclude: ["OpenAPI/app_store_connect_api.json", "OpenAPI/create-api.yml"]
        )
    ]
)
