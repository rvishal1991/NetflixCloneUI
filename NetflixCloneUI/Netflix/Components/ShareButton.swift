//
//  ShareButton.swift
//  NetflixCloneUI
//
//  Created by apple on 13/05/25.
//

import SwiftUI

struct ShareButton: View {
    
    var url:String = "https://www.netflix.com"
    
    @ViewBuilder
    var body: some View {
        if let url = URL(string: url){
            ShareLink(item:url) {
                VStack(spacing: 8){
                    ZStack {
                        Image(systemName: "paperplane")
                            .font(.title)
                    }
                    .font(.title)
                    
                    Text("Share")
                        .font(.caption)
                        .foregroundStyle(.netflixLightGrey)
                        
                }
                .foregroundStyle(.netflixWhite)
                .padding(8)
                .background(Color.black.opacity(0.001))
                
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ShareButton()

    }
}
