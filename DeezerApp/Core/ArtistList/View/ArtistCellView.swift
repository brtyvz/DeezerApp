//
//  ArtistCellView.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 11.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ArtistCellView: View {
    let artist:ArtistModel
    var viewModel = MusicCategoryViewModel()
    var body: some View {
        ZStack{
            
            VStack(alignment:.leading){
                
                HStack{
                    
                    Text("\(artist.artistName)")
                        .font(.title2).bold()
                        .padding(.horizontal,16)
                        .padding(.vertical,8)
                        .foregroundColor(.black)
                        .background(Color.white.opacity(0.7)).cornerRadius(10)
                        .frame(width: 180, height:180)
                }
                
            }
            
        }.background(AnimatedImage(url: URL(string: artist.artistImageUrl)).resizable().frame(width: 180, height: 180).cornerRadius(10).opacity(0.9))
        
            .cornerRadius(10)
        
    }
}


