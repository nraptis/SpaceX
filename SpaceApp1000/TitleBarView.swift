//
//  TitleBarView.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/12/23.
//

import SwiftUI

struct TitleBarView: View {
    
    let title: String
    let backAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                if let backAction = backAction {
                    Button {
                        backAction()
                    } label: {
                        ZStack {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 30.0))
                                .foregroundColor(Color.ghost)
                        }
                        .frame(width: 44.0, height: 44.0)
                    }
                }
                
                HStack {
                    Text(title)
                        .font(.system(size: 24.0).bold())
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.ghost)
                    Spacer()
                }
                
            }
            .padding(.horizontal, 12.0)
            .padding(.vertical, 8.0)
            
            
            HStack {
                Spacer()
            }
            .frame(height: 1.0)
            .background(Color.silver)
        }
        .background(Color.obsidian)
    }
}

struct TitleBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TitleBarView(title: "Page 1 View Model") { }
            Spacer()
        }
        .background(Color.midnight)
    }
}
