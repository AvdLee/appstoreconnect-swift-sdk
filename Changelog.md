### 1.1.0
- Fix the parsing of Profile responses ([#95](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/95)) via [@orj](https://github.com/orj)
- Added missing build relationships ([#96](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/96)) via [@Nafisa2020](https://github.com/Nafisa2020)
- Limit for listing invited users is not implemented ([#93](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues/93)) via [@adamjcampbell](https://github.com/adamjcampbell)
- Merge release 1.0.3 into master ([#92](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/92)) via [@SwiftLeeBot](https://github.com/SwiftLeeBot)

### 1.0.3
- Profile.Attributes createDate should be createdDate ([#90](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues/90)) via [@orj](https://github.com/orj)
- APIEndpoint.listBundleIds doesn't have 'include' parameter. ([#88](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues/88)) via [@orj](https://github.com/orj)
- Naming mismatch for `include` field in Response ([#86](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues/86)) via [@DechengMa](https://github.com/DechengMa)
- Merge release 1.0.2 into master ([#85](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/85)) via [@SwiftLeeBot](https://github.com/SwiftLeeBot)

### 1.0.2
- Add test target for development ([#84](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/84)) via [@adamjcampbell](https://github.com/adamjcampbell)
- Fix filter naming mismatch in ListBuilds ([#83](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/83)) via [@DechengMa](https://github.com/DechengMa)
- Implement list users limit ([#82](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/82)) via [@adamjcampbell](https://github.com/adamjcampbell)
- Fix ListBetaTesters.Fields ([#80](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/80)) via [@yonaskolb](https://github.com/yonaskolb)
- Merge release 1.0.1 into master ([#79](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/79)) via [@SwiftLeeBot](https://github.com/SwiftLeeBot)

### 1.0.1
- Device.attributes.devicesClass is misnamed ([#76](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues/76)) via @ruipfcosta
- Wrong response type for getAllCertificates call ([#72](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/72)) via @ristkof
- Merge release 1.0.0 into master ([#74](https://github.com/AvdLee/appstoreconnect-swift-sdk/pull/74)) via @SwiftLeeBot

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