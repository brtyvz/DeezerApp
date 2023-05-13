//
//  AlbumCellView.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 12.05.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct AlbumCellView: View {
    let album:AlbumModel
    var body: some View {
        
           
                HStack(){
                AnimatedImage(url: URL(string: album.albumImage)).resizable().frame(width: 100, height: 100).cornerRadius(10).opacity(0.9)
                    Text(album.albumName).bold()
                    Text(album.release_date).bold()
                    
                }.foregroundColor(Color.white)
                    .padding(.leading,0)
                    .frame(width: 400, height: 100, alignment: .leading)
                    .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
            }

        
    }



