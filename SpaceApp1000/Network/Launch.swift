//
//  File.swift
//  
//
//  Created by Tiger Nixon on 4/12/23.
//

import Foundation

struct Launch: Decodable {
    let id: String
    let name: String
    let rocket: String?
    let launchpad: String?
    let dateUtc: String?
    let flightNumber: Int?
    let success: Bool?
    let details: String?
}

extension Launch: Identifiable { }
extension Launch: Sendable { }

extension Launch {
    static func mock() -> Launch {
        Launch(id: "5eb87cd9ffd86e000604b32a",
               name: "FalconSat",
               rocket: "5e9d0d95eda69955f709d1eb",
               launchpad: "5e9e4502f5090995de566f86",
               dateUtc: "2006-03-24T22:30:00.000Z",
               flightNumber: 1,
               success: false,
               details: "Engine failure at 33 seconds and loss of vehicle")
    }
}
