//
//  SpaceApp1000App.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/12/23.
//

import SwiftUI

@main
struct SpaceApp1000App: App {
    @StateObject var launchListViewModel = LaunchListViewModel(network: NetworkController())
    var body: some Scene {
        WindowGroup {
            RootNavigationView(launchListViewModel: launchListViewModel)
        }
    }
}
