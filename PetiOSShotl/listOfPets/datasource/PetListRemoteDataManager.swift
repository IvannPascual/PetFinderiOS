//
//  PetListRemoteDataManager.swift
//  PetiOSShotl
//
//  Created by IVAN on 21/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class PetListRemoteDataManager:PetListRemoteDataManagerInputProtocol, RemoteTokenDelegate {
    
    var remoteTokenProvider: RemoteTokenProvider?
    var remoteRequestHandler: PetListRemoteDataManagerOutputProtocol?

    init (remoteTokenProvider: RemoteTokenProvider) {
        self.remoteTokenProvider = remoteTokenProvider
        self.remoteTokenProvider?.setAsDelegate(remoteTokenDelegate: self)
    }
    
    func retrievePetList() {
        self.remoteTokenProvider?.retrieveToken(APICalls.getPets)
    }
    
    func retrieveOrganitzations() {
        self.remoteTokenProvider?.retrieveToken(APICalls.getOrganitzations)
    }
    
    func onErrorTokenLoading(_ message: String) {
        self.remoteRequestHandler?.onErrorToken(message)
    }
    
    func canLoadPets(_ token: Token) {
         let bearer = "Bearer "
        let parameters = ["limit":"20"]
        let authBearer = "\(bearer) \(token.access_token)"
        let authHeader = ["Authorization": authBearer]

        Alamofire.request(Endpoints.Pets.fetch.url, method: .get
            , parameters: parameters, encoding: URLEncoding.default, headers: authHeader).responseObject { (response: DataResponse<PetModelResponse>) in
                switch response.result {
                case let .success(pets):
                   self.remoteRequestHandler?.onPetsRetrieved([pets])
                case let .failure(error):
                    #if DEBUG
                        self.remoteRequestHandler?.onErrorRetrievingPets(ErrorApiCalls.ErrorWhenCallEndpointPets)
                    #else
                        self.remoteRequestHandler?.onErrorRetrievingPets(ErrorApiCalls.DefaultError)
                    #endif
                }
        }
     }
     
     func canLoadOrganitzations(_ token: Token) {
          let bearer = "Bearer "
          let limitOfOrganizations = "30"
          let newYorkCoordinates = "40.778532, -73.957451"
          let parameters = ["location":newYorkCoordinates,
                            "limit": limitOfOrganizations]
          let authBearer = "\(bearer) \(token.access_token)"
          let authHeader = ["Authorization": authBearer]
                
            Alamofire.request(Endpoints.Pets.organitzations.url, method: .get
                , parameters: parameters, encoding: URLEncoding.default, headers: authHeader).responseObject { (response: DataResponse<Organizations>) in
                    switch response.result {
                    case let .success(organizations):
                        dump(organizations)
                        self.remoteRequestHandler?.onSuccessOrganizations(organizations)
                    case let .failure(error):
                           dump(error)
                           #if DEBUG
                                self.remoteRequestHandler?.onErrorRetrievingPets(ErrorApiCalls.ErrorWhenCallEndpointOrganitzations)
                            #else
                                 self.remoteRequestHandler?.onErrorRetrievingPets(ErrorApiCalls.DefaultError)
                           #endif
                    }
            }
      }
     
    
}
