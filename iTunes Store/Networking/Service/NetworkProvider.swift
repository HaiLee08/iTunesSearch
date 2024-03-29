//
//  Provider.swift
//  itunessearch
//
//  Created by Yuşa Doğru on 10/14/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import Foundation

typealias NetworkProviderCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> ()
typealias ClosureType<T> = (_ result: T) -> ()
typealias Failure = ((_ error: String) -> ())

protocol NetworkRouter {
    associatedtype EndPoint: EndPointType
    func request(_ target: EndPoint, completion: @escaping NetworkProviderCompletion)
    func cancel()
}

class NetworkProvider<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ target: EndPoint, completion: @escaping NetworkProviderCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: target)
            print("Request URL: \(request.url?.absoluteString ?? "")")
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        }catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from target: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: target.baseURL.appendingPathComponent(target.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 20.0)
        
        request.httpMethod = target.httpMethod.rawValue
        do {
            switch target.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyEncoding,
                                    let urlParameters):
                try self.configureParameters(bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
}


extension NetworkProvider {
    
    func request<T: Decodable>(_ target: EndPoint,
                               model: T.Type,
                               path: String? = nil,
                               completion: @escaping ClosureType<T>,
                               failure: @escaping Failure){
        
        return request(target, completion: { data,response,error in
            DispatchQueue.main.async {
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            failure(NetworkResponse.noData.rawValue)
                            return
                        }
                        do {
                            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                            print(jsonData)
                            let apiResponse = try JSONDecoder().decode(model.self, from: responseData)
                            completion(apiResponse)
                        }catch {
                            print(error.localizedDescription)
                            failure(NetworkResponse.unableToDecode.rawValue)
                        }
                    case .failure(let networkFailureError):
                        failure(networkFailureError)
                    }
                } else {
                    failure(NetworkResponse.noData.rawValue)
                }
            }
        })
    }

    private enum Result<String>{
        case success
        case failure(String)
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
}
