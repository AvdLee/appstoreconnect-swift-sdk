//
//  PhasedReleaseState.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by James Sherlock on 14/12/2020.
//

import Foundation

public enum PhasedReleaseState: String, Codable, CaseIterable {
    case inactive = "INACTIVE"
    case active = "ACTIVE"
    case paused = "PAUSED"
    case complete = "COMPLETE"
}
