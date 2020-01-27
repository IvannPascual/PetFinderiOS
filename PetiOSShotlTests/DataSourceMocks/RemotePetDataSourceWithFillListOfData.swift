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
        var photo = PhotoDomainModel()
        
        photo.smallUrl = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/47168505/1/?bust=1579961545&width=100"
        photo.mediumUrl = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/47168505/1/?bust=1579961545&width=300"
        photo.largeUrl = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/47168505/1/?bust=1579961545&width=600"

        animal1.id = 1
        animal1.organization_id = "I want a pet"
        animal1.photos.append(photo)
        
        petModelDomain.animals.append(animal1)
        
        remoteRequestHandler?.onPetsRetrieved(petModelDomain)
    }
    
    func retrieveOrganitzations() {
        let organitzationsDomainModel = OrganizationsDomainModel()
        let organitzationVM = OrganitzationViewModel()
        organitzationVM.name = "Catalana Occidente Sant Cugat"
        organitzationVM.address.address1 = "Av. Alcalde Barnils, 63, 08174 Sant Cugat del Vallès, Barcelona"
        organitzationsDomainModel.organitzations.append(organitzationVM)
        remoteRequestHandler?.onSuccessOrganizations(organitzationsDomainModel)
    }
    
}
