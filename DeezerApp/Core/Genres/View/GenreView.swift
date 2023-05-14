//
//  GenreView.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 10.05.2023.
//

import SwiftUI

struct GenreView: View {
    
    @ObservedObject var vm = MusicCategoryViewModel()
    private let gridItem = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
       
            ScrollView {
                LazyVGrid(columns:gridItem ,spacing: 22 ){
                    ForEach(vm.genres,id:\.genreId) { genre in
                        
                        NavigationLink {
                            ArtistList(id: genre.genreId)
                          
                        } label: {
                            GenreCellView(genre: genre, viewModel: vm)
                        }
                    }
                }
            }.onAppear{
                vm.fetchGenre()
              
            }
            .navigationTitle("Deezer")
        
    }
}

struct GenreView_Previews: PreviewProvider {
    static var previews: some View {
        GenreView()
    }
}
