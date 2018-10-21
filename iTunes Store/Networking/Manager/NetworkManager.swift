//
//  NetworkManager.swift
//  itunessearch
//
//  Created by Yuşa Doğru on 10/13/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import Foundation


struct NetworkManager {
    static let shared = NetworkManager()

    let provider = NetworkProvider<iTunesEndPoint>()
    
    func search(text: String, media: MediaType = .all, limit: Int = 100, completion: @escaping ClosureType<SearchGroup>, failure: @escaping Failure) {
        provider.request(.search(term: text, media: media, limit: limit), model: SearchGroup.self, completion: completion, failure: failure)
    }
    
    
}

