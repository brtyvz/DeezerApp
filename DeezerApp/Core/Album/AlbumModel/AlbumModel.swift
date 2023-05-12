//
//  AlbumModel.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 11.05.2023.
//


import Foundation
class AlbumModel: Codable {
   
    var release_date: String
    var albumId:Int
    var albumName:String
    var albumImage:String
    var trackList:String
    
    private enum CodingKeys: String, CodingKey {
        
      
         case release_date = "release_date"
         case albumId = "id"
         case albumName = "title"
         case albumImage = "cover_xl"
         case trackList = "tracklist"
     }
}

struct AlbumResponse: Codable {
    let data: [AlbumModel]
    private enum CodingKeys: String, CodingKey {
            case data = "data"
        }
}
