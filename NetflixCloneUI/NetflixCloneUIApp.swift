//
//  NetflixCloneUIApp.swift
//  NetflixCloneUI
//
//  Created by apple on 09/05/25.
//

import SwiftUI
import SwiftfulRouting

@main
struct NetflixCloneUIApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }

        }
    }
}
