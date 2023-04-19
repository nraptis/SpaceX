//
//  File 4.swift
//  
//
//  Created by Tiger Nixon on 4/12/23.
//

import Foundation

struct Rocket: Decodable {
    let id: String
    let name: String
    let description: String?
    let company: String?
    let firstFlight: String?
    let mass: MassMeasure?
    let firstStage: FirstStage?
    let secondStage: SecondStage?
    let engines: Engines?
    let type: String?
    let active: Bool?
    let stages: Int?
    let boosters: Int?
    
    struct SizeMeasure: Decodable {
        let meters: Double?
    }
    let height: SizeMeasure?
    let diameter: SizeMeasure?
    
    struct MassMeasure: Decodable {
        let kg: Double?
    }
    
    struct ForceMeasure: Decodable {
        let kN: Double?
    }
    
    struct FirstStage: Decodable {
        let thrustSeaLevel: ForceMeasure?
        let thrustVacuum: ForceMeasure?
        let reusable: Bool?
        let engines: Int?
        let fuelAmountTons: Double?
        let burnTimeSec: Double?
    }
    
    struct SecondStage: Decodable {
        struct Payloads: Decodable {
            struct CompositeFairing: Decodable {
                let height: SizeMeasure?
                let diameter: SizeMeasure?
            }
            let compositeFairing: CompositeFairing?
            let option1: String?
        }
        let payloads: Payloads?
        let thrust: ForceMeasure?
        let reusable: Bool?
        let engines: Int?
        let fuelAmountTons: Double?
        let burnTimeSec: Double?
    }
    
    struct Engines: Decodable {
        struct ISP: Decodable {
            let seaLevel: Double?
            let vacuum: Double?
        }
        let isp: ISP?
        let thrustSeaLevel: ForceMeasure?
        let thrustVacuum: ForceMeasure?
        let number: Int?
        let type: String?
        let version: String?
        let layout: String?
        let engineLossMax: Int?
        let propellant1: String?
        let propellant2: String?
        let thrustToWeight: Double?
    }
}

extension Rocket: Identifiable { }
extension Rocket: Sendable { }

extension Rocket.SecondStage {
    static func mock() -> Rocket.SecondStage {
        let compositeFairing = Rocket.SecondStage.Payloads.CompositeFairing(height: Rocket.SizeMeasure(meters: 13.1),
                                                                            diameter: Rocket.SizeMeasure(meters: 5.2))
        let payloads = Rocket.SecondStage.Payloads(compositeFairing: compositeFairing,
                                                   option1: "dragon")
        let thrust = Rocket.ForceMeasure(kN: 934.0)
        return Rocket.SecondStage(payloads: payloads,
                                  thrust: thrust,
                                  reusable: false,
                                  engines: 1,
                                  fuelAmountTons: 90.0,
                                  burnTimeSec: 397.0)
    }
}

extension Rocket.FirstStage {
    static func mock() -> Rocket.FirstStage {
        let thrustSeaLevel = Rocket.ForceMeasure(kN: 7607.0)
        let thrustVacuum = Rocket.ForceMeasure(kN: 8227.0)
        return Rocket.FirstStage(thrustSeaLevel: thrustSeaLevel,
                                 thrustVacuum: thrustVacuum,
                                 reusable: true,
                                 engines: 9,
                                 fuelAmountTons: 385.0,
                                 burnTimeSec: 162.0)
    }
}

extension Rocket.Engines {
    static func mock() -> Rocket.Engines {
        let isp = Rocket.Engines.ISP(seaLevel: 288.0, vacuum: 312.0)
        let thrustSeaLevel = Rocket.ForceMeasure(kN: 845.0)
        let thrustVacuum = Rocket.ForceMeasure(kN: 914.0)
        return Rocket.Engines(isp: isp,
                              thrustSeaLevel: thrustSeaLevel,
                              thrustVacuum: thrustVacuum,
                              number: 9,
                              type: "merlin",
                              version: "1D+",
                              layout: "octaweb",
                              engineLossMax: 2,
                              propellant1: "liquid oxygen",
                              propellant2: "RP-1 kerosene",
                              thrustToWeight: 180.1)
    }
}

extension Rocket {
    static func mock() -> Rocket {
        return Rocket(id: "5e9d0d95eda69973a809d1ec",
                      name: "Falcon 9",
                      description: "Falcon 9 is a two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit.",
                      company: "SpaceX",
                      firstFlight: "2010-06-04",
                      mass: Rocket.MassMeasure(kg: 549054.0),
                      firstStage: Rocket.FirstStage.mock(),
                      secondStage: Rocket.SecondStage.mock(),
                      engines: Rocket.Engines.mock(),
                      type: "rocket",
                      active: true,
                      stages: 2,
                      boosters: 0,
                      height: Rocket.SizeMeasure(meters: 70.0),
                      diameter: Rocket.SizeMeasure(meters: 3.7))
        
    }
}
