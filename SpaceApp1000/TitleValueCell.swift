//
//  TitleValueCell.swift
//  SpaceApp1000
//
//  Created by Tiger Nixon on 4/13/23.
//

import SwiftUI

struct TitleValueCell: View {
    let title: String
    let value: String
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("\(title):")
                        .font(.system(size: 18.0))
                        .foregroundColor(.ghost)
                    
                    Spacer()
                }
                HStack {
                    Text(value)
                        .font(.system(size: 18.0).bold())
                        .foregroundColor(.silver)
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 12.0)
            .padding(.vertical, 8.0)
        }
        .background(RoundedRectangle(cornerRadius: 12.0).foregroundColor(.mauve))
        .padding(.horizontal, 8.0)
        .padding(.vertical, 2.0)
    }
}

struct TitleValueCell_Previews: PreviewProvider {
    static var previews: some View {
        TitleValueCell(title: "Weight", value: "220 kg")
    }
}
