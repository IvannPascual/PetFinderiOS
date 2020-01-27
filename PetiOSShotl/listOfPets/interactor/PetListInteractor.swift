//
//  PetListInteractor.swift
//  PetiOSShotl
//
//  Created by IVAN on 21/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation

class PetListInteractor: PetListInteractorInputProtocol {
    
    weak var presenter: PetListInteractorOutputProtocol?
    var remoteDatamanager: PetListRemoteDataManagerInputProtocol?

    func retrievePetList() {
        remoteDatamanager?.retrievePetList()
    }
    
    func retrieveOrganizations() {
        remoteDatamanager?.retrieveOrganitzations()
    }
}

extension PetListInteractor: PetListRemoteDataManagerOutputProtocol {
    
    func onPetsRetrieved(_ pets: PetModelDomain) {
         presenter?.didRetrievePets(pets)
    }
    
    func onSuccessOrganizations(_ organizations: OrganizationsDomainModel) {
        UserDataManager.shared.saveOrganitzationsViewModel(organizations)
        presenter?.didRetrieveOrganizations()
    }
    
    func onErrorRetrievingPets(_ message: String) {
        presenter?.onErrorRetrievingPets(message)
    }
    
    func onErrorToken(_ message: String) {
        presenter?.onErrorRetrievingToken(message)
    }
    
    func onErrorOrganizations(_ message: String) {
        UserDataManager.shared.saveOrganitzationsViewModel(OrganizationsDomainModel())
        presenter?.onErrorRetrievingOrganization(message)
    }
    
}
