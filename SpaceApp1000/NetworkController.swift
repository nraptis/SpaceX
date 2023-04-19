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
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches/") else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession(configuration: .ephemeral).data(from: url, delegate: nil)
        guard let urlResponse = response as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        guard (200...299).contains(urlResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        let launches = try decoder.decode([Launch].self, from: data)
        return launches
    }
    
    func rockets() async throws -> [Rocket] {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets/") else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession(configuration: .ephemeral).data(from: url, delegate: nil)
        guard let urlResponse = response as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        guard (200...299).contains(urlResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try decoder.decode([Rocket].self, from: data)
    }
    
    func rocket(id: String) async throws -> Rocket {
        
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets/\(id)") else {
            throw URLError(.badURL)
        }
        print(url.absoluteString)
        let (data, response) = try await URLSession(configuration: .ephemeral).data(from: url, delegate: nil)
        guard let urlResponse = response as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        guard (200...299).contains(urlResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try decoder.decode(Rocket.self, from: data)
    }
    
    func launchpad(id: String) async throws -> Launchpad {
        
        guard let url = URL(string: "https://api.spacexdata.com/v4/launchpads/\(id)") else {
            throw URLError(.badURL)
        }
        let (data, response) = try await URLSession(configuration: .ephemeral).data(from: url, delegate: nil)
        guard let urlResponse = response as? HTTPURLResponse else {
            throw URLError(.cannotParseResponse)
        }
        guard (200...299).contains(urlResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try decoder.decode(Launchpad.self, from: data)
    }
}
