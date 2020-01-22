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
    static func creatPetListModule() -> UIViewController {
        let layout = UICollectionViewFlowLayout()
        let petListView = PetListView(collectionViewLayout: layout)
        
     
        let presenter: PetListPresenterProtocol & PetListInteractorOutputProtocol = PetListPresenter()
        let interactor: PetListInteractorInputProtocol & PetListRemoteDataManagerOutputProtocol = PetListInteractor()
        let remoteTokenProvider: RemoteTokenProvider = RemoteTokenProvider()
        let remoteDataManager: PetListRemoteDataManagerInputProtocol = PetListRemoteDataManager(remoteTokenProvider: remoteTokenProvider)

        let wireFrame: PetListWireFrameProtocol = ListOfPetsWireframe()

        
        
        petListView.presenter = presenter
        presenter.view = petListView
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return petListView

    }
    
    
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    
    
}
