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

struct LikedSongCell: View {
    let item:Item
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    @State var isLiked = true
    @ObservedObject var vm = AppViewModel()
    
    @Environment(\.managedObjectContext) private var viewContext
 
    
    @State private var isHeartSelected = false

    var body: some View {
        
        Button {
            playPreview(url: item.preview ?? "")
        } label: {
            HStack(){
                AnimatedImage(url:URL(string: item.songImage ?? "")).resizable().frame(width: 100, height: 100, alignment: .center)
                
                VStack(alignment:.leading){
                    Text(item.songName ?? "")
                    Text("\(secondsToMinutes(seconds:item.duration))")
                }
                Spacer()
                ZStack {
                    Button {
                        isHeartSelected.toggle()
                        deleteItem(item)
                        
                        
                        
                    } label: {
                        Image(systemName: isHeartSelected ? "heart" : "heart.fill").font(.title).foregroundColor(Color.green)
                            
                    }.padding(.trailing,15)
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
    
    func saveData(isLiked:Bool){

            let entity = Item(context: viewContext)
            entity.timestamp = Date()
           
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

    
    func secondsToMinutes(seconds: Int16) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
  

}



