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

        provider.request(Endpoints.apps()) { (result) in
            switch result {
            case .success(let appsResponse):
                print("Did fetch \(appsResponse.data.count) apps")
            case .failure(let error):
                print("Something went wrong fetching the apps: \(error)")
            }
        }
    }

}
