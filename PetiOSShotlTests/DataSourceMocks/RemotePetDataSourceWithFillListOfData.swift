//
//  RemotePetDataSourceWithFillListOfData.swift
//  PetiOSShotlTests
//
//  Created by IVAN on 25/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
@testable import PetiOSShotl

class  RemotePetDataSourceWithFillListOfData: PetListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: PetListRemoteDataManagerOutputProtocol?
    
    func retrievePetList() {
        let petModelDomain = PetModelDomain()
        var animal1 = AnimalDomainModel()
        
        animal1.id = 1
        animal1.organization_id = "I want a pet"
        
        petModelDomain.animals.append(animal1)
        
        remoteRequestHandler?.onPetsRetrieved(petModelDomain)
    }
    
    func retrieveOrganitzations() {
        let organitzationsDomainModel = OrganizationsDomainModel()
        let organitzationVM = OrganitzationViewModel()
        organitzationVM.address.address1 = "fake adress 1"
        organitzationsDomainModel.organitzations.append(organitzationVM)
        remoteRequestHandler?.onSuccessOrganizations(organitzationsDomainModel)
    }
    
}
