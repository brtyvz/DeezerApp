//
//  MusicModel.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 12.05.2023.
//

import Foundation

class MusicModel: Codable {
    var musicId: Int
    var musicName: String
    var musicImageUrl: String
    var preview:String

    
    private enum CodingKeys: String, CodingKey {
         case musicId = "id"
         case musicName = "title"
         case musicImageUrl = "md5_image"
         case preview = "preview"
     }
}

struct MusicResponse: Codable {
    let data: [MusicModel]
    private enum CodingKeys: String, CodingKey {
            case data = "data"
        }
}
