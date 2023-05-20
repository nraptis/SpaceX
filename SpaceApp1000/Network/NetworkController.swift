//
//  NetworkController.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/12/23.
//

import Foundation

actor NetworkController {
    
    private lazy var decoder: JSONDecoder = {
        let result = JSONDecoder()
        result.keyDecodingStrategy = .convertFromSnakeCase
        return result
    }()
    
    func launches() async throws -> [Launch] {
        try await download(url: "https://api.spacexdata.com/v4/launches/", type: [Launch].self)
    }
    
    func rockets() async throws -> [Rocket] {
        try await download(url: "https://api.spacexdata.com/v4/rockets/", type: [Rocket].self)
    }
    
    func rocket(id: String) async throws -> Rocket {
        try await download(url: "https://api.spacexdata.com/v4/rockets/\(id)", type: Rocket.self)
    }
    
    func launchpad(id: String) async throws -> Launchpad {
        try await download(url: "https://api.spacexdata.com/v4/launchpads/\(id)", type: Launchpad.self)
    }
    
    private func download<DataType: Decodable>(url: String, type: DataType.Type) async throws -> DataType {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession(configuration: .ephemeral).data(from: url, delegate: nil)
        guard let urlResponse = response as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        guard (200...299).contains(urlResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try decoder.decode(DataType.self, from: data)
    }
    
}
