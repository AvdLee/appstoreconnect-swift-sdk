# App Store Connect Swift SDK
The Swift SDK to work with the App Store Connect API from Apple.

![Swift Version](https://img.shields.io/badge/Swift-4.2-F16D39.svg?style=flat) ![Dependency frameworks](https://img.shields.io/badge/Supports-CocoaPods,_Swift_Package_Manager-F16D39.svg?style=flat) [![Twitter](https://img.shields.io/badge/twitter-@Twannl-blue.svg?style=flat)](https://twitter.com/twannl)

## Kickstart information on the API
- [Automate your workflow with the App Store Connect API](https://developer.apple.com/app-store-connect/api/)
- [Official Apple Documentation](https://developer.apple.com/documentation/appstoreconnectapi)
- WWDC 2018 Talk [Automating App Store Connect](https://developer.apple.com/videos/play/wwdc2018/303/)
- [App Store Connect API adoption with use case examples](https://www.avanderlee.com/general/app-store-connect-api-adoption/)

## Included in this SDK
- [x] Configuration with API Key
- [x] APIProver with endpoints structure
- [ ] TestFlight API implementation
- [ ] Get started section in the readme
- [ ] Users and Roles implementation
- [ ] Sales and Finances implementation
- [ ] Replace Alamofire dependency with own simple URLSession implementation

## Requesting API Access
To request access, go to the new API Keys section in Users and Access in App Store Connect. Please note that you must be the Team Agent (Legal role) of a development team enrolled as an organization. Access for developers enrolled as an individual is coming soon.

## Installation

### CocoaPods
AppStoreConnect-Swift-SDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AppStoreConnect-Swift-SDK'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but this SDK does support its use on supported platforms. 

Once you have your Swift package set up, adding the SDK as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/AvdLee/appstoreconnect-swift-sdk.git")
]
```

## Communication

- If you **found a bug**, open an [issue](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues).
- If you **have a feature request**, open an [issue](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues).
- If you **want to contribute**, submit a [pull request](https://github.com/AvdLee/appstoreconnect-swift-sdk/pulls).


## License

**App Store Connect Swift SDK** is available under the MIT license. See the [LICENSE](https://github.com/AvdLee/appstoreconnect-swift-sdk/blob/master/LICENSE) file for more info.
