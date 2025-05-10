//
//  NetflixMovieCell.swift
//  NetflixCloneUI
//
//  Created by apple on 10/05/25.
//

import SwiftUI

struct NetflixMovieCell: View {
    
    var width:CGFloat = 90
    var height:CGFloat = 140
    var imageName:String = Constants.randomImage
    var title:String? = "Movie Title"
    var isRecentlyAdded:Bool = true
    var topTenRanking:Int? = nil
    
    var body: some View {
        
        HStack(alignment: .bottom, spacing: -8){
            if let topTenRanking{
                Text("\(topTenRanking)")
                    .font(.system(size: 100, weight: .medium, design: .serif))
                    .offset(y: 20)
            }
            
            ZStack(alignment: .bottom) {
                ImageLoaderView(urlString: imageName)
                
                VStack(spacing: 0){
                    if let title, let firstWord = title.components(separatedBy: " ").first{
                        Text(firstWord)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                    }
                    
                    Text("Recently Added")
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .padding(.bottom, 2)
                        .background(.netflixRed)
                        .cornerRadius(2)
                        .offset(y:2)
                        .lineLimit(1)
                        .font(.caption)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal, 8)
                        .opacity(isRecentlyAdded ? 1 : 0)

                }
                .padding(.top, 6)
                .background(
                    LinearGradient(
                        colors: [
                            .netflixBlack.opacity(0),
                            .netflixBlack.opacity(0.3),
                            .netflixBlack.opacity(0.4),
                            .netflixBlack.opacity(0.4)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            .cornerRadius(4)
            .frame(width: width, height: height)
            .foregroundStyle(.netflixWhite)
            
        }
        .foregroundStyle(.netflixWhite)

    }
}

#Preview {
    
    ZStack {
        Color.black
        
        VStack {
            NetflixMovieCell()

            NetflixMovieCell(isRecentlyAdded: false, topTenRanking: 10)
            
            NetflixMovieCell(topTenRanking: 3)


        }
    }
    
   
}
