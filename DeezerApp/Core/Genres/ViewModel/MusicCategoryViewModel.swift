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
    
   
    
    
    private let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)

    func fetchGenre(){
        let url = DeezerAPI.genre.url
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request) { data, response, error in
            let result = self.processPhotoRequest(data: data, error: error)
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
    
    
    
    private func processPhotoRequest(data:Data?,error:Error?) ->
    Result<[MusicGenreModel],Error> {
        guard let jsonData = data else {
            return .failure(error!)
            
        }
        let result = DownloaderClient.genres(fromJSON: jsonData)
        return result
    }
    
    
//    func fetchGenres() {
//        client.downloadGenre() { result in
//            switch result {
//            case let .success( genre):
//                
//                OperationQueue.main.addOperation {
//                    self.genres = genre!
//                }
//                   
//                
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }

}
