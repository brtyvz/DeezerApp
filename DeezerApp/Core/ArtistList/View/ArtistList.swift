//
//  ArtistList.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 11.05.2023.
//

import SwiftUI

struct ArtistList: View {
    @ObservedObject var vm = MusicCategoryViewModel()
    private let gridItem = [GridItem(.flexible()),GridItem(.flexible())]
    var id : Int
    
    var body: some View {
        
                ScrollView {
                    LazyVGrid(columns:gridItem ,spacing: 22 ){
                        ForEach(vm.artists,id:\.artistId) { artist in
                            
                            NavigationLink {
                                ArtistInfoView(artist: artist)
                              
                            } label: {
                                ArtistCellView(artist: artist, viewModel: vm)
                            }
                        }
                    }
                }.onAppear{
                    vm.fetchArtistList(id:id)
                   
                }
                .navigationTitle("Artists")
        }
            
        }

struct ArtistList_Previews: PreviewProvider {
    static var previews: some View {
        ArtistList(id: 147)
    }
}

//
//ForEach(vm.artists,id:\.artistId) { artist in
//    Text(artist.artistName)


//    .onAppear{
//        vm.fetchArtistList(id:id )
