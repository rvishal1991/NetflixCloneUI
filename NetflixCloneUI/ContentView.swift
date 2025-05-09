//
//  ContentView.swift
//  NetflixCloneUI
//
//  Created by apple on 09/05/25.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
    
    @Environment(\.router) var router

    var body: some View {
        List{
            Button("Open Netflix") {
                router.showScreen(.fullScreenCover) { _ in
                    //
                }
            }
        }
    }
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}
