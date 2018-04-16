//
//  NetworkManager.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

protocol NetworkManager { }

extension NetworkManager {
    static func responseData(urlString: String,
                             completion: @escaping (Result<Data, CustomError>) -> Void) {
        if let baseUrl = URL(string: urlString) {
            let request = URLRequest(url: baseUrl)
            
            // Sending request to fetch data.
            URLSession.shared.dataTask(with: request) {(data, response, error) in
                
                // Checking for errors.
                if let error = error {
                    if (error as NSError).domain == NSURLErrorDomain,
                        (error as NSError).code == NSURLErrorNotConnectedToInternet
                    {
                        completion(.failure(.offline))
                    } else {
                        completion(.failure(.system(error: error)))
                    }
                } else if (response as? HTTPURLResponse)?.statusCode != 200 {
                    completion(.failure(.invalidStatusCode(code: (response as! HTTPURLResponse).statusCode, data: data)))
                } else if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(.unknown))
                }
                }.resume()
        } else {
            completion(.failure(.invalidUrl(urlString: urlString)))
        }
    }
    
    static func responseObject<T: Decodable>(urlString: String,
                                             completion: @escaping (Result<T, CustomError>) -> Void) {
        
        // T is any type which can be decodable to convert the response from backend.
        responseData(urlString: urlString,
                     completion: { result in
                        switch result {
                        case .success(let data):
                            
                            // decoding response data.
                            let jsonDecoder = JSONDecoder()
                            do {
                                if let string = String(data: data, encoding: .ascii),
                                    let data = string.data(using: .utf8) {
                                    let response = try jsonDecoder.decode(T.self, from: data)
                                    completion(.success(response))
                                } else {
                                    completion(.failure(.unknown))
                                }
                            } catch let error as DecodingError {
                                completion(.failure(.decoding(data: data, error: error)))
                            } catch {
                                completion(.failure(.system(error: error)))
                            }
                        case .failure(let error):
                            completion(.failure(error))
                        }
        })
    }
}
