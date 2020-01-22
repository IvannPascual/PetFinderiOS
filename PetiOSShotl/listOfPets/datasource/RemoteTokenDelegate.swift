//
//  RemoteTokenDelegate.swift
//  PetiOSShotl
//
//  Created by IVAN on 22/01/2020.
//  Copyright © 2020 IVAN. All rights reserved.
//

import Foundation

protocol RemoteTokenDelegate {
    func canLoadPets(_ token: Token)
    func canLoadOrganitzations(_ token: Token)
    func onErrorTokenLoading(_ message: String)
}
