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
    var listOfOrganitzations = OrganizationsDomainModel()
    
    private init() { }
    
    func saveToken(token: String ) {
        self.token = token
        
    }
    
    func saveOrganitzationsViewModel(_ organitzations: OrganizationsDomainModel) {
        self.listOfOrganitzations = OrganizationsDomainModel()
        listOfOrganitzations = organitzations
    }
    
    func retrieveOrgranitzations()-> OrganizationsDomainModel {
        return self.listOfOrganitzations
    }
    
    func provideStoredToken()->String {
        return self.token
    }
    
}
