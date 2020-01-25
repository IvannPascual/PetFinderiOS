//
//  PetiOSShotlTests.swift
//  PetiOSShotlTests
//
//  Created by IVAN on 21/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import XCTest
@testable import PetiOSShotl
import PKHUD

class PetiOSShotlTests: AcceptanceTestCase {

    
    override func setUp() {
        
        
    }

    override func tearDown() {
        
    }

    // test end to end scenario
    func testThatGivenAEmptyResponseCode200WithNoPetsTheListOfPetsInViewControllerIsEmpty() {
        let NoPetsRetrievedByTheServer = 0
        let listOfPetsViewController = givenARealScenarioWithAFakeEmptyDataSourceOfPets()
        tester().waitForAnimationsToFinish()
        
        assert(listOfPetsViewController.petListViewModel.pets.animals.count == NoPetsRetrievedByTheServer)
        assert(listOfPetsViewController.petListViewModel.errorMessage == " ")

        sleep(3)
    }

    //test ent to end scenario
    func testThatGivenAEmptyResponseCode200WithNoOrganitzationsTheListOfOrganitzationsInDatamanagerIsEmpty() {
        let listOfPetsViewController = givenARealScenarioWithAFakeEmptyDataSourceOfPets()
        tester().waitForAnimationsToFinish()
        
        assert(UserDataManager.shared.listOfOrganitzations.organitzations.count == 0)
        assert(listOfPetsViewController.petListViewModel.errorMessage == " ")
        
        sleep(3)
    }
    
    // test end to end scenario
       func testThatGivenAError500ServerTheListOfPetsInViewControllerShowsMessageOfError() {
           let NoPetsRetrievedByTheServer = 0
           let listOfPetsViewController = givenARealScenarioWithAErrorServerResponseDataSource()
        
           tester().waitForAnimationsToFinish()
           assert(listOfPetsViewController.petListViewModel.pets.animals.count == NoPetsRetrievedByTheServer)
           assert(listOfPetsViewController.petListViewModel.errorMessage == RemotePetDataSourceMockWithServerError.errorServer500)
         
           sleep(3)
       }
    
    // test end to end scenario
    func testGivenACorrectReponse200OfGetPetsCallToTheServerWithOneElementInJson() {
        let onePetRecievedInServerCall = 1
        let listOfPetsViewController = givenARealScenarioWithOneElementJsonInTheCallToTheServer()
          
        tester().waitForAnimationsToFinish()
        
        assert(listOfPetsViewController.petListViewModel.pets.animals.count == onePetRecievedInServerCall)
        assert(listOfPetsViewController.petListViewModel.errorMessage != RemotePetDataSourceMockWithServerError.errorServer500)
        assert(listOfPetsViewController.petListViewModel.errorMessage == " ")
        
        sleep(3)
    }
    
    func testThatWhenACorrectReponse200OfGetOrganitzationsWithOneElementJsonTheMapViewScreenIsOpenedAndDataIsCorrect() {
        let oneOrganitzationsIsReceivedByTheServer = 1
        let nameOfOrganitzationThatServerResponse = "Catalana Occidente Sant Cugat"
        let adressOfOrganitzationThatServerResponse = "Av. Alcalde Barnils, 63, 08174 Sant Cugat del Vallès, Barcelona"

        let listOfPetsViewController = givenARealScenarioWithOneElementJsonInTheCallToTheServer()
        listOfPetsViewController.presenter?.retrieveOrganizations()
        tester().waitForAnimationsToFinish()

         
         assert(UserDataManager.shared.listOfOrganitzations.organitzations.count == oneOrganitzationsIsReceivedByTheServer)
         assert(UserDataManager.shared.listOfOrganitzations.organitzations.first?.address.address1 == adressOfOrganitzationThatServerResponse)
         assert(UserDataManager.shared.listOfOrganitzations.organitzations.first?.name == nameOfOrganitzationThatServerResponse)

         assert(listOfPetsViewController.petListViewModel.errorMessage == " ")

    }
    
    func testThatWhenAErrorServerReponse500OfGetOrganitzationsTheMapViewScreenIsNotOpened() {
           let errorCallWithNoElements = 0
           let listOfPetsViewController = givenARealScenarioWithAErrorServerResponseDataSource()
           listOfPetsViewController.presenter?.retrieveOrganizations()
           
            tester().waitForAnimationsToFinish()
         
            assert(UserDataManager.shared.listOfOrganitzations.organitzations.count == errorCallWithNoElements)
            assert(listOfPetsViewController.petListViewModel.errorMessage == RemotePetDataSourceMockWithServerError.errorServer500)
            
       }
    
    
    private func givenARealScenarioWithAFakeEmptyDataSourceOfPets()-> PetListView {
        //Given the real scenario wireframe
        let wireframe = ListOfPetsWireframe()
        let listOfPetsViewController = wireframe.creatPetListModule() as! PetListView

        //inject a "fake Datasource to simulate a correct call with no pets and response 200 of the server"
        let interactor = listOfPetsViewController.presenter?.interactor!
        interactor?.remoteDatamanager = RemotePetDataSourceMockWithEmptyList()
        interactor?.remoteDatamanager?.remoteRequestHandler = interactor as? PetListRemoteDataManagerOutputProtocol
        
        
        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [listOfPetsViewController]
        present(viewController: rootViewController)
        
        return listOfPetsViewController
    }

    private func givenARealScenarioWithAErrorServerResponseDataSource()->PetListView {
        
        //Given the real scenario wireframe
        let wireframe = ListOfPetsWireframe()
        let listOfPetsViewController = wireframe.creatPetListModule() as! PetListView
        
        //inject a "fake Datasource to simulate an server error response 500 of the server"
        let interactor = listOfPetsViewController.presenter?.interactor!
        interactor?.remoteDatamanager = RemotePetDataSourceMockWithServerError()
        interactor?.remoteDatamanager?.remoteRequestHandler = interactor as? PetListRemoteDataManagerOutputProtocol
               
        let rootViewController = UINavigationController()
        rootViewController.viewControllers = [listOfPetsViewController]
        present(viewController: rootViewController)
        
        return listOfPetsViewController
    }
    
    private func givenARealScenarioWithOneElementJsonInTheCallToTheServer()->PetListView {
           
           //Given the real scenario wireframe
           let wireframe = ListOfPetsWireframe()
           let listOfPetsViewController = wireframe.creatPetListModule() as! PetListView
          
           //inject a "fake Datasource to simulate a correct call to server with 1 element in the json of each call "
           let interactor = listOfPetsViewController.presenter?.interactor!
           interactor?.remoteDatamanager = RemotePetDataSourceWithFillListOfData()
           interactor?.remoteDatamanager?.remoteRequestHandler = interactor as? PetListRemoteDataManagerOutputProtocol
                  
           let rootViewController = UINavigationController()
           rootViewController.viewControllers = [listOfPetsViewController]
           present(viewController: rootViewController)
           
           return listOfPetsViewController
       }
    
    private func sleepForTest(seconds: UInt32) {
        do {
            sleep(seconds)
        }
    }

    
    
    
}
