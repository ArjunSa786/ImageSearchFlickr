//
//  SearchResultPhotos.swift
//  FlickrImageSearch
//

import Foundation
import UIKit


struct Photo{

    var farm : Int!
    var id : String!
    var isfamily : Int!
    var isfriend : Int!
    var ispublic : Int!
    var owner : String!
    var secret : String!
    var server : String!
    var title : String!
    var photo : [Photo]!
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        farm = dictionary["farm"] as? Int
        id = dictionary["id"] as? String
        isfamily = dictionary["isfamily"] as? Int
        isfriend = dictionary["isfriend"] as? Int
        ispublic = dictionary["ispublic"] as? Int
        owner = dictionary["owner"] as? String
        secret = dictionary["secret"] as? String
        server = dictionary["server"] as? String
        title = dictionary["title"] as? String
        photo = [Photo]()
        if let photoArray = dictionary["photo"] as? [[String:Any]]{
            for dic in photoArray{
                let value = Photo(fromDictionary: dic)
                photo.append(value)
            }
        }
    }
    
}
