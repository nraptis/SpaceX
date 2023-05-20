//
//  LaunchCell.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/13/23.
//

import SwiftUI

struct LaunchCellView: View {
    let launch: Launch
    var body: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text(launch.name)
                            .font(.system(size: 22.0).bold())
                            .foregroundColor(.ghost)
                        Spacer()
                    }
                    HStack {
                        Text(Date.fromSpaceXString(string: launch.dateUtc)?.toYYYYMMDD() ?? "")
                            .font(.system(size: 18.0))
                            .foregroundColor(.silver)
                        Spacer()
                    }
                }
                .padding(.leading, 8.0)
                ZStack {
                    Image(systemName: "info.circle.fill")
                        .font(.system(size: 24.0))
                        .padding(.all, 8.0)
                        .foregroundColor(.silver)
                }
            }
            .padding(.all, 6.0)
            
        }
        .background(RoundedRectangle(cornerRadius: 12.0).foregroundColor(.mauve))
        .padding(.horizontal, 16.0)
    }
}

struct LaunchCellView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchCellView(launch: Launch.mock())
    }
}
