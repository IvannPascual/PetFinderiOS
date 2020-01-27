//
//  Organizations.swift
//  PetiOSShotl
//
//  Created by IVAN on 22/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
import ObjectMapper

 struct Organization: Mappable {
    var id = ""
    var name = ""
    var distance = 0
    var address: Address?

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        distance <- map["distance"]
        address <- map["address"]
    }
}

struct Address: Mappable {
    
    var address1 = ""
    var address2 = ""
    var city = ""
    var postcode = ""

    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        address1 <- map["address1"]
        address2 <- map["address2"]
        city <- map["city"]
        postcode <- map["postcode"]
    }
}


class Organizations: Mappable {
    
    var organizations: [Organization]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        organizations <- map["organizations"]
    }
}
