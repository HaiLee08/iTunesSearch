//
//  URLParameterEncoding.swift
//  itunessearch
//
//  Created by Yuşa Doğru on 10/13/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            //TODO: Dışarı al
//            for (key,value) in parameters {
//                let queryItem = URLQueryItem(name: key,
//                                             value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
//                urlComponents.queryItems?.append(queryItem)
//            }
            urlComponents.queryItems = queryComponents(parameters: parameters)
            urlRequest.url = urlComponents.url
        } else {
            throw NetworkError.resolvingFailed
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }
    
    private func queryComponents(parameters: Parameters) -> [URLQueryItem] {
        var components = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.append(queryItem)
        }
        
        return components
    }
}
