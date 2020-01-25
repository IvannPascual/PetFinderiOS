//
//  PetModel.swift
//  PetiOSShotl
//
//  Created by IVAN on 21/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
import ObjectMapper

struct Photo: Mappable {
    var smallUrl = ""
    var mediumUrl = ""
    var largeUrl = ""
   
    init?(map: Map) {
    
    }
         
    mutating func mapping(map: Map) {
        smallUrl <- map["small"]
        mediumUrl <- map["medium"]
        largeUrl <- map["large"]
    }
    
}

struct Animal: Mappable {
    var id = 0
    var organization_id = ""
    var url = ""
    var type = ""
    var species = ""
    var photos : [Photo]?

    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        organization_id <- map["organization_id"]
        url <- map["url"]
        type <- map["type"]
        species <- map["species"]
        species <- map["species"]
        photos <- map["photos"]
    }
}

class PetModelResponse: Mappable {
    var animals: [Animal]?

    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        animals <- map["animals"]
    }
}



