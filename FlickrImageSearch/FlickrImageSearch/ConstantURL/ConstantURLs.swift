//
//  ConstantURLs.swift
//  FlickrImageSearch
//

import Foundation
import UIKit


enum Environment: String {
    case Development = "Development"
    case Production = "production"
    case LocalHost = "localhost"
}


let environment = Environment.Development

var APP_BASEURL: String {
    get {
        switch environment {
        case .Development:
            return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&"
        case .LocalHost:
            return "http://localhost:8080/"
        case .Production:
            return ""
        }
    }
}

let SEARCHPHOTOSAPI     = APP_BASEURL + "page="









