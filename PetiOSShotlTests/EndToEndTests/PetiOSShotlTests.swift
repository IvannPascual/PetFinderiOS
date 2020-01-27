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

    func testThatGivenAEmptyResponseCode200WithNoPetsTheListOfPetsInViewControllerIsEmpty() {
        let NoPetsRetrievedByTheServer = 0
        //given a fake datasource with correct response 200 of the server
        let listOfPetsViewController = givenARealScenarioWithAFakeEmptyDataSourceOfPets()
        
        //when fetch pets is called
        listOfPetsViewController.presenter?.retrieveOrganizations()
        tester().waitForAnimationsToFinish()

        // in the viewcontroller no appear error alert and the list of pets int the viewModel is empty
        assert(listOfPetsViewController.petListViewModel.pets.animals.count == NoPetsRetrievedByTheServer)
        assert(listOfPetsViewController.petListViewModel.errorMessage == " ")

        sleep(3)
    }

    func testThatGivenAEmptyResponseCode200WithNoOrganitzationsTheListOfOrganitzationsInDatamanagerIsEmpty() {
        let listOfPetsViewController = givenARealScenarioWithAFakeEmptyDataSourceOfPets()
        //given a fake datasource with correct response 200 of the server
        
        //when fetch organitzations is called
        listOfPetsViewController.presenter?.retrieveOrganizations()
        tester().waitForAnimationsToFinish()

        // in the viewcontroller no appear error alert and the list of organitzations in Datamanager Singleton is empty
        assert(UserDataManager.shared.listOfOrganitzations.organitzations.count == 0)
        assert(listOfPetsViewController.petListViewModel.errorMessage == " ")
        
        sleep(3)
    }
    
    // test end to end scenario
    func testThatGivenAError500ServerTheListOfPetsInViewControllerShowsMessageOfError() {
        let NoPetsRetrievedByTheServer = 0
        
        //given a fake datasource with correct response 500 of the server
        let listOfPetsViewController = givenARealScenarioWithAErrorServerResponseDataSource()
        
        //when fetch pets is called
        listOfPetsViewController.presenter?.retrievePets()
        tester().waitForAnimationsToFinish()
        
        //in the viewcontroller appear an error alert and the list of pets in the viewModel is empty
        assert(listOfPetsViewController.petListViewModel.pets.animals.count == NoPetsRetrievedByTheServer)
        assert(listOfPetsViewController.petListViewModel.errorMessage == RemotePetDataSourceMockWithServerError.errorServer500)
         
        sleep(3)
        
       }
    
    // test end to end scenario
    func testGivenACorrectReponse200OfGetPetsCallToTheServerWithOneElementInJson() {
        let onePetRecievedInServerCall = 1
        let photoUrlJsonResponse = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/47168505/1/?bust=1579961545&width=100"
        
        //given a fake datasource with correct response 200 of the server and json with one pet in the response data
        let listOfPetsViewController = givenARealScenarioWithOneElementJsonInTheCallToTheServer()
        
        //when fetch pets is called
        listOfPetsViewController.presenter?.retrievePets()
        tester().waitForAnimationsToFinish()
        
        //in the viewcontroller no appear an error alert and the list of pets in the viewModel has the item of the json
        assert(listOfPetsViewController.petListViewModel.pets.animals.count == onePetRecievedInServerCall)
        assert(listOfPetsViewController.petListViewModel.pets.animals.first?.photos.first?.smallUrl == photoUrlJsonResponse)
        assert(listOfPetsViewController.petListViewModel.errorMessage == " ")
        
        sleep(3)
    }
    
    func testThatWhenACorrectReponse200OfGetOrganitzationsWithOneElementJsonTheMapViewScreenIsOpenedAndDataIsCorrect() {
        let oneOrganitzationsIsReceivedByTheServer = 1
        let nameOfOrganitzationThatServerResponse = "Catalana Occidente Sant Cugat"
        let adressOfOrganitzationThatServerResponse = "Av. Alcalde Barnils, 63, 08174 Sant Cugat del Vallès, Barcelona"

        //given a fake datasource with correct response 200 of the server and json with one organitzation in the response data
        let listOfPetsViewController = givenARealScenarioWithOneElementJsonInTheCallToTheServer()
        
        // when retrieve organitzations is called
        listOfPetsViewController.presenter?.retrieveOrganizations()
        tester().waitForAnimationsToFinish()

         //in the viewcontroller no appear an error alert and the list of organitzations in the dataManager singleton appears the same data of the json
         assert(UserDataManager.shared.listOfOrganitzations.organitzations.count == oneOrganitzationsIsReceivedByTheServer)
         assert(UserDataManager.shared.listOfOrganitzations.organitzations.first?.address.address1 == adressOfOrganitzationThatServerResponse)
         assert(UserDataManager.shared.listOfOrganitzations.organitzations.first?.name == nameOfOrganitzationThatServerResponse)

         assert(listOfPetsViewController.petListViewModel.errorMessage == " ")

    }
    
    func testThatWhenAErrorServerReponse500OfGetOrganitzationsTheMapViewScreenIsNotOpened() {
        let errorCallWithNoElements = 0
        
        //given a fake datasource with correct response 500 of the server
        let listOfPetsViewController = givenARealScenarioWithAErrorServerResponseDataSource()
        
        // when retrieve organitzations is called
        listOfPetsViewController.presenter?.retrieveOrganizations()
        tester().waitForAnimationsToFinish()
            
        //in the viewcontroller  appear an error alert and the list of organitzations in the dataManager singleton not have data
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
