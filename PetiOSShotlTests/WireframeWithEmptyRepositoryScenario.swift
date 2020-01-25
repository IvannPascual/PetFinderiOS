//
//  WireframeWithEmptyRepositoryScenario.swift
//  PetiOSShotlTests
//
//  Created by IVAN on 24/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
import Foundation
@testable import PetiOSShotl
import UIKit
class WireframeWithEmptyRepositoryScenario {
    
    static func creatPetListModule() -> UIViewController {
        return UIViewController()
    }
    
    var presenter:PetListPresenter?
    var interactor: PetListInteractor?
    var outputInteractorProtocol: PetListInteractorOutputProtocol?
    var fakeOutputRemoteDataSource: PetRemoteDataSourceOutputMock?
    var remoteTokenProvider: RemoteTokenProvider?
    var remoteDataManager: RemotePetDataSourceMockWithEmptyList?
    var petListView:PetListView
    var wireFrame: ListOfPetsWireframe?

    init() {
        petListView = PetListView(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    func creatPetListModule() -> UIViewController {
        //real dependencies and subjects under test
        petListView = PetListView(collectionViewLayout: UICollectionViewFlowLayout())
        presenter = PetListPresenter()
        interactor = PetListInteractor()
        wireFrame = ListOfPetsWireframe()

        //fake dependencies
        remoteDataManager = RemotePetDataSourceMockWithEmptyList()

        
        petListView.presenter = presenter
        presenter?.view = petListView
        presenter?.wireFrame = wireFrame
        presenter?.interactor = interactor
        interactor?.presenter = presenter
        interactor?.remoteDatamanager = remoteDataManager
        remoteDataManager?.remoteRequestHandler = interactor
        
        return petListView

    }
    


   
}
