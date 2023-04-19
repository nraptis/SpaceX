//
//  LaunchpadCellView.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/13/23.
//

import SwiftUI

struct LaunchpadCellView: View {
    let launchpad: Launchpad
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text("Launchpad")
                            .font(.system(size: 22.0).bold())
                            .foregroundColor(.obsidian)
                        
                        Spacer()
                    }
                    HStack {
                        Text(launchpad.name)
                            .font(.system(size: 18.0))
                            .foregroundColor(.midnight)
                        Spacer()
                    }
                }
                .padding(.leading, 8.0)
                
                ZStack {
                    Image(systemName: "info.circle.fill")
                        .font(.system(size: 24.0))
                        .padding(.all, 8.0)
                        .foregroundColor(.midnight)
                }
            }
            .padding(.all, 6.0)
            
        }
        .background(RoundedRectangle(cornerRadius: 12.0).foregroundColor(.magenta))
        .padding(.horizontal, 16.0)
    }
}

struct LaunchpadCellView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchpadCellView(launchpad: Launchpad.mock())
    }
}
