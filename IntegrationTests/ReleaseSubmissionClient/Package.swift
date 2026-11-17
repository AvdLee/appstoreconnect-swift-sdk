// swift-tools-version:6.4
import PackageDescription

// A consumer that depends on three of the SDK's modules, not the whole SDK.
// Building it proves those modules compile and work without the other areas.
let package = Package(
    name: "ReleaseSubmissionClient",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(name: "appstoreconnect-swift-sdk", path: "../.."),
    ],
    targets: [
        .target(
            name: "ReleaseSubmission",
            dependencies: [
                .product(name: "AppStoreConnectCore", package: "appstoreconnect-swift-sdk"),
                .product(name: "AppStoreConnectAppStore", package: "appstoreconnect-swift-sdk"),
                .product(name: "AppStoreConnectTestFlight", package: "appstoreconnect-swift-sdk"),
            ]
        ),
        .testTarget(
            name: "ReleaseSubmissionTests",
            dependencies: ["ReleaseSubmission"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
