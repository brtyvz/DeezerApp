//
//  GenreCellView.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 10.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct GenreCellView: View {
    let genre:MusicGenreModel
    var viewModel = MusicCategoryViewModel()
    var body: some View {
        ZStack{
            
            VStack(alignment:.leading){
                
                HStack{
                    
                    Text("\(genre.genreName)")
                        .font(.title2).bold()
                        .padding(.horizontal,16)
                        .padding(.vertical,8)
                        .foregroundColor(.black)
                        .background(Color.white.opacity(0.7)).cornerRadius(10)
                        .frame(width: 180, height:180)
                }
                
            }
            
        }.background( AnimatedImage(url: URL(string: genre.genreImageUrl)).resizable().frame(width: 180, height: 180).cornerRadius(10).opacity(0.9))
        
            .cornerRadius(10)
        
    }
}


