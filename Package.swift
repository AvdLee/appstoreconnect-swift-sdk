// swift-tools-version:5.7
import PackageDescription

var dependencies: [Package.Dependency] = [
    .package(url: "https://github.com/CreateAPI/URLQueryEncoder.git", from: "0.2.0"),
    .package(url: "https://github.com/apple/swift-crypto.git", from: "3.12.3")
]

var targetDependencies: [Target.Dependency] = [
    .product(name: "URLQueryEncoder", package: "URLQueryEncoder"),
    .product(name: "Crypto", package: "swift-crypto")
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
        .tvOS(.v14),
        .watchOS(.v9),
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
            exclude: ["OpenAPI/app_store_connect_api.json"]
        ),
        .binaryTarget(
            name: "create-api", // Find the URL and checksum at https://github.com/createapi/createapi/releases/latest
            url: "https://github.com/CreateAPI/CreateAPI/releases/download/0.2.0/create-api.artifactbundle.zip",
            checksum: "6f8a3ce099f07eb2655ccaf6f66d8c9a09b74bb2307781c4adec36609ddac009"
        ),
        .plugin(
            name: "CreateAPI",
            capability: .command(
                intent: .custom(
                    verb: "generate-open-api",
                    description: "Generates the OpenAPI entities and paths using CreateAPI"
                ),
                permissions: [
                    .writeToPackageDirectory(reason: "To output the generated source code")
                ]
            ),
            dependencies: [
                .target(name: "create-api")
            ]
        )
    ]
)
