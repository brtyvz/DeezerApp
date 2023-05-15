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
    @ObservedObject var vm = AppViewModel()
    
    @Environment(\.managedObjectContext) private var viewContext
    

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
     var items: FetchedResults<Item>
    

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
                    ForEach(items) { item in
                        if item.musicID == music.musicId{
                            Button {
                            deleteItem(item)
                                isHeartSelected.toggle()
                                self.isLiked = true
                                
                            } label: {
                                Image(systemName: isHeartSelected ? "heart" : "heart.fill").font(.title).foregroundColor(Color.green)
                                    
                            }.padding(.trailing,15)
                        }
                        
                        else {
                           heartButtonView()
                        }
                      
                    }
                    
                   heartButtonView()
                  
                }
                 
            
            }.foregroundColor(Color.white)
                .padding(.leading,0)
                .frame(width: 400, height: 100, alignment: .leading)
                .background(Color.black.opacity(0.9))
                    .cornerRadius(10)
        }
        
    }
    
    private func deleteItem(_ item: Item) {
            withAnimation {
                viewContext.delete(item)

                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
    }
    
    func saveData(isLiked:Bool,duration:Int,songName:String,songImage:String,preview:String,musicID:Int){

            let entity = Item(context: viewContext)
            entity.timestamp = Date()
            entity.duration = Int16(music.duration)
            entity.preview = music.preview
            entity.songName = music.musicName
            entity.songImage = album.albumImage
            entity.isLiked = isLiked
            entity.musicID = Int32(music.musicId)

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


extension MusicCellView{
    func heartButtonView() -> some View{
        Button {
            isHeartSelected.toggle()
            self.isLiked = true
            saveData(isLiked: self.isLiked, duration: music.duration, songName: music.musicName, songImage: album.albumImage,preview: music.preview,musicID: music.musicId)
            
        } label: {
            Image(systemName: isHeartSelected ? "heart.fill" : "heart").font(.title).foregroundColor(Color.green)
                
        }.padding(.trailing,15)
    }
}
