//
//  RemoteTokenProvider.swift
//  PetiOSShotl
//
//  Created by IVAN on 22/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation
import Alamofire
class RemoteTokenProvider  {
    var remoteTokenDelegate: RemoteTokenDelegate?
    
    func setAsDelegate (remoteTokenDelegate: RemoteTokenDelegate) {
        self.remoteTokenDelegate = remoteTokenDelegate
    }
    
    func retrieveToken(_ apiCallType: String) {
        let parameters = ["grant_type": Credentials.clientCredentials,
                          "client_id":  Credentials.clientId,
                          "client_secret": Credentials.secretId]
            Alamofire.request(Endpoints.Pets.token.url, method: .post
                , parameters: parameters, encoding: URLEncoding.default).responseObject { (response: DataResponse<Token>) in
                    switch response.result {
                    case let .success(token):
                        self.delegateResponsePerType(token, with: apiCallType)
                    case let .failure(error):
                        #if DEBUG
                            self.remoteTokenDelegate?.onErrorTokenLoading(ErrorApiCalls.ErrorWhenCallEndpointToken)
                        #else
                             self.remoteRequestHandler?.onErrorRetrievingPets(ErrorApiCalls.DefaultError)
                        #endif
                    }
            }
    }
    
    func delegateResponsePerType(_ token: Token, with type: APICalls.responseToApiCallType) {
        if (type == APICalls.getPets) {
            self.remoteTokenDelegate?.canLoadPets(token)
        } else if (type == APICalls.getOrganitzations) {
            self.remoteTokenDelegate?.canLoadOrganitzations(token)
        }
    }
}

