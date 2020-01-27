//
//  EndPointTesting.swift
//  PetiOSShotlTests
//
//  Created by IVAN on 25/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import XCTest
@testable import PetiOSShotl

class EndPointTesting: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatEndPointFetchPetsIsGeneratedCorrectly() {
        let expectedEndpointUrl = "https://api.petfinder.com/v2/animals"
        assert(expectedEndpointUrl == Endpoints.Pets.pets.url)
        
    }
    
    func testThatEndPointFetchOrganitzationsIsGeneratedCorrectly() {
        let expectedEndpointUrl = "https://api.petfinder.com/v2/organizations"
        assert(expectedEndpointUrl == Endpoints.Pets.organitzations.url)
        
    }

    func testThatEndPointFetchTokenIsGeneratedCorrectly() {
        let expectedEndpointUrl = "https://api.petfinder.com/v2/oauth2/token"
        assert(expectedEndpointUrl == Endpoints.Pets.token.url)
           
    }

}
