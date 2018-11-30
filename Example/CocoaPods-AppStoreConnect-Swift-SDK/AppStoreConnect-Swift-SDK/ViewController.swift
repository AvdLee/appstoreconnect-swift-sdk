//
//  ViewController.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by ajvanderlee@gmail.com on 11/08/2018.
//  Copyright (c) 2018 ajvanderlee@gmail.com. All rights reserved.
//

import UIKit
import AppStoreConnect_Swift_SDK

final class ViewController: UIViewController {

    /// Go to https://appstoreconnect.apple.com/access/api and create your own key. This is also the page to find the private key ID and the issuer ID.
    /// Download the private key and open it in a text editor. Remove the enters and copy the contents over to the private key parameter.
    private let configuration = APIConfiguration(issuerID: "<YOUR ISSUER ID>", privateKeyID: "<YOUR PRIVATE KEY ID>", privateKey: "<YOUR PRIVATE KEY>")
    lazy var provider: APIProvider = APIProvider(configuration: configuration)

    override func viewDidLoad() {
        super.viewDidLoad()

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
                            return
                    }
                    
                    print("App name is \(name)")
                    print(" - successfully got \(buildInfos.count) builds included")
                    for info in buildInfos.sorted(by: { $0.uploadedDate > $1.uploadedDate }) {
                        print("  - \(info.version): \(info.processingState)")
                    }
                case .failure(let error):
                    print("Something went wrong fetching the apps: \(error)")
                }
        }
    }
}
