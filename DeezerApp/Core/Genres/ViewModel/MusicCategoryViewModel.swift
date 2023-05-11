//
//  MusicCategoryViewModel.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 9.05.2023.
//

import Foundation

class MusicCategoryViewModel:ObservableObject {
    
    @Published var genres : [MusicGenreModel] = []
    @Published var error : Error?
    @Published var artists : [ArtistModel] = []
    
    private let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)

    
    func fetchGenre(){
        let url = DeezerAPI.genre.url
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request) { data, response, error in
            let result = self.processGenreRequest(data: data, error: error)
            switch result {
            case let .success(genres):
                OperationQueue.main.addOperation {
                    self.genres = genres

                }
            case let .failure(error):
                self.error = error
            }
        }
        task.resume()
    }
    
    
    private func processGenreRequest(data:Data?,error:Error?) ->
    Result<[MusicGenreModel],Error> {
        guard let jsonData = data else {
            return .failure(error!)
            
        }
        let result = DownloaderClient.genres(fromJSON: jsonData)
        return result
    }
    
    
//    func fetchArtists(id:Int){
//        let url = DeezerAPI.artist(id: id).url!
//        let request = URLRequest(url: url)
//        let task = session.dataTask(with: request) { data, response, error in
//            let result = self.processArtistRequest(artistID: id, data: data, error: error)
//            switch result {
//            case let .success(artist):
//                OperationQueue.main.addOperation {
//                    
//
//                }
//            case let .failure(error):
//                self.error = error
//            }
//        }
//        task.resume()
//    }
    
    private func processArtistRequest(artistID:Int,data:Data?,error:Error?) ->
    Result<[ArtistModel],Error> {
        guard let jsonData = data else {
            return .failure(error!)
            
        }
        let result = DownloaderClient.artists(artistID:artistID,fromJSON: jsonData)
        return result
    }
    
    func fetchArtistList(id:Int){
        let url = URL(string: "https://api.deezer.com/genre/\(id)/artists")!
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            let result = self.processArtistRequest(artistID: id, data: data, error: error)
            switch result {
            case let .success(artist):
                OperationQueue.main.addOperation {
                    self.artists = artist

                }
            case let .failure(error):
                self.error = error
            }
        }
        task.resume()
    }
    
    
}
