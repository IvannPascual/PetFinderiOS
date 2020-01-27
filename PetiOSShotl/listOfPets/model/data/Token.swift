//
//  Token.swift
//  PetiOSShotl
//
//  Created by IVAN on 21/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
import ObjectMapper

struct Token: Mappable {
    
    var token_type = 0
    var expires_in = ""
    var access_token = ""
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        token_type       <- map["token_type"]
        expires_in     <- map["expires_in"]
        access_token     <- map["access_token"]
    }
}
