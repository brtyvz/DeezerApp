//
//  MainTabView.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 13.05.2023.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        NavigationView{
            TabView(selection: $selectedIndex) {
                GenreView()
                    .onTapGesture {
                        self.selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "music.note")
                    }.tag(0)
                
                LikedSongsView()
                    .onTapGesture {
                        self.selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "heart.fill")
                    }.tag(1)
                
            }
        }
      
    }
}
