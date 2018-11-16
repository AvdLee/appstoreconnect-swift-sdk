import Foundation
import AppStoreConnect_Swift_SDK

/// Go to https://appstoreconnect.apple.com/access/api and create your own key. This is also the page to find the private key ID and the issuer ID.
/// Download the private key and open it in a text editor. Remove the enters and copy the contents over to the private key parameter.
private let configuration = APIConfiguration(issuerID: "<YOUR ISSUER ID>", privateKeyID: "<YOUR PRIVATE KEY ID>", privateKey: "<YOUR PRIVATE KEY>")
var provider: APIProvider = APIProvider(configuration: configuration)

provider.request(Endpoints.apps()) { (result) in
    switch result {
    case .success(let appsResponse):
        print("Did fetch \(appsResponse.data.count) apps")
        exit(EXIT_SUCCESS)
    case .failure(let error):
        print("Something went wrong fetching the apps: \(error)")
        exit(EXIT_FAILURE)
    }
}

// Wait for request completion
RunLoop.current.run()
