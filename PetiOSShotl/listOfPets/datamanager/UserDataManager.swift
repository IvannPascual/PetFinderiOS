//
//  UserDataManager.swift
//  PetiOSShotl
//
//  Created by IVAN on 22/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
class UserDataManager {
    
    static let shared = UserDataManager()
    var token = ""
    var listOfOrganitzations = OrganizationsVM()
    
    private init() { }
    
    func saveToken(token: String ) {
        self.token = token
        
    }
    
    func saveOrganitzationsViewModel(_ organitzations: Organizations) {
        self.listOfOrganitzations = OrganizationsVM()
        guard let organitzations = organitzations.organizations else {
            return
        }
        for organitzation in organitzations{
            let organitzationViewModel = OrganitzationViewModel()
            let addresVM = AddressVM()
            
            organitzationViewModel.name = organitzation.name
            organitzationViewModel.distance = organitzation.distance
            
            addresVM.address1 = organitzation.address?.address1 ?? ""
            addresVM.address2 = organitzation.address?.address1 ?? ""
            addresVM.city = organitzation.address?.city ?? ""
            addresVM.postcode = organitzation.address?.postcode ?? ""

            organitzationViewModel.address = addresVM
            listOfOrganitzations.organitzations.append(organitzationViewModel)
        }
    }
    
    func retrieveOrgranitzations()-> OrganizationsVM {
        return self.listOfOrganitzations
    }
    
    func provideStoredToken()->String {
        return self.token
    }
    
}
