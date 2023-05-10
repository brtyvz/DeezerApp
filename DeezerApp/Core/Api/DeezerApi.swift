//
//  MusicCtaegoryService.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 9.05.2023.
//

import Foundation
import UIKit


enum DeezerAPI {
    case genre
    case artist(id: Int)
    case album(id: Int)
    
    
    var url: URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "api.deezer.com"
        component.path = path
        return component.url
    }
    
    private var path: String {
        switch self {
        case .genre:
            return "/genre"
        case .artist(let id):
            return "/artist/\(id)"
        case .album(let id):
            return "/album/\(id)"
        }
    }
}




//enum Endpoint: String {
//       case genre = "genre"
//       case artists = "genre/{genre_id}/artists"
//       case albums = "artist/{artist_id}/albums"
//}
//
//
//struct DeezerApi {
//
//
//
//    private static let baseUrlString = "https://api.deezer.com/"
//
//    static private func deezerUrl(
//        endpoint:Endpoint,
//        parameters: [String:String]?
//    ) -> URL {
//        var components = URLComponents(string: baseUrlString)!
//        var queryItems: [URLQueryItem] = []
//
//        let baseParams = [
//            "format": "json",
//            "nojsoncallback":"1",
//            "method":endpoint.rawValue
//        ]
//
//        for (key,value) in baseParams {
//            let item = URLQueryItem(name: key, value: value)
//            queryItems.append(item)
//        }
//
//        if let additionalParams = parameters {
//            for (key, value) in additionalParams {
//                let item = URLQueryItem(name: key, value: value)
//                queryItems.append(item)
//            }
//        }
//        components.queryItems = queryItems
//        return components.url!
//    }
//
//    static var deezerGenre:URL{
//        return deezerUrl(endpoint: .genre, parameters: nil)
//    }
//
//}
