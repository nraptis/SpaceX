//
//  File 4.swift
//  
//
//  Created by Tiger Nixon on 4/12/23.
//

import Foundation

struct Launchpad: Decodable {
    let id: String
    let name: String
    let fullName: String?
    
    let region: String?
    let launchAttempts: Int?
    let launchSuccesses: Int?
    let rockets: [String]?
    let launches: [String]?
    let details: String?
}

extension Launchpad: Identifiable { }
extension Launchpad: Sendable { }

extension Launchpad {
    static func mock() -> Launchpad {
        Launchpad(id: "5e9e4502f5090995de566f86",
                  name: "Kwajalein Atoll",
                  fullName: "Kwajalein Atoll Omelek Island",
                  region: "Marshall Islands",
                  launchAttempts: 5,
                  launchSuccesses: 2,
                  rockets: ["5e9d0d95eda69955f709d1eb"],
                  launches: ["5eb87cd9ffd86e000604b32a", "5eb87cdaffd86e000604b32b", "5eb87cdbffd86e000604b32c", "5eb87cdbffd86e000604b32d", "5eb87cdcffd86e000604b32e"],
                  details: "SpaceX's original pad, where all of the Falcon 1 flights occurred (from 2006 to 2009). It would have also been the launch site of the Falcon 1e and the Falcon 9, but it was abandoned as SpaceX ended the Falcon 1 program and decided against upgrading it to support Falcon 9, likely due to its remote location and ensuing logistics complexities.")
    }
}
