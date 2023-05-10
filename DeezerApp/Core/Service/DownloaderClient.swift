//
//  DownloaderClient.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 10.05.2023.
//

import Foundation

public class DownloaderClient  {
//    public func downloadGenre(
//        completion: @escaping (Result<[MusicGenreModel]?, DownloaderError>) -> Void) {
//
//        guard let url = DeezerAPI.genre.url else {
//                return completion(.failure(.wrongUrl))
//            }
//            print("URL: \(url)")
//            URLSession.shared.dataTask(with: url) { data, _, error in
//                guard let data = data, error == nil else {
//                    return  completion(.failure(.dataNotArrived))
//                }
//                guard let dataResponse =  try? JSONDecoder().decode(GenreArray.self, from: data) else {
//                    return completion(.failure(.dataNotProcessed))
//                }
//                completion(.success(dataResponse.genres))
//            }.resume()
//    }
    
    
    static func genres(fromJSON data:Data) -> Result<[MusicGenreModel],Error> {
        do {
            let decoder = JSONDecoder()
            let genreResponse = try decoder.decode(GenreResponse.self, from: data)
            return .success(genreResponse.data)
        } catch  {
            return.failure(error)
        }
       
    }
}


public enum DownloaderError: Error {
   case wrongUrl
   case dataNotArrived
   case dataNotProcessed
}
