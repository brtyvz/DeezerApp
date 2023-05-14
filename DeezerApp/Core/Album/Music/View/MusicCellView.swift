//
//  MusicCellView.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 13.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI
import AVKit
import CoreData

struct MusicCellView: View {
    let music:MusicModel
    
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    @State var isLiked = false
    @ObservedObject var vm = MusicCategoryViewModel()
    
    @Environment(\.managedObjectContext) private var viewContext
    
    

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
                        self.isLiked = true
                        saveData(isLiked: self.isLiked, duration: music.duration, songName: music.musicName, songImage: album.albumImage,preview: music.preview)
                        
                    } label: {
                        Image(systemName: isHeartSelected ? "heart.fill" : "heart").font(.title).foregroundColor(Color.green)
                            
                    }.padding(.trailing,15)
                }
                 
            
            }.foregroundColor(Color.white)
                .padding(.leading,0)
                .frame(width: 400, height: 100, alignment: .leading)
                .background(Color.black.opacity(0.9))
                    .cornerRadius(10)
        }
        
    }
    
    func saveData(isLiked:Bool,duration:Int,songName:String,songImage:String,preview:String){

            let entity = Item(context: viewContext)
            entity.timestamp = Date()
            entity.duration = Int16(music.duration)
            entity.preview = music.preview
            entity.songName = music.musicName
            entity.songImage = album.albumImage
            entity.isLiked = isLiked

        do {
            try viewContext.save()
            print("save succesfully")
        } catch {
           
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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


