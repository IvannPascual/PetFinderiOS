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
        assert(listOfPetsViewController.petListViewModel.messageError == " ")

    }

    //test ent to end scenario
    func testThatGivenAEmptyResponseCode200WithNoOrganitzationsTheListOfOrganitzationsInDatamanagerIsEmpty() {
        let listOfPetsViewController = givenARealScenarioWithAFakeEmptyDataSourceOfPets()
        tester().waitForAnimationsToFinish()
        assert(UserDataManager.shared.listOfOrganitzations.organitzations.count == 0)
    }
    
    // test end to end scenario
       func testThatGivenAError500ServerTheListOfPetsInViewControllerShowsMessageOfError() {
           let NoPetsRetrievedByTheServer = 0
           let listOfPetsViewController = givenARealScenarioWithAErrorServerResponseDataSource()
        
           tester().waitForAnimationsToFinish()
           assert(listOfPetsViewController.petListViewModel.pets.animals.count == NoPetsRetrievedByTheServer)
           assert(listOfPetsViewController.petListViewModel.messageError == RemotePetDataSourceMockWithServerError.errorServer500)

       }
    
    // test end to end scenario
    func testGivenACorrectReponse200OfGetPetsCallToTheServerWithOneElementInJson() {
         let onePetRecievedInServerCall = 1
         let listOfPetsViewController = givenARealScenarioWithOneElementJsonInTheCallToTheServer()
          
         tester().waitForAnimationsToFinish()
         assert(listOfPetsViewController.petListViewModel.pets.animals.count == onePetRecievedInServerCall)
         assert(listOfPetsViewController.petListViewModel.messageError != RemotePetDataSourceMockWithServerError.errorServer500)
        assert(listOfPetsViewController.petListViewModel.messageError == " ")

    }
    
    
    

    func givenARealScenarioWithAFakeEmptyDataSourceOfPets()-> PetListView {
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

    func givenARealScenarioWithAErrorServerResponseDataSource()->PetListView {
        
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
    
    func givenARealScenarioWithOneElementJsonInTheCallToTheServer()->PetListView {
           
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

    
    
    
}
