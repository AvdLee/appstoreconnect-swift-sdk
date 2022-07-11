//
//  AppsListView.swift
//  Shared
//
//  Created by Antoine van der Lee on 11/07/2022.
//

import SwiftUI
import AppStoreConnect_Swift_SDK

//extension AppStoreConnect_Swift_SDK.App: Identifiable {
//    var id: String { bundle}
//}

struct AppsListView: View {
    @ObservedObject var viewModel = AppsListViewModel()

    var body: some View {
        ZStack {
            List(viewModel.apps, id: \.id) { app in
                VStack {
                    Text(app.attributes?.name ?? "Unknown name")
                    Text(app.attributes?.bundleID ?? "Unknown bundle ID")
                }
            }
            ProgressView()
                .opacity(viewModel.apps.isEmpty ? 1.0 : 0.0)
        }
        Text("Hello, world!")
            .padding()
    }
}

struct AppsListView_Previews: PreviewProvider {
    static var previews: some View {
        AppsListView()
    }
}

final class AppsListViewModel: ObservableObject {
    @Published var apps: [AppStoreConnect_Swift_SDK.App] = []

    /// Go to https://appstoreconnect.apple.com/access/api and create your own key. This is also the page to find the private key ID and the issuer ID.
    /// Download the private key and open it in a text editor. Remove the enters and copy the contents over to the private key parameter.
    private let configuration = APIConfiguration(issuerID: "<YOUR ISSUER ID>", privateKeyID: "<YOUR PRIVATE KEY ID>", privateKey: "<YOUR PRIVATE KEY>")
    private lazy var provider: APIProvider = APIProvider(configuration: .rocketSimConfiguration)

    func loadApps() {
        let request = APIEndpoint
            .apps
            .get(parameters: .init(
                sort: [.bundleID],
                fieldsApps: [.appInfos, .name],
                limit: 5
            ))


        do {
            apps = try await provider.request(request).data
        } catch {
            print("Something went wrong fetching the apps: \(error)")
        }
    }
    
//    private func printDetails(for app: App, appsResponse: AppsResponse) {
//        guard
//            let name = app.attributes?.name,
//            let includedItems = appsResponse.included else {
//                print("Could not find requested relationships!")
//                return
//        }
//
//        let buildInfos: [Build] = includedItems.compactMap { included -> Build? in
//            if case let .build(build) = included {
//                return build
//            }
//            return nil
//        }.sorted { lhsBuild, rhsBuild in
//            guard let lhsDate = lhsBuild.attributes?.uploadedDate, let rhsDate = rhsBuild.attributes?.uploadedDate else {
//                return false
//            }
//            return lhsDate > rhsDate
//        }
//
//        print("App name is \(name)")
//        print(" - successfully got \(buildInfos.count) builds included")
//
//        for buildInfo in buildInfos {
//            guard let version = buildInfo.attributes?.version,
//                  let processingState = buildInfo.attributes?.processingState else {
//                continue
//            }
//            print("  - \(version): \(processingState)")
//        }
//    }
}
