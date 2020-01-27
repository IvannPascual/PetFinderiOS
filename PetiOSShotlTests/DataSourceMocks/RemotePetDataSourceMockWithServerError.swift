//
//  RemotePetDataSourceMockWithServerError.swift
//  PetiOSShotlTests
//
//  Created by IVAN on 25/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
@testable import PetiOSShotl

class RemotePetDataSourceMockWithServerError: PetListRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: PetListRemoteDataManagerOutputProtocol?
    static let errorServer500 = "error500"
    
    func retrievePetList() {
        remoteRequestHandler?.onErrorRetrievingPets(RemotePetDataSourceMockWithServerError.errorServer500)
    }
    
    func retrieveOrganitzations() {
        remoteRequestHandler?.onErrorOrganizations(RemotePetDataSourceMockWithServerError.errorServer500)
    }
    
}
