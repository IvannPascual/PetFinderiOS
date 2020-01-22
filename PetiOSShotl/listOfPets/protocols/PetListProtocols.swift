//
//  PetListProtocols.swift
//  PetiOSShotl
//
//  Created by IVAN on 21/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
import UIKit
// PRESENTER -> VIEW
protocol PetListViewProtocol: class {
    var presenter: PetListPresenterProtocol? { get set }
    
    func showPets(with pet: [PetModelResponse])
    func showOrganizations()

    func showError(_ message: String)
    func showLoading()

    func hideLoading()
}

// PRESENTER -> WIREFRAME
protocol PetListWireFrameProtocol: class {
    static func creatPetListModule() -> UIViewController
}

// VIEW -> PRESENTER
protocol PetListPresenterProtocol: class {
    var view: PetListViewProtocol? { get set }
    var interactor: PetListInteractorInputProtocol? { get set }
    var wireFrame: PetListWireFrameProtocol? { get set }
    
    func retrievePets()
    func retrieveOrganizations()
}

// INTERACTOR -> PRESENTER
protocol PetListInteractorOutputProtocol: class {
    func didRetrievePets(_ pets: [PetModelResponse])
    func didRetrieveOrganizations()
    func onErrorRetrievingPets(_ message: String)
    func onErrorRetrievingToken(_ message: String)
    func onErrorRetrievingOrganization(_ message: String)
}

// PRESENTER -> INTERACTOR
protocol PetListInteractorInputProtocol: class {
    var presenter: PetListInteractorOutputProtocol? { get set }
    var remoteDatamanager: PetListRemoteDataManagerInputProtocol? { get set }
    
    func retrievePetList()
    func retrieveOrganizations()
}

// INTERACTOR -> DATAMANAGER
protocol PetListDataManagerInputProtocol: class {

}

// INTERACTOR -> REMOTEDATAMANAGER
protocol PetListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: PetListRemoteDataManagerOutputProtocol? { get set }
    
    func retrievePetList()
    func retrieveOrganitzations()
}

// REMOTEDATAMANAGER -> INTERACTOR
protocol PetListRemoteDataManagerOutputProtocol: class {
    func onPetsRetrieved(_ posts: [PetModelResponse])
    func onErrorRetrievingPets(_ message: String)
    func onErrorToken(_ message: String)
    func onSuccessOrganizations(_ organizations: Organizations)
    func onErrorOrganizations(_ message: String)
}

