//
//  DomainPetModel.swift
//  PetiOSShotl
//
//  Created by IVAN on 24/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation


struct PhotoDomainModel {
    var smallUrl = ""
    var mediumUrl = ""
    var largeUrl = ""
}

struct AnimalDomainModel {
    var id = 0
    var organization_id = ""
    var url = ""
    var type = ""
    var species = ""
    var photos = [PhotoDomainModel]()
}

class PetModelDomain {
    var animals = [AnimalDomainModel]()
}
