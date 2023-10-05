//
//  Model.swift
//  spaceXTracker
//
//  Created by Mustafa Yanar on 5.10.2023.
//

struct SpaceXLaunchInfo: Codable {
    let name: String
    let details: String?
    let links: Links
    let date_utc: String
}

struct Links: Codable {
    let patch: Patch
}

struct Patch: Codable {
    let small: String
    let large: String
}
