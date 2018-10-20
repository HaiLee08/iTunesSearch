//
//  iTunesEndPoint.swift
//  itunessearch
//
//  Created by Yuşa Doğru on 10/13/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

/// example: itunes.apple.com/search?term=...&media=....

enum MediaType: String {
    case movie
    case podcast
    case music
    case all
}

private let APIURL = "https://itunes.apple.com"

enum iTunesEndPoint {
    case search(term: String, media: MediaType)
}

extension iTunesEndPoint: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: APIURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .search: return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .search(let term, let media):
            return .requestParameters(bodyEncoding: .urlEncoding, urlParameters: ["term": term,
                                                                                  "media": media])
        }
    }
    
}

