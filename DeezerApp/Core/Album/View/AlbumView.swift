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
    @State private var player: AVPlayer?
    @ObservedObject var vm = MusicCategoryViewModel()
    
    var body: some View {
        ScrollView {
            VStack{
                
                Text(album.albumName)
                
                ForEach(vm.musics,id:\.musicId) { music in
                    Text(music.musicName)
                    
                    Button(action: {
                        playPreview(url: music.preview)
                                   }) {
                                       Text("Play preview")
                                   }
                    
                    AnimatedImage(url:URL(string: album.albumImage)).resizable().frame(width: 50, height: 50, alignment: .center)
                   
                    
                }
            } .onAppear{
                vm.fetchMusicInfo(id: album.albumId)
                
        }
        }
       
            
    }
    func playPreview(url: String) {
          guard let previewUrl = URL(string: url) else { return }
          let playerItem = AVPlayerItem(url: previewUrl)
          player = AVPlayer(playerItem: playerItem)
          player?.play()
      }
}


