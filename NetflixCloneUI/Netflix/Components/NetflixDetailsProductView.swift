//
//  NetflixDetailsProductView.swift
//  NetflixCloneUI
//
//  Created by apple on 13/05/25.
//

import SwiftUI
import SwiftfulUI

struct NetflixDetailsProductView: View {
    
    var title:String = "Movie Title"
    var isNew:Bool = true
    var yearReleased:String? = "2021"
    var seasons:Int? = 4
    var hasClosedCaption:Bool = true
    var isTopTen:Int? = 10
    var descriptionText:String? = "This is the description for the title. it is selcected here. It can be multiple lines. This is the description for the title. it is selcected here. It can be multiple lines."
    var castText:String? = "Cast: Nick, Vishal & more."
    
    var onPlayPressed:(() -> Void)? = nil
    var onDownloadPressed:(() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 4) {
                if isNew {
                    Text("New")
                        .foregroundColor(.green)
                }
                
                if let yearReleased{
                    Text(yearReleased)
                }
                
                if let seasons {
                    Text("\(seasons) Seasons")
                }
                
                if hasClosedCaption{
                    Image(systemName: "captions.bubble")
                }
            }
            .foregroundStyle(.netflixLightGrey)

            
            if let isTopTen {
                HStack(spacing: 8) {
                    topTenIcon
                    Text("#\(isTopTen) in TV Shows Today")
                        .font(.callout)
                        .fontWeight(.bold)
                }
            }
            
            VStack(spacing: 8) {
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
                    Image(systemName: "arrow.down.to.line.alt")
                    Text("Download")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundStyle(.netflixWhite)
                .background(.netflixDarkGrey)
                .font(.headline)
                .cornerRadius(4)
                .asButton(.press) {
                    onDownloadPressed?()
                }
            }
            
            
            Group {
                if let descriptionText{
                    Text(descriptionText)

                }
                
                if let castText{
                    Text(castText)
                        .foregroundStyle(.netflixLightGrey)
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)


        }
        .foregroundStyle(.netflixWhite)
    }
    
    private var topTenIcon: some View {
        Rectangle()
            .fill(Color.red)
            .cornerRadius(4)
            .frame(width: 30, height: 30)
            .overlay(
                VStack(spacing: -4) {
                    Text("TOP")
                        .fontWeight(.bold)
                        .font(.system(size: 8))
                    Text("10")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                }
             .offset(y:2)
            )
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack(spacing: 40) {
            NetflixDetailsProductView()
            NetflixDetailsProductView(
                isNew: false,
                yearReleased: nil,
                seasons: nil,
                hasClosedCaption: false,
                isTopTen: nil,
                descriptionText: nil,
                castText: nil,
                onPlayPressed: nil,
                onDownloadPressed: nil
            )
        }

    }
}
