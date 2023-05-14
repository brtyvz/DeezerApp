//
//  MusicCategoryViewModel.swift
//  DeezerApp
//
//  Created by Berat Yavuz on 9.05.2023.
//

import Foundation
import CoreData

class MusicCategoryViewModel:ObservableObject {
    
    @Published var genres : [MusicGenreModel] = []
    @Published var error : Error?
    @Published var artists : [ArtistModel] = []
    @Published var albums : [AlbumModel] = []
    @Published var musics : [MusicModel] = []
    
    private let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    
    
//     func addItem() {
//
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//
//    }

    
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
    
    
    func fetchArtistsİnfo(id:Int){
        let url = URL(string: "https://api.deezer.com/artist/\(id)/albums")!
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            let result = self.processArtistInfoRequest(artistID: id, data: data, error: error)
            switch result {
            case let .success(albums):
                OperationQueue.main.addOperation {
                    self.albums = albums
                }
            case let .failure(error):
                OperationQueue.main.addOperation {
                    self.error = error
                    
                }
            }
           
        }
        task.resume()
    }
    
    private func processArtistRequest(genreID:Int,data:Data?,error:Error?) ->
    Result<[ArtistModel],Error> {
        guard let jsonData = data else {
            return .failure(error!)
            
        }
        let result = DownloaderClient.artistList(genreID:genreID,fromJSON: jsonData)
        return result
    }
    
    //Album
    private func processArtistInfoRequest(artistID:Int,data:Data?,error:Error?) ->
    Result<[AlbumModel],Error> {
        guard let jsonData = data else {
            return .failure(error!)
            
        }
        let result = DownloaderClient.albumInfo(artistID: artistID, fromJSON: jsonData)
        return result
    }
    
    
    
    func fetchArtistList(id:Int){
        let url = URL(string: "https://api.deezer.com/genre/\(id)/artists")!
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            let result = self.processArtistRequest(genreID: id, data: data, error: error)
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
    
    
    
    //MUsic
    func fetchMusicInfo(id:Int){
        let url = URL(string: "https://api.deezer.com/album/\(id)/tracks")!
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            let result = self.processMusicInfoRequest(albumID: id, data: data, error: error)
            switch result {
            case let .success(musics):
                OperationQueue.main.addOperation {
                    self.musics = musics

                }
            case let .failure(error):
                OperationQueue.main.addOperation {
                self.error = error
                }
            }
            
        }
        task.resume()
    }
    
    private func processMusicInfoRequest(albumID:Int,data:Data?,error:Error?) ->
    Result<[MusicModel],Error> {
        guard let jsonData = data else {
            return .failure(error!)
            
        }
        let result = DownloaderClient.musicInfo(albumID: albumID, fromJSON: jsonData)
        return result
    }
    
    
}
