//
//  LaunchpadDetailsView.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/13/23.
//

import SwiftUI

struct LaunchpadDetailsView: View {
    @ObservedObject var launchpadDetailsViewModel: LaunchpadDetailsViewModel
    var body: some View {
        VStack(spacing: 0.0) {
            TitleBarView(title: launchpad.name) {
                launchpadDetailsViewModel.back()
            }
            ScrollView {
                VStack {
                    
                    launchStatsView()
                    
                    ForEach(launchpadDetailsViewModel.rockets) { rocket in
                        
                        Button {
                            Task {
                                await launchpadDetailsViewModel.select(rocket: rocket)
                            }
                        } label: {
                            RocketCellView(rocket: rocket)
                        }
                    }
                    
                    ForEach(launchpadDetailsViewModel.launches) { launch in
                        Button {
                            Task {
                                await launchpadDetailsViewModel.select(launch: launch)
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
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var launchpad: Launchpad { launchpadDetailsViewModel.launchpad }
    
    func launchStatsView() -> some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Text("Launchpad Information")
                            .font(.system(size: 22.0).bold())
                            .foregroundColor(.ghost)
                        
                        Spacer()
                    }
                }
                .padding(.leading, 8.0)
                .padding(.top, 8.0)
                
                if let fullName = launchpad.fullName {
                    TitleValueCell(title: "Full Name", value: fullName)
                }
                
                if let region = launchpad.region {
                    TitleValueCell(title: "Region", value: region)
                }
                
                if let launchAttempts = launchpad.launchAttempts {
                    TitleValueCell(title: "Launch Attempts", value: "\(launchAttempts)")
                }
                
                if let launchSuccesses = launchpad.launchSuccesses {
                    TitleValueCell(title: "Launch Successes", value: "\(launchSuccesses)")
                }
                
                if let details = launchpad.details {
                    TitleValueCell(title: "Details", value: "\(details)")
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

struct LaunchpadDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchpadDetailsView(launchpadDetailsViewModel: LaunchpadDetailsViewModel.mock())
    }
}
