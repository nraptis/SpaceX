//
//  LaunchDetailsView.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/13/23.
//

import SwiftUI

struct LaunchDetailsView: View {
    @ObservedObject var launchDetailsViewModel: LaunchDetailsViewModel
    var body: some View {
        ZStack {
            VStack(spacing: 0.0) {
                TitleBarView(title: launch.name) {
                    launchDetailsViewModel.back()
                }
                ScrollView {
                    VStack {
                        
                        launchStatsView()
                        
                        if let rocket =
                            launchDetailsViewModel.rocket {
                            Button {
                                Task {
                                    await launchDetailsViewModel.select(rocket: rocket)
                                }
                            } label: {
                                RocketCellView(rocket: rocket)
                            }
                        }
                        
                        if let launchpad =
                            launchDetailsViewModel.launchpad {
                            Button {
                                Task {
                                    await launchDetailsViewModel.select(launchpad: launchpad)
                                }
                            } label: {
                                LaunchpadCellView(launchpad: launchpad)
                            }
                        }
                    }
                    .padding(.vertical, 16.0)
                }
            }
            if launchDetailsViewModel.isLoadingLaunchpadDetails {
                LoadingView()
            }
        }
        .background(Color.midnight)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var launch: Launch { launchDetailsViewModel.launch }
    
    func launchStatsView() -> some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("Launch Information")
                            .font(.system(size: 22.0).bold())
                            .foregroundColor(.ghost)
                        
                        Spacer()
                    }
                }
                .padding(.leading, 8.0)
                .padding(.top, 8.0)
                
                if let date = Date.fromSpaceXString(string: launch.dateUtc) {
                    TitleValueCell(title: "Date",
                                   value: date.toYYYYMMDD())
                }
                
                if let flightNumber = launch.flightNumber {
                    TitleValueCell(title: "Flight Number", value: "\(flightNumber)")
                }
                
                if let success = launch.success {
                    TitleValueCell(title: "Success",
                                   value: "\(success)")
                }
                
                if let details = launch.details {
                    TitleValueCell(title: "Details",
                                   value: details)
                }
                
                Spacer()
                    .frame(height: 8.0)
            }
            .padding(.all, 6.0)
        }
        .background(RoundedRectangle(cornerRadius: 12.0).stroke().foregroundColor(.silver))
        .padding(.horizontal, 16.0)
    }
}

struct LaunchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchDetailsView(launchDetailsViewModel: LaunchDetailsViewModel.mock())
    }
}
