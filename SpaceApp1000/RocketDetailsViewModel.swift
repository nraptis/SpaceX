//
//  RocketDetailsViewModel.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/13/23.
//

import Foundation

actor RocketDetailsViewModel: ObservableObject {
    let launchListViewModel: LaunchListViewModel
    let network: NetworkController
    @MainActor let rocket: Rocket
    init(launchListViewModel: LaunchListViewModel,
         network: NetworkController,
         rocket: Rocket) {
        self.launchListViewModel = launchListViewModel
        self.network = network
        self.rocket = rocket
        print("RocketDetailsViewModel => Created")
    }
    
    deinit {
        print("RocketDetailsViewModel => Destroyed")
    }
    
    @MainActor func back() {
     
        launchListViewModel.navigationPath.removeLast()
    }
}

extension RocketDetailsViewModel: Hashable {
    static func ==(lhs: RocketDetailsViewModel, rhs: RocketDetailsViewModel) -> Bool {
        lhs.rocket.id == rhs.rocket.id
    }
    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(rocket.id)
    }
}

extension RocketDetailsViewModel {
    
    static func mock() -> RocketDetailsViewModel {
        let launchListViewModel = LaunchListViewModel.mock()
        return RocketDetailsViewModel(launchListViewModel: launchListViewModel,
                                      network: launchListViewModel.network,
                                      rocket: Rocket.mock())
    }
}
