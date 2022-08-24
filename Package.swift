// swift-tools-version:5.6
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
            exclude: ["OpenAPI/app_store_connect_api_2.0_openapi.json"]
        ),
        .binaryTarget(
            name: "create-api", // Find the URL and checksum at https://github.com/createapi/createapi/releases/latest
            url: "https://github.com/CreateAPI/CreateAPI/releases/download/0.1.0/create-api.artifactbundle.zip",
            checksum: "4e9d1fb023c52e423d57de0928da5d943e3e4c81f6cb903523654867e6372db7"
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
