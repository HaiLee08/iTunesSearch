//
//  HTTPTask.swift
//  itunessearch
//
//  Created by Yuşa Doğru on 10/13/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import Foundation

public enum HTTPTask {
    case request
    case requestParameters(bodyEncoding: ParameterEncoding, urlParameters: Parameters?)

}
