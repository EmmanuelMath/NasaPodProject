//
//  ContentView.swift
//  NasaPodProject
//
//  Created by Emmanuel Mathar on 14/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TodayPictureView()
                .tabItem {
                    Label("Today", systemImage: "moon.stars")
                }
            
            RecentPicturesView()
                .tabItem {
                    Label("Feed", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    ContentView()
}

