//
//  PetRemoteDataSourceOutputMock.swift
//  PetiOSShotlTests
//
//  Created by IVAN on 24/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
@testable  import PetiOSShotl
class PetRemoteDataSourceOutputMock: PetListRemoteDataManagerOutputProtocol  {
   
    init() {
        
    }
    
    var onPetsRetrievedIsCalled = 0
    var onErrorRetrievingPetsIsCalled = 0
    var onErrorTokenIsCalled = 0
    var onSuccessOrganizationsIsCalled = 0
    var onErrorOrganizationsIsCalled = 0
    
    
    func onPetsRetrieved(_ posts: PetModelDomain) {
        onPetsRetrievedIsCalled = onPetsRetrievedIsCalled + 1
    }
    
    func onErrorRetrievingPets(_ message: String) {
        onErrorRetrievingPetsIsCalled = onErrorRetrievingPetsIsCalled + 1
    }
    
    func onErrorToken(_ message: String) {
        onErrorTokenIsCalled = onErrorTokenIsCalled + 1
    }
    
    func onSuccessOrganizations(_ organizations: OrganizationsDomainModel) {
        onSuccessOrganizationsIsCalled = onSuccessOrganizationsIsCalled + 1
    }
    
    func onErrorOrganizations(_ message: String) {
        onErrorOrganizationsIsCalled = onErrorOrganizationsIsCalled + 1
    }
    
}
