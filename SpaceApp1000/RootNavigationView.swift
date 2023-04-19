//
//  RootNavigationView.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/13/23.
//

import SwiftUI

struct RootNavigationView: View {
    @ObservedObject var launchListViewModel: LaunchListViewModel
    var body: some View {
        NavigationStack(path: $launchListViewModel.navigationPath) {
            LaunchListView(launchListViewModel: launchListViewModel)
                .navigationDestination(for: LaunchDetailsViewModel.self) { launchDetailsViewModel in
                    LaunchDetailsView(launchDetailsViewModel: launchDetailsViewModel)
                }
                .navigationDestination(for: RocketDetailsViewModel.self) { rocketDetailsViewModel in
                    RocketDetailsView(rocketDetailsViewModel: rocketDetailsViewModel)
                }
                .navigationDestination(for: LaunchpadDetailsViewModel.self) { launchpadDetailsViewModel in
                    LaunchpadDetailsView(launchpadDetailsViewModel: launchpadDetailsViewModel)
                }
        }
    }
}

struct RootNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        RootNavigationView(launchListViewModel: LaunchListViewModel.mock())
    }
}
