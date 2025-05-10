//
//  NetflixHeroCell.swift
//  NetflixCloneUI
//
//  Created by apple on 10/05/25.
//

import SwiftUI
import SwiftfulUI

struct NetflixHeroCell: View {
    
    var imageName:String = Constants.randomImage
    var isNetflixFilm:Bool = true
    var title:String = "Players"
    var categories:[String] = ["Thriller", "Horror", "Crime"]
    var onBackgroundPressed:(() -> Void)? = nil
    var onPlayPressed:(() -> Void)? = nil
    var onMyListPressed:(() -> Void)? = nil

    
    var body: some View {
        ZStack(alignment: .bottom) {
           
            ImageLoaderView(urlString: imageName)
               
            VStack(spacing: 16) {
                
                VStack(spacing:0) {
                    if isNetflixFilm {
                        HStack(alignment: .center, spacing: 8) {
                            Text("N")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .foregroundStyle(.netflixRed)

                            Text("FILM")
                                .kerning(3)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.netflixWhite)
                        }
                    }
                   
                    Text(title)
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.netflixWhite)
                }
                
                HStack {
                    ForEach(categories, id: \.self) { category in
                        Text(category)
                            .font(.callout)
                            .foregroundColor(.netflixWhite)
                       
                        if let last = categories.last, category != last {
                            Circle()
                                .fill(.netflixWhite)
                                .frame(width: 4, height: 4)
                        }
                    }
                }
                
                HStack(spacing: 16) {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Play")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundStyle(.netflixDarkGrey)
                    .background(.netflixWhite)
                    .font(.headline)
                    .cornerRadius(4)
                    .asButton(.press) {
                        onPlayPressed?()
                    }
                    
                    HStack {
                        Image(systemName: "plus")
                        Text("My List")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundStyle(.netflixWhite)
                    .background(.netflixDarkGrey)
                    .font(.headline)
                    .cornerRadius(4)
                    .asButton(.press) {
                        onMyListPressed?()
                    }
                }
                .font(.callout)
                .fontWeight(.medium)
               
            }
            .padding(24)
            .background(
                LinearGradient(
                    colors: [
                        .netflixBlack.opacity(0),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.5),
                        .netflixBlack.opacity(0.6)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .foregroundStyle(.netflixWhite)
        .cornerRadius(8)
        .aspectRatio(0.8, contentMode: .fit)
        .asButton(.press) {
            onBackgroundPressed?()
        }
       
    }
}

#Preview {
    NetflixHeroCell()
        .padding()
}
