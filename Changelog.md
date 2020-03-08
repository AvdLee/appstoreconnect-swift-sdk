### 1.0.0
- Trying to build a command line tool ([#69](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues/69)) via @AvdLee
- Make it a requirement to have SwiftLint setup locally ([#58](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues/58)) via @AvdLee
- Implement WeTransfer-iOS-CI ([#71](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues/71)) via @AvdLee
- Sometimes the bundle id has platform = "UNIVERSAL" ([#70](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/70))
- Adds response data for requests with a void result type. ([#66](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/66))
- Add support for Profiles and Devices endpoints ([#65](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/65))
- SPM issues about macOS version ([#61](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues/61))
- Add support for Bundle IDs and Capabilities endpoints ([#57](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/57))
- typo fix for issue 42 ([#62](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/62))
- Remove custom Result type ([#59](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/59))
- Rename Certificates method name to align with API design ([#55](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/55))
- Fix indentation in docs ([#56](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/56))
- Fix CI and Danger reports ([#54](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/54))
- Add support for Certificates endpoints ([#53](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/53))
- Implemented Register a New Bundle ID endpoint ([#51](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/51))
- Make error messages more verbose when debugging ([#52](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/52))
- Updated Swift Package Manager installation instructions ([#50](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/50))
- Swift 5.1 support ([#49](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/49))
- Date decoding issue ([#43](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues/43))

### 0.9.0
This is the initial release of the SDK, including the following features:

- [x] Configuration with API Key
- [x] APIProvider with endpoints structure
- [x] Add models for all endpoints
- [x] JWT Logic to sign requests
- [x] Get started section in the readme
- [x] Support for Mac
- [x] TestFlight API implementation
- [x] Users and Roles implementation
- [x] Sales and Finances implementation
- [x] Replace Alamofire dependency with own simple URLSession implementation