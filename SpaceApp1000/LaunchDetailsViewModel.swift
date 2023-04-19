//
//  LaunchDetailsViewModel.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/13/23.
//

import Foundation

actor LaunchDetailsViewModel: ObservableObject {
    let launchListViewModel: LaunchListViewModel
    let network: NetworkController
    @MainActor let launch: Launch
    @MainActor let rocket: Rocket?
    @MainActor let launchpad: Launchpad?
    
    @MainActor @Published var isLoadingLaunchpadDetails = false
    
    init(launchListViewModel: LaunchListViewModel,
         network: NetworkController,
         launch: Launch,
         rocket: Rocket?,
         launchpad: Launchpad?) {
        self.launchListViewModel = launchListViewModel
        self.network = network
        self.launch = launch
        self.rocket = rocket
        self.launchpad = launchpad
        
        print("LaunchDetailsViewModel => Created")
    }
    
    deinit {
        print("LaunchDetailsViewModel => Destroyed")
    }
    
    @MainActor func back() {
        launchListViewModel.navigationPath.removeLast()
    }
    
    @MainActor func select(rocket: Rocket) async {
        let rocketDetailsViewModel = RocketDetailsViewModel(launchListViewModel: launchListViewModel,
                                                            network: network,
                                                            rocket: rocket)
        launchListViewModel.navigationPath.append(rocketDetailsViewModel)
    }
    
    @MainActor func select(launchpad: Launchpad) async {
        
        isLoadingLaunchpadDetails = true
        
        var rockets = [Rocket]()
        var rocketSet = Set<String>()
        if let rockets = launchpad.rockets {
            for rocketID in rockets {
                rocketSet.insert(rocketID)
            }
        }
        if rocketSet.count > 0 {
            do {
                let _rockets = try await network.rockets()
                for rocket in _rockets {
                    if rocketSet.contains(rocket.id) {
                        rockets.append(rocket)
                    }
                }
            } catch let error {
                print("rockets fetch error: \(error.localizedDescription)")
            }
        }
        
        var launches = [Launch]()
        var launchSet = Set<String>()
        if let launches = launchpad.launches {
            for launchID in launches {
                launchSet.insert(launchID)
            }
        }
        if launchSet.count > 0 {
            do {
                let _launches = try await network.launches()
                for launch in _launches {
                    if launchSet.contains(launch.id) {
                        launches.append(launch)
                    }
                }
            } catch let error {
                print("launches fetch error: \(error.localizedDescription)")
            }
        }
        
        let launchpadDetailsViewModel = LaunchpadDetailsViewModel(launchListViewModel: launchListViewModel,
                                                                  network: network,
                                                                  launchpad: launchpad,
                                                                  rockets: rockets,
                                                                  launches: launches)
        isLoadingLaunchpadDetails = false
        launchListViewModel.navigationPath.append(launchpadDetailsViewModel)
    }
}

extension LaunchDetailsViewModel: Hashable {
    static func ==(lhs: LaunchDetailsViewModel, rhs: LaunchDetailsViewModel) -> Bool {
        lhs.launch.id == rhs.launch.id
    }
    
    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(launch.id)
    }
}

extension LaunchDetailsViewModel {
    static func mock() -> LaunchDetailsViewModel {
        let launchListViewModel = LaunchListViewModel.mock()
        return LaunchDetailsViewModel(launchListViewModel: launchListViewModel,
                                      network: launchListViewModel.network,
                                      launch: Launch.mock(),
                                      rocket: Rocket.mock(),
                                      launchpad: Launchpad.mock())
    }
}
