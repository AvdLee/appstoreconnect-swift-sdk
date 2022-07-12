//
//  AppsListView.swift
//  Shared
//
//  Created by Antoine van der Lee on 11/07/2022.
//

import SwiftUI
import AppStoreConnect_Swift_SDK

struct AppsListView: View {
    @ObservedObject var viewModel = AppsListViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                List(viewModel.apps, id: \.id) { app in
                    VStack(alignment: .leading) {
                        Text(app.attributes?.name ?? "Unknown name")
                            .font(.headline)
                        Text(app.attributes?.bundleID ?? "Unknown bundle ID")
                            .font(.subheadline)
                    }
                }
                ProgressView()
                    .opacity(viewModel.apps.isEmpty ? 1.0 : 0.0)
            }.navigationTitle("List of Apps")
        }.onAppear {
            viewModel.loadApps()
        }
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
    private lazy var provider: APIProvider = APIProvider(configuration: configuration)

    func loadApps() {
        Task.detached {
            let request = APIEndpoint
                .apps
                .get(parameters: .init(
                    sort: [.bundleID],
                    fieldsApps: [.appInfos, .name, .bundleID],
                    limit: 5
                ))

            do {
                let apps = try await self.provider.request(request).data
                await self.updateApps(to: apps)
            } catch {
                print("Something went wrong fetching the apps: \(error)")
            }
        }
    }

    @MainActor
    private func updateApps(to apps: [AppStoreConnect_Swift_SDK.App]) {
        self.apps = apps
    }
}
