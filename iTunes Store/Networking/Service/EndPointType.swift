//
//  EndPointType.swift
//  itunessearch
//
//  Created by Yuşa Doğru on 10/13/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
}
