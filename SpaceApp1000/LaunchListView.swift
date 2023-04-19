//
//  LaunchListView.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/13/23.
//

import SwiftUI

struct LaunchListView: View {
    @ObservedObject var launchListViewModel: LaunchListViewModel
    var body: some View {
        ZStack {
            VStack(spacing: 0.0) {
                TitleBarView(title: "Launches",
                             backAction: nil)
                
                /*
                List(launchListViewModel.launches) { launch in
                    
                    Button {
                        Task {
                            await launchListViewModel.select(launch: launch)
                        }
                    } label: {
                        LaunchCellView(launch: launch)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    
                }
                .listStyle(.plain)
                */
                
                
                ScrollView {
                    LazyVStack {
                        ForEach(launchListViewModel.launches) { launch in
                            
                            Button {
                                Task {
                                    await launchListViewModel.select(launch: launch)
                                }
                            } label: {
                                LaunchCellView(launch: launch)
                            }
                            
                            
                        }
                    }
                    .padding(.vertical, 16.0)
                }
                
            }
            .background(Color.midnight)
            
            if launchListViewModel.isFetchingLaunches ||
                launchListViewModel.isFetchingLaunchDetails {
                LoadingView()
            }
        }
    }
}

struct LaunchListView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchListView(launchListViewModel: LaunchListViewModel.mock())
    }
}
