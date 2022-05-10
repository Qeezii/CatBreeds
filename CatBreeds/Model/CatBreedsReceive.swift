//
//  CatBreedsReceive.swift
//  CatBreeds
//
//  Created by Alexey Poletaev on 08.05.2022.
//

import Foundation
import NetworkReceive

final class CatBreedsReceive {
    private var networkReceive: NetworkReceive
    
    init(networkReceive: NetworkReceive) {
        self.networkReceive = networkReceive
    }
    
    func getCatBreedsReceive(for url: URL, complition: @escaping ([CatBreedsResponse]) -> () ) {
        networkReceive.fetch([CatBreedsResponse].self, for: url) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    complition(response)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
