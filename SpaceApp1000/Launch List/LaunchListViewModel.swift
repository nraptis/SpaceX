//
//  LaunchListViewModel.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/13/23.
//

import Foundation
import SwiftUI

actor LaunchListViewModel: ObservableObject {
    
    @MainActor @Published var navigationPath = NavigationPath()
    @MainActor @Published var launches = [Launch]()
    @MainActor @Published var isFetchingLaunches = false
    @MainActor @Published var didFailToFetchLaunches = false
    @MainActor @Published var isFetchingLaunchDetails = false
    
    let network: NetworkController
    init(network: NetworkController) {
        self.network = network
        
        Task {
            do {
                try await refreshLaunches()
            } catch let error {
                print("refresh launches error: \(error.localizedDescription)")
            }
        }
    }
    
    func refreshLaunches() async throws {
        await MainActor.run {
            isFetchingLaunches = true
        }
        let _launches = try await network.launches()
        await MainActor.run {
            self.launches = _launches
            isFetchingLaunches = false
        }
    }
    
    @MainActor func select(launch: Launch) async {
        isFetchingLaunchDetails = true
        var rocket: Rocket?
        if let rocketID = launch.rocket {
            do {
                let _rocket = try await network.rocket(id: rocketID)
                rocket = _rocket
            } catch let error {
                print("rocket fetch error: \(error.localizedDescription)")
            }
        }
        
        var launchpad: Launchpad?
        if let launchpadID = launch.launchpad {
            do {
                let _launchpad = try await network.launchpad(id: launchpadID)
                launchpad = _launchpad
            } catch let error {
                print("launchpad fetch error: \(error.localizedDescription)")
            }
        }
        
        let launchDetailsViewModel = LaunchDetailsViewModel(launchListViewModel: self,
                                                            network: network,
                                                            launch: launch,
                                                            rocket: rocket,
                                                            launchpad: launchpad)
        isFetchingLaunchDetails = false
        navigationPath.append(launchDetailsViewModel)
    }
}

extension LaunchListViewModel {
    
    static func mock() -> LaunchListViewModel {
        let network = NetworkController()
        return LaunchListViewModel(network: network)
    }
}
