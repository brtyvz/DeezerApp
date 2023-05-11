//
//  ArtistModel.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 11.05.2023.
//

import Foundation
class ArtistModel: Codable {
    var artistId: Int
    var artistName: String
    var artistImageUrl: String
    
    private enum CodingKeys: String, CodingKey {
         case artistId = "id"
         case artistName = "name"
         case artistImageUrl = "picture"
     }
}

struct ArtistResponse: Codable {
    let data: [ArtistModel]
}
