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
    lazy var provider: APIProvider = APIProvider(configuration: .rocketSimConfiguration)

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Fetching apps ..")

        Task {
            let request = APIEndpoint
                .apps
                .get(parameters: .init(
                    sort: [.bundleID],
                    fieldsApps: [.appInfos, .builds, .name],
                    limit: 5,
                    include: [.builds],
                    fieldsBuilds: [.version, .processingState, .uploadedDate]
                ))

            do {
                let appsResponse = try await provider.request(request)
                appsResponse.data.forEach({ app in
                    printDetails(for: app, appsResponse: appsResponse)
                })
            } catch {
                print("Something went wrong fetching the apps: \(error)")
            }
        }
    }

    private func printDetails(for app: App, appsResponse: AppsResponse) {
        guard
            let name = app.attributes?.name,
            let includedItems = appsResponse.included else {
                print("Could not find requested relationships!")
                return
        }

        let buildInfos: [Build] = includedItems.compactMap { included -> Build? in
            if case let .build(build) = included {
                return build
            }
            return nil
        }.sorted { lhsBuild, rhsBuild in
            guard let lhsDate = lhsBuild.attributes?.uploadedDate, let rhsDate = rhsBuild.attributes?.uploadedDate else {
                return false
            }
            return lhsDate > rhsDate
        }

        print("App name is \(name)")
        print(" - successfully got \(buildInfos.count) builds included")

        for buildInfo in buildInfos {
            guard let version = buildInfo.attributes?.version,
                  let processingState = buildInfo.attributes?.processingState else {
                continue
            }
            print("  - \(version): \(processingState)")
        }
    }
}
