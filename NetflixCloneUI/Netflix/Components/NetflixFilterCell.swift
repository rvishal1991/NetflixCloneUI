//
//  NetflixFilterCell.swift
//  NetflixCloneUI
//
//  Created by apple on 10/05/25.
//

import SwiftUI

struct NetflixFilterCell: View {
    
    var title: String = "Category"
    var isDropDown: Bool = true
    var isSelected: Bool = false
    
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
            if isDropDown {
                Image(systemName: "chevron.down")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            ZStack{
                Capsule(style: .circular)
                    .fill(.netflixDarkGrey)
                    .opacity(isSelected ? 1 : 0)
                        
                Capsule(style: .circular)
                    .stroke(lineWidth: 1.0)
            }
        )
        .cornerRadius(16)
        .foregroundStyle(.netflixLightGrey)
    }
}

#Preview {
    
    ZStack {
        
        Color.black.ignoresSafeArea()
        VStack {
            NetflixFilterCell()
            NetflixFilterCell(isSelected: true)
            NetflixFilterCell(isDropDown: false)

        }
    }
}
