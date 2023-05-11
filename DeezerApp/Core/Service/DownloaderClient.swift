//
//  DownloaderClient.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 10.05.2023.
//

import Foundation

public class DownloaderClient  {

    static func genres(fromJSON data:Data) -> Result<[MusicGenreModel],Error> {
        do {
            let decoder = JSONDecoder()
            let genreResponse = try decoder.decode(GenreResponse.self, from: data)
            return .success(genreResponse.data)
        } catch  {
            return.failure(error)
        }
    }
    
    static func artists (artistID:Int,fromJSON data:Data)  -> Result<[ArtistModel],Error> {
        do {
            let decoder = JSONDecoder()
            let artistResponse = try decoder.decode(ArtistResponse.self, from: data)
            return .success(artistResponse.data)
        } catch  {
            return.failure(error)
        }
    }
    
    static func artistList (genreID:Int,fromJSON data:Data)  -> Result<[ArtistModel],Error> {
        do {
            let decoder = JSONDecoder()
            let artistResponse = try decoder.decode(ArtistResponse.self, from: data)
            return .success(artistResponse.data)
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
