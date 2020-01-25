//
//  Endpoints.swift
//  PetiOSShotl
//
//  Created by IVAN on 21/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
struct API {
    static let baseUrl = "https://api.petfinder.com/v2"
}

struct APICalls {
    typealias responseToApiCallType = String
    static let getPets = "getPets"
    static let getOrganitzations = "getOrganitzations"
}

struct ErrorApiCalls {
    static let ErrorWhenCallEndpointPets = "Error when call to he endpoint animals"
    static let ErrorWhenCallEndpointToken = "Error when call to he endpoint token"
    static let ErrorWhenCallEndpointOrganitzations = "Error when call to the endpoint organitzations"
    static let DefaultError = "An error ocurred"
}



protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Pets: Endpoint {
        case pets
        case token
        case organitzations
        
        public var path: String {
            switch self {
                case .pets: return "/animals"
                case .token: return "/oauth2/token"
                case .organitzations: return "/organizations"
            }
        }
    
        public var url: String {
            switch self {
            case .pets: return "\(API.baseUrl)\(path)"
            case .token: return "\(API.baseUrl)\(path)"
            case .organitzations: return "\(API.baseUrl)\(path)"

            }
        }
    }
}
