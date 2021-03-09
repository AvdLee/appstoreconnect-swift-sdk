# App Store Connect Swift SDK
The Swift SDK to work with the App Store Connect API from Apple.

![Bitrise Status](https://app.bitrise.io/app/af49e5de1f935d23.svg?token=3lWTmdlNhbHtdG9KsuR9gw) [![Swift Version](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FAvdLee%2Fappstoreconnect-swift-sdk%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/AvdLee/appstoreconnect-swift-sdk) [![Platform Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FAvdLee%2Fappstoreconnect-swift-sdk%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/AvdLee/appstoreconnect-swift-sdk) ![Dependency frameworks](https://img.shields.io/badge/Supports-CocoaPods,_Swift_Package_Manager-F16D39.svg?style=flat) [![Twitter](https://img.shields.io/badge/twitter-@Twannl-blue.svg?style=flat)](https://twitter.com/twannl)

## Kickstart information on the API
- [Automate your workflow with the App Store Connect API](https://developer.apple.com/app-store-connect/api/)
- [Official Apple Documentation](https://developer.apple.com/documentation/appstoreconnectapi)
- WWDC 2018 Talk [Automating App Store Connect](https://developer.apple.com/videos/play/wwdc2018/303/)
- [App Store Connect API adoption with use case examples](https://www.avanderlee.com/general/app-store-connect-api-adoption/)

## Included in this SDK
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

## Requesting API Access
To request access, go to the new API Keys section in Users and Access in App Store Connect. Please note that you must be the Team Agent (Legal role) of a development team enrolled as an organization. Access for developers enrolled as an individual is coming soon.

## How to use the SDK?
*Not all endpoints are available yet, we're working hard to implement them all (see [Endpoints](Sources/Endpoints)).*

#### 1. Import the framework:

```swift
import AppStoreConnect_Swift_SDK
```

#### 2. Create your API Configuration
Go to [https://appstoreconnect.apple.com/access/api](https://appstoreconnect.apple.com/access/api) and create your own key. This is also the page to find your private key ID and the issuer ID.

After downloading your private key, you can open the .p8 file containing the private key in a text editor which will show like the following content:

```
-----BEGIN PRIVATE KEY-----
FDFDGgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwQgPaXyFvZfNydDEjxgjUCUxyGjXcQxiulEdGxoVbasV3GgCgYIKomokDj0DAQehRANCAAASffd/DU3TUWAoLmqE6hZL9A7i0DWpXtmIDCDiITRznC6K4/WjdIcuMcixy+m6O0IrffxJOablIX2VM8sHRpoiuy
-----END PRIVATE KEY-----
```

Copy the contents and remove the whitelines, `-----BEGIN PRIVATE KEY-----` and `-----END PRIVATE KEY-----`.

Use this private key together with the issuer ID and the private key ID to create your configuration file:

```swift
let configuration = APIConfiguration(issuerID: "<YOUR ISSUER ID>", privateKeyID: "<YOUR PRIVATE KEY ID>", privateKey: "<YOUR PRIVATE KEY>")
```

#### 3. Create an APIProvider and perform a request
After creating an `APIProvider` instance with your `APIConfiguration` you can start performing your first request.

```swift
let provider: APIProvider = APIProvider(configuration: configuration)

provider.request(.apps()) { (result) in
    switch result {
    case .success(let appsResponse):
        print("Did fetch \(appsResponse.data.count) apps")
    case .failure(let error):
        print("Something went wrong fetching the apps: \(error)")
    }
}
```

## Installation

### CocoaPods
AppStoreConnect-Swift-SDK will be available through [CocoaPods](https://cocoapods.org) when it's more complete. To install
it now, simply add the following line to your Podfile:

```ruby
pod 'AppStoreConnect-Swift-SDK', :git => 'https://github.com/AvdLee/appstoreconnect-swift-sdk.git'

```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but this SDK does support its use on supported platforms. 

Once you have your Swift package set up, adding the SDK as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/AvdLee/appstoreconnect-swift-sdk.git", .upToNextMajor(from: "1.0.0"))
]
```

## Development

To help with the development of this repository you need to follow the next steps:

- clone this repository
- download the submodules dependencies 
```bash
git submodule update --init --recursive
```
- run the fastlane called: unhide_spm_package_dev_dependencies
```bash
bundle exec fastlane unhide_spm_package_dev_dependencies
```
- you should be able to run the tests
```bash
bundle exec fastlane test
```


## Communication

- If you **found a bug**, open an [issue](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues).
- If you **have a feature request**, open an [issue](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues).
- If you **want to contribute**, submit a [pull request](https://github.com/AvdLee/appstoreconnect-swift-sdk/pulls).


## License

**App Store Connect Swift SDK** is available under the MIT license, and uses source code from open source projects. See the [LICENSE](https://github.com/AvdLee/appstoreconnect-swift-sdk/blob/master/LICENSE) file for more info.

## Author

This project is originally created by [Antoine van der Lee](https://www.twitter.com/twannl) but has a lot of [great contributors](https://github.com/AvdLee/appstoreconnect-swift-sdk/graphs/contributors). We're open for contributions of any kind to make this project even better.
