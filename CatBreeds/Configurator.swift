//
//  Configurator.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 08.05.2022.
//

import Foundation
import ServiceLocator
import NetworkReceive

final class Configurator {
    
    static let shared = Configurator()
    
    func register() {
        ServiceLocator.shared.addServices(service: NetworkReceive())
    }
}
