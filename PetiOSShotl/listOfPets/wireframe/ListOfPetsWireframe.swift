//
//  ListOfPetsWireframe.swift
//  PetiOSShotl
//
//  Created by IVAN on 21/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
import UIKit
class ListOfPetsWireframe: PetListWireFrameProtocol {
    
   
    var petListView = PetListView(collectionViewLayout: UICollectionViewFlowLayout())
    var presenter: PetListPresenterProtocol & PetListInteractorOutputProtocol
    var interactor: PetListInteractorInputProtocol & PetListRemoteDataManagerOutputProtocol
    var remoteDataManager: PetListRemoteDataManagerInputProtocol
    var remoteTokenProvider: RemoteTokenProvider

    init() {
       presenter = PetListPresenter()
       interactor = PetListInteractor()
       remoteTokenProvider = RemoteTokenProvider()
       remoteDataManager = PetListRemoteDataManager(remoteTokenProvider: remoteTokenProvider)
    }
    
    
    func creatPetListModule() -> UIViewController {
        
        
        let wireFrame: PetListWireFrameProtocol = ListOfPetsWireframe()
        let layout = UICollectionViewFlowLayout()
        self.petListView = PetListView(collectionViewLayout: layout)
        
     
        self.presenter = PetListPresenter()
        self.interactor = PetListInteractor()
        self.remoteTokenProvider = RemoteTokenProvider()
        self.remoteDataManager = PetListRemoteDataManager(remoteTokenProvider: remoteTokenProvider)


        self.petListView.presenter = presenter
        self.presenter.view = self.petListView
        self.presenter.wireFrame = wireFrame
        self.presenter.interactor = self.interactor
        self.interactor.presenter = self.presenter
        self.interactor.remoteDatamanager = self.remoteDataManager
        self.remoteDataManager.remoteRequestHandler = self.interactor
        
        return self.petListView

    }
    
}
