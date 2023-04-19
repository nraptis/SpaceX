//
//  LaunchpadDetailsViewModel.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/13/23.
//

import SwiftUI

actor LaunchpadDetailsViewModel: ObservableObject {
    let launchListViewModel: LaunchListViewModel
    let network: NetworkController
    @MainActor let launchpad: Launchpad
    @MainActor let rockets: [Rocket]
    @MainActor let launches: [Launch]
    
    init(launchListViewModel: LaunchListViewModel,
         network: NetworkController,
         launchpad: Launchpad,
         rockets: [Rocket],
         launches: [Launch]) {
        self.launchListViewModel = launchListViewModel
        self.network = network
        self.launchpad = launchpad
        self.rockets = rockets
        self.launches = launches
        
        print("LaunchpadDetailsViewModel => Created")
    }
    
    deinit {
        print("LaunchpadDetailsViewModel => Destroyed")
    }
    
    @MainActor func back() {
        launchListViewModel.navigationPath.removeLast()
    }
    
    @MainActor func select(launch: Launch) async {
        await launchListViewModel.select(launch: launch)
    }
    
    @MainActor func select(rocket: Rocket) async {
        let rocketDetailsViewModel = RocketDetailsViewModel(launchListViewModel: launchListViewModel,
                                                            network: network,
                                                            rocket: rocket)
        launchListViewModel.navigationPath.append(rocketDetailsViewModel)
    }
}

extension LaunchpadDetailsViewModel: Hashable {
    static func ==(lhs: LaunchpadDetailsViewModel, rhs: LaunchpadDetailsViewModel) -> Bool {
        lhs.launchpad.id == rhs.launchpad.id
    }
    
    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(launchpad.id)
    }
}

extension LaunchpadDetailsViewModel {
    static func mock() -> LaunchpadDetailsViewModel {
        let launchListViewModel = LaunchListViewModel.mock()
        return LaunchpadDetailsViewModel(launchListViewModel: launchListViewModel,
                                         network: launchListViewModel.network,
                                         launchpad: Launchpad.mock(),
                                         rockets: [Rocket.mock()],
                                         launches: [Launch.mock()])
    }
}

