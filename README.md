# App Store Connect Swift SDK
The Swift SDK to work with the App Store Connect API from Apple.

![Bitrise Status](https://app.bitrise.io/app/af49e5de1f935d23.svg?token=3lWTmdlNhbHtdG9KsuR9gw) [![Swift Version](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FAvdLee%2Fappstoreconnect-swift-sdk%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/AvdLee/appstoreconnect-swift-sdk) [![Platform Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FAvdLee%2Fappstoreconnect-swift-sdk%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/AvdLee/appstoreconnect-swift-sdk) ![Dependency frameworks](https://img.shields.io/badge/Supports-_Swift_Package_Manager-F16D39.svg?style=flat) [![Twitter](https://img.shields.io/badge/twitter-@Twannl-blue.svg?style=flat)](https://twitter.com/twannl)

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
- [x] Supports _all_ requests due to OpenAPI generated requests and entities

## Requesting API Access
To request access, go to the new API Keys section in Users and Access in App Store Connect. Please note that you must be the Team Agent (Legal role) of a development team enrolled as an organization. Access for developers enrolled as an individual is coming soon.

## How to use the SDK?
*Not all endpoints are available yet, we're working hard to implement them all (see [Endpoints](Sources/Endpoints)).*

#### 1. Import the framework:

```swift
import AppStoreConnect_Swift_SDK
```

#### 2. Create your API Configuration
Go to [https://appstoreconnect.apple.com/access/integrations/api](https://appstoreconnect.apple.com/access/integrations/api) and create your own key. This is also the page to find your private key ID and the issuer ID.

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

Alternatively you can pass the path to the .p8 file:

```swift
let configuration = APIConfiguration(issuerID: "<YOUR ISSUER ID>", privateKeyID: "<YOUR PRIVATE KEY ID>", privateKeyURL: URL(fileURLWithPath: "~/AuthKey_<YOUR PRIVATE KEY ID>.p8"))
```

Both methods also accept an optional `expirationDuration` parameter that defaults to 20 minutes which is the max duration allowed by the API. In some cases it might be useful to specify a shorter value in seconds to account for possible clock skews:

```swift
APIConfiguration(issuerID: "<YOUR ISSUER ID>", privateKeyID: "<YOUR PRIVATE KEY ID>", privateKey: "<YOUR PRIVATE KEY>", expirationDuration: "<OPTIONAL EXPIRATION DURATION>"))
APIConfiguration(issuerID: "<YOUR ISSUER ID>", privateKeyID: "<YOUR PRIVATE KEY ID>", privateKeyURL: URL(fileURLWithPath: "~/AuthKey_<YOUR PRIVATE KEY ID>.p8"), expirationDuration: "<OPTIONAL EXPIRATION DURATION>")
```

You can even omit the `privateKeyID` as it can be inferred from the name of the .p8 file.

#### 3. Create an APIProvider and perform a request
After creating an `APIProvider` instance with your `APIConfiguration` you can start performing your first request.

```swift
let request = APIEndpoint
    .v1
    .apps
    .get(parameters: .init(
        sort: [.bundleID],
        fieldsApps: [.appInfos, .name, .bundleID],
        limit: 5
    ))
let apps = try await self.provider.request(request).data
print("Did fetch \(apps.count) apps")
```

### Handling paged responses
If the responses from the API request can be delivered in multiple pages, you can iterate over all of them using an AsyncSequence or individually request the next page following the current one.

```swift
let request = APIEndpoint
    .v1
    .apps
    .get(parameters: .init(
        sort: [.bundleID],
        fieldsApps: [.appInfos, .name, .bundleID],
        limit: 2
    ))

// Demonstration of AsyncSequence result of APIProvider.paged(_)
var allApps: [App] = []
for try await pagedResult in provider.paged(request) {
    allApps.append(contentsOf: pagedResult.data)
}
print("There are \(allApps.count) apps in total")

// Demonstration of APIProvider.request(_:isPagedResponse:) and APIProvider.request(_: pageAfter:)
let firstPageResult = try await provider.request(request)
let firstPageApps = firstPageResult.data
print("The first page of results has \(firstPageApps.count) apps")

if provider.request(request, isPagedResponse: firstPageResult) {
    if let nextPage = try await provider.request(request, pageAfter: firstPageResult) {
        let secondPageApps = nextPage.data
        print("The second page of results has \(secondPageApps.count) apps")
    }
}
```

### Handling errors
Whenever an error is returned from a request, you can get the details by catching the error as follows:

```swift
do {
    print(try await self.provider.request(requestWithError).data)
} catch APIProvider.Error.requestFailure(let statusCode, let errorResponse, _) {
    print("Request failed with statuscode: \(statusCode) and the following errors:")
    errorResponse?.errors?.forEach({ error in
        print("Error code: \(error.code)")
        print("Error title: \(error.title)")
        print("Error detail: \(error.detail)")
    })
} catch {
    print("Something went wrong fetching the apps: \(error.localizedDescription)")
}
```

The error title and detail should help you solve the failure.
For more info regarding errors, see: [Parsing the Error Response Code](https://developer.apple.com/documentation/appstoreconnectapi/interpreting_and_handling_errors/parsing_the_error_response_code) as documented by Apple.

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. It is in early development, but this SDK does support its use on supported platforms.

Once you have your Swift package set up, adding the SDK as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/AvdLee/appstoreconnect-swift-sdk.git", .upToNextMajor(from: "2.0.0"))
]
```

## Development

To help with the development of this repository you need to follow the next steps:

- clone this repository
- download the submodules dependencies
```bash
git submodule update --init --recursive
bundle install
```
- if you get permission errors when running `bundle install`, it's possible that you have to install a newer version of Ruby along the default one shipped with macOS (instead of `3.2.2` used below, use the version number that is output at the end of the `ruby-install ruby` command):
```bash
brew install chruby ruby-install
ruby-install ruby
chruby 3.2.2
gem update --system
gem install bundler
```
- you should be able to run the tests
```bash
bundle exec fastlane test
```

### Update OpenAPI generated code

Install [jq](https://stedolan.github.io/jq/):
```bash
brew install jq
```

Run the following:

```bash
$ make update
```

This will attempt to download the App Store Connect [OpenAPI specification](https://developer.apple.com/sample-code/app-store-connect/app-store-connect-openapi-specification.zip) from Apple, and re-run the [CreateAPI](https://github.com/CreateAPI/CreateAPI) generator to produce the updated source code.

Alternatively, you can run `make download` and `make generate` individually.

## Communication

- If you **found a bug**, open an [issue](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues).
- If you **have a feature request**, open an [issue](https://github.com/AvdLee/appstoreconnect-swift-sdk/issues).
- If you **want to contribute**, submit a [pull request](https://github.com/AvdLee/appstoreconnect-swift-sdk/pulls).

## Applications that use the SDK

- [Starly: reviews, reply to apps](https://apps.apple.com/app/id1644699015) developed by [Viktor Grushevskiy](https://twitter.com/Viktorianec).
The Starly app is a project that will allow developers to manage reviews on the App Store with ease. You can reply to them, translate them to the language you want, filter them, and create templates. iOS and macOS versions available.

- [🌟 Superstar: App Store Review manager](https://apps.apple.com/us/app/superstar-respond-to-reviews/id1635833987) developed by [Jordi Bruin](https://twitter.com/jordibruin).
Superstar uses the App Store Connect API to help you respond to your App Store customer reviews in seconds. Use custom templates to quickly reply with professional responses. Translate reviews and your responses directly with free DeepL integration. Available for free for a limited time.

- [AppsMan: Manage app metada globally](https://apps.apple.com/app/id6443788342) developed by [Karmjit Singh](https://twitter.com/CodeWithKarma).
The AppsMan app is a project that will allow developers to manage apps localisable data on the App Store with ease. You can easily update the data for one language and copy over to other and save. You can see the previous versions details as well. Only macOS versions available.

- [Localiji: Localizations for App Store](https://apps.apple.com/us/app/localiji/id6467663963) developed by Nicolas Kick.
Localiji manages a local copy of your app localizations from App Store Connect and allows you to effortlessly sync the changes. Edit individual attributes, like your app’s description, release notes or screenshots. Export an entire language, import the translations again and upload them to App Store Connect with only a few clicks.

- [Five Stars: Reviews & Ratings](https://apps.apple.com/app/id1634650919) developed by [Mathias Emil Mortensen](https://github.com/mathiasemil).
Five Stars helps app developers read and reply to App Store reviews from their users. Translate reviews, reply with customizable templates and AI-powered quick replies, filter by region, and view global app ratings from any app. Five Stars is available for iPhone and iPad, with a Mac version coming in Spring 2024.


## License

**App Store Connect Swift SDK** is available under the MIT license, and uses source code from open source projects. See the [LICENSE](https://github.com/AvdLee/appstoreconnect-swift-sdk/blob/master/LICENSE) file for more info.

## Author

This project is originally created by [Antoine van der Lee](https://www.twitter.com/twannl) but has a lot of [great contributors](https://github.com/AvdLee/appstoreconnect-swift-sdk/graphs/contributors). We're open for contributions of any kind to make this project even better.
