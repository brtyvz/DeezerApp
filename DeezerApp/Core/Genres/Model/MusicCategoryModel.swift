//
//  MusicCategoryModel.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 9.05.2023.
//

import Foundation


class MusicGenreModel: Codable {
    var genreId: Int
    var genreName: String
    var genreImageUrl: String
    
    private enum CodingKeys: String, CodingKey {
         case genreId = "id"
         case genreName = "name"
         case genreImageUrl = "picture"
     }
}

struct GenreResponse: Codable {
    let data: [MusicGenreModel]
    private enum CodingKeys: String, CodingKey {
            case data = "data"
        }
}
