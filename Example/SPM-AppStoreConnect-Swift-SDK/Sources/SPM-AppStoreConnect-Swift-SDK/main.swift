import Foundation
import AppStoreConnect_Swift_SDK

/// Go to https://appstoreconnect.apple.com/access/api and create your own key. This is also the page to find the private key ID and the issuer ID.
/// Download the private key and open it in a text editor. Remove the line breaks from the private key string and copy the contents over to the private key parameter.
private let configuration = APIConfiguration(issuerID: "<YOUR ISSUER ID>", privateKeyID: "<YOUR PRIVATE KEY ID>", privateKey: "<YOUR PRIVATE KEY>")
var provider: APIProvider = APIProvider(configuration: configuration)

let endpoint = APIEndpoint.apps(
    select: [.apps([.name]), .builds([.version, .processingState, .uploadedDate])],
    include: [.builds],
    sortBy: [.bundleIdAscending],
    limits: [.apps(1)])

provider.request(endpoint) {
        switch $0 {
        case .success(let appsResponse):
            typealias BuildInfo = (uploadedDate: Date, version: String, processingState: String)
            guard
                let app = appsResponse.data.first,
                let name = app.attributes?.name,
                let buildInfos = appsResponse.included?.compactMap({ included -> BuildInfo? in
                    if case let .build(build) = included,
                        let uploadedDate = build.attributes?.uploadedDate,
                        let version = build.attributes?.version,
                        let processingState = build.attributes?.processingState {
                        return (uploadedDate: uploadedDate, version: version, processingState: processingState)
                    }
                    return nil
                }) else {
                    print("Could not find requested relationships!")
                    exit(EXIT_FAILURE)
            }

            print("App name is \(name)")
            print(" - successfully got \(buildInfos.count) builds included")
            for info in buildInfos.sorted(by: { $0.uploadedDate > $1.uploadedDate }) {
                print("  - \(info.version): \(info.processingState)")
            }

            exit(EXIT_SUCCESS)
        case .failure(let error):
            print("Something went wrong fetching the apps: \(error)")
            exit(EXIT_FAILURE)
        }
}

// Wait for request completion
RunLoop.current.run()
