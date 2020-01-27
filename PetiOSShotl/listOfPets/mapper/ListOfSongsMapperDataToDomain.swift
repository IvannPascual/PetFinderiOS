//
//  ListOfSongsMapperDataToDomain.swift
//  PetiOSShotl
//
//  Created by IVAN on 24/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation


class ListOfSongsMapperDataToDomain {
    
    static func mapPetDataModelToPetDomainModel(petModel: PetModelResponse)-> PetModelDomain? {
        
        let petModelDomain = PetModelDomain()
        guard let animalsListDataModel = petModel.animals else { return nil }
        for animal in animalsListDataModel {
            var animalDomainModel = AnimalDomainModel()
            var arrayPhotosDomainModel = [PhotoDomainModel]()
            var photoDomainModel = PhotoDomainModel()
            
            animalDomainModel.id = animal.id
            animalDomainModel.organization_id = animal.organization_id
            animalDomainModel.species = animal.species
            animalDomainModel.type = animal.type
            animalDomainModel.url = animal.url
            
            photoDomainModel.largeUrl = animal.photos?.first?.largeUrl ?? ""
            photoDomainModel.mediumUrl = animal.photos?.first?.mediumUrl ?? ""
            photoDomainModel.smallUrl = animal.photos?.first?.smallUrl ?? ""
            arrayPhotosDomainModel.append(photoDomainModel)
            
            animalDomainModel.photos = arrayPhotosDomainModel
            
            petModelDomain.animals.append(animalDomainModel)

        }
        return petModelDomain
    }

    
    
}
