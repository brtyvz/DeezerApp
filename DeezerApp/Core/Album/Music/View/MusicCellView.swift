//
//  MusicCellView.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 13.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import AVKit


struct MusicCellView: View {
    let music:MusicModel
    @State private var player: AVPlayer?
    @State private var isPlaying = false

    let album:AlbumModel
    
    @State private var isHeartSelected = false

    var body: some View {
        
        Button {
            playPreview(url: music.preview)
        } label: {
            HStack(){
                AnimatedImage(url:URL(string: album.albumImage)).resizable().frame(width: 100, height: 100, alignment: .center)
                
                VStack(alignment:.leading){
                    Text(music.musicName)
                    Text("\(secondsToMinutes(seconds:music.duration))")
                }
                Spacer()
                ZStack {
                    Button {
                        isHeartSelected.toggle()
                    } label: {
                        Image(systemName: isHeartSelected ? "heart.fill" : "heart").font(.title)
                            
                    }.padding(.trailing,15)
                }
                 
            
            }.foregroundColor(Color.white)
                .padding(.leading,0)
                .frame(width: 400, height: 100, alignment: .leading)
                .background(Color.black.opacity(0.5))
                    .cornerRadius(10)
        }
        
    }

    
    func playPreview(url: String) {
        
        guard let previewUrl = URL(string: url) else { return }
        let playerItem = AVPlayerItem(url: previewUrl)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }

    
    func secondsToMinutes(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }

}


