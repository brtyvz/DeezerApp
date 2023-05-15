//
//  ArtistInfoView.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 11.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI
struct ArtistInfoView: View {
    
    var artist: ArtistModel
    
    @ObservedObject var vm = AppViewModel()
    
    
    var body: some View {
        ScrollView{
            Text(artist.artistName).font(.title).bold()
            AnimatedImage(url: URL(string: artist.artistImageUrl)).resizable().frame(width: 400, height: 400).cornerRadius(10).opacity(0.9)
            
            ForEach(vm.albums,id:\.albumId) { album in
                NavigationLink {
                    AlbumView(album: album)
                } label: {
                    AlbumCellView(album: album)
                }
            } 
            
            
        }.onAppear{
            vm.fetchArtistsİnfo(id: artist.artistId)
        }
        
        
    }
}


