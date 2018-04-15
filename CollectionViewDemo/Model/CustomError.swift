//
//  CustomError.swift
//  CollectionViewDemo
//
//  Created by Prashanthi Boravelly on 15/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import Foundation

enum CustomError: Error, CustomDebugStringConvertible {
    case encoding(error: Error) // error during encoding parameters.
    case offline
    case system(error: Error)
    case decoding(data: Data, error: Error) // error during decoding response to model object.
    case invalidUrl(urlString: String)
    case invalidStatusCode(code: Int, data: Data?) // invalid status code from server.
    case unknown
    
    // Description for debugging purpose.
    var debugDescription: String {
        switch self {
        case .offline:
            return "offline error"
        case .system(error: let error):
            return String(describing: error)
        case .decoding(data: let data, error: let error):
            return ["decoding error", String(describing: error), String(data: data, encoding: .utf8)]
                .compactMap { $0 }
                .joined(separator: " ")
        case .invalidUrl(urlString: let urlString):
            return "invalid url \(urlString)"
        case .encoding(error: let error):
            return "encoding error" + String(describing: error)
        case .invalidStatusCode(code: let statusCode, data: let data):
            return ["invalidstatuscode",  String(statusCode), data.flatMap { String(data: $0, encoding: .utf8) }].compactMap { $0 }.joined(separator: " ")
        case .unknown:
            return "unknown error"
        }
        
    }
    
    var userDescription: String {
        switch self {
        case .offline:
            return "your network connection appears to be offline."
        default:
            return "There are system issues. Please try after some time."
        }
    }
    
}
