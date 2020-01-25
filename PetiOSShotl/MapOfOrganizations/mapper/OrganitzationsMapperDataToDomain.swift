//
//  OrganitzationsMapperDataToDomain.swift
//  PetiOSShotl
//
//  Created by IVAN on 25/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation

class OrganitzationsMapperDataToDomain {
    
    
    static func mapOrganitzationsDataModelToDomainModel(organitzations: Organizations)-> OrganizationsDomainModel? {
        let organitzationsDomainModel = OrganizationsDomainModel()
        guard let organitzations = organitzations.organizations else {
            return nil
        }
        
        for organitzation in organitzations {
            let organitzationViewModel = OrganitzationViewModel()
            let addresVM = AddressVM()
                      
            organitzationViewModel.name = organitzation.name
            organitzationViewModel.distance = organitzation.distance
                      
            addresVM.address1 = organitzation.address?.address1 ?? ""
            addresVM.address2 = organitzation.address?.address1 ?? ""
            addresVM.city = organitzation.address?.city ?? ""
            addresVM.postcode = organitzation.address?.postcode ?? ""

            organitzationViewModel.address = addresVM
            
            organitzationsDomainModel.organitzations.append(organitzationViewModel)
        }
        return organitzationsDomainModel
    }
}
