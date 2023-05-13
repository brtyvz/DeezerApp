//
//  AlbumView.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 11.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import AVKit

struct AlbumView: View {
    let album:AlbumModel
    
    @ObservedObject var vm = MusicCategoryViewModel()
    
    var body: some View {
        ScrollView {
            VStack{
                
                Text(album.albumName).font(.title).bold()
                
                ForEach(vm.musics,id:\.musicId) { music in
                 
                   MusicCellView(music: music,album: album)
                }
            } .onAppear{
                vm.fetchMusicInfo(id: album.albumId)
                
        }
        }
       
            
    }
   
}


