//
//  PhotoService.swift
//  FlickrImageSearch
//


import Foundation
import UIKit

//1 using associatedType in protocol
protocol GetPhotos {
    associatedtype T
    func getPhotosList(page: String,searchStr: String,completion: @escaping (Result<T>) -> Void)
}

//2 conform to protocol
struct Photoservice: GetPhotos {
    
    
    
    let downloader = JSONDownloader()
    
    //the associated type is inferred by <[SearchResultPhotos?]>
    typealias CompletionHandler = (Result<[Photo?]>) -> ()
    
    //4 protocol required function
    func getPhotosList(page: String,searchStr: String,completion: @escaping CompletionHandler) {
        // Checking URL is Valid
        guard let url = URL(string: SEARCHPHOTOSAPI + page + "&text=" + searchStr) else {
            completion(.Error(.invalidURL))
            return
        }
        
        //https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&page=1&text=Lion
        
        
        //5 using the JSONDownloader function
        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Error(let error):
                    completion(.Error(error))
                    return
                case .Success(let json):
                    //6 parsing the Json response
                    guard let PhotosListArray = json["photos"]?.value(forKey: "photo") as? [[String: AnyObject]] else {
                        completion(.Error(.jsonParsingFailure))
                        return
                    }
                    //7 maping the array and create Photos objects
                    let PhotosArray = PhotosListArray.map{Photo(fromDictionary: ($0 as NSDictionary) as! [String : Any ])
                    }
                    completion(.Success(PhotosArray))
                }
            }
        }
        task.resume()
    }
}


