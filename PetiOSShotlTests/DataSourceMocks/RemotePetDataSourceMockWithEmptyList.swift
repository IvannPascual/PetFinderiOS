//
//  RemotePetDataSourceMockWithEmptyList.swift
//  PetiOSShotlTests
//
//  Created by IVAN on 24/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
@testable import PetiOSShotl

class RemotePetDataSourceMockWithEmptyList: PetListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: PetListRemoteDataManagerOutputProtocol?
    
    func retrievePetList() {
        remoteRequestHandler?.onPetsRetrieved(PetModelDomain())
    }
    
    func retrieveOrganitzations() {
        remoteRequestHandler?.onSuccessOrganizations(OrganizationsDomainModel())
    }
    
}
