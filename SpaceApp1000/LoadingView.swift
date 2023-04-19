//
//  LoadingView.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/13/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                ZStack {
                    
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(Color.silver)
                        .scaleEffect(1.4)
                    
                }
                .frame(width: 80.0, height: 90.0)
                .background(RoundedRectangle(cornerRadius: 16.0).foregroundColor(Color.mauve))
                Spacer()
            }
            Spacer()
        }
        .background(Color.obsidian.opacity(0.85))
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
