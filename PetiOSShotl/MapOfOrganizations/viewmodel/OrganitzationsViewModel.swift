//
//  OrganitzationsViewModel.swift
//  PetiOSShotl
//
//  Created by IVAN on 22/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation

class OrganizationsDomainModel {
    var organitzations = [OrganitzationViewModel]()
}

class OrganitzationViewModel {
    var id = ""
    var name = ""
    var distance = 0
    var address: AddressVM = AddressVM()
}

class AddressVM {
    var address1 = ""
    var address2 = ""
    var city = ""
    var postcode = ""
}
