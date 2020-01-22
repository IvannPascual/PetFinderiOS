//
//  PetListPresenter.swift
//  PetiOSShotl
//
//  Created by IVAN on 21/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation

class PetListPresenter: PetListPresenterProtocol {

    
    weak var view: PetListViewProtocol?
    var interactor: PetListInteractorInputProtocol?
    var wireFrame: PetListWireFrameProtocol?
    
    func retrievePets() {
        view?.showLoading()
        interactor?.retrievePetList()
    }
    
    func retrieveOrganizations() {
        view?.showLoading()
        interactor?.retrieveOrganizations()
    }
    


}

extension PetListPresenter: PetListInteractorOutputProtocol {
  
    func didRetrievePets(_ pets: [PetModelResponse]) {
        view?.hideLoading()
        view?.showPets(with: pets)
    }
    
    func didRetrieveOrganizations() {
        view?.hideLoading()
        view?.showOrganizations()
    }
    
    func onErrorRetrievingPets(_ message: String) {
        view?.hideLoading()
        view?.showError(message)
    }
      
    func onErrorRetrievingToken(_ message: String) {
        view?.hideLoading()
        view?.showError(message)
    }
      
    func onErrorRetrievingOrganization(_ message: String) {
        view?.hideLoading()
        view?.showError(message)
    }
    
}
