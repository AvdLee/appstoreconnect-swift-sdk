import Foundation
import AppStoreConnect_Swift_SDK

/// Go to https://appstoreconnect.apple.com/access/api and create your own key. This is also the page to find the private key ID and the issuer ID.
/// Download the private key and open it in a text editor. Remove the enters and copy the contents over to the private key parameter.
private let configuration = APIConfiguration(issuerID: "<YOUR ISSUER ID>", privateKeyID: "<YOUR PRIVATE KEY ID>", privateKey: "<YOUR PRIVATE KEY>")
var provider: APIProvider = APIProvider(configuration: configuration)

ListApps(
    fields: [.apps([.name]), .builds([.version])],
    relationships: [.builds],
    sortBy: [.ascending(.bundleId)],
    limits: [.apps(1)])
    .request(using: provider) { (result) in
        switch result {
        case .success(let appsResponse):
            
            guard let app = appsResponse.data.first,
                let name = app.attributes?.name,
                let buildVersions = appsResponse.included?.compactMap({ $0.build?.attributes?.version }) else {
                    print("Could not find requested relationships!")
                    exit(EXIT_FAILURE)
            }
            
            print("App name is \(name)")
            print(" - successfully got \(buildVersions.count) builds included")
            for build in buildVersions {
                print("  - \(build)")
            }
            
            exit(EXIT_SUCCESS)
        case .failure(let error):
            print("Something went wrong fetching the apps: \(error)")
            exit(EXIT_FAILURE)
        }
}

// Wait for request completion
RunLoop.current.run()
