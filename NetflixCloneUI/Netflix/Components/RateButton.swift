//
//  RateButton.swift
//  NetflixCloneUI
//
//  Created by apple on 13/05/25.
//

import SwiftUI
import SwiftfulUI

enum RateOption:String, CaseIterable{
 case dislike, like, love
    
    var title:String{
        switch self {
        case .dislike:
            return "Not for me"
        case .like:
            return "I like this"
        case .love:
            return "Love this!"
        }
    }
    
    var iconName:String{
        switch self {
        case .dislike:
            return "hand.thumbsdown"
        case .like:
            return "hand.thumbsup"
        case .love:
            return "bolt.heart"
        }
    }
}

struct RateButton: View {
    
    @State private var showPopover:Bool = false
    var onRatingSelected:((RateOption)->Void)? = nil
    
    var body: some View {
        VStack(spacing: 8){
            ZStack {
                Image(systemName: "hand.thumbsup")
                    .font(.title)
            }
            .font(.title)
            
            Text("Rate")
                .font(.caption)
                .foregroundStyle(.netflixLightGrey)
                
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(Color.black.opacity(0.001))
        .onTapGesture {
            showPopover.toggle()
        }
        .popover(isPresented: $showPopover) {
           
            ZStack{
                Color.netflixDarkGrey.ignoresSafeArea()
                HStack(spacing: 12) {
                    ForEach(RateOption.allCases, id: \.self){ option in
                        rateButton(option: option)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            .presentationCompactAdaptation(.popover)
        }
    }
    
    
    private func rateButton(option:RateOption) -> some View {
        VStack {
            Image(systemName: option.iconName)
                .font(.title2)
            Text(option.title)
                .font(.caption)
        }
        .foregroundStyle(.netflixWhite)
        .padding(4)
        .background(Color.black.opacity(0.001))
        .onTapGesture {
            showPopover = false
            onRatingSelected?(option)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        RateButton()
    }
}
